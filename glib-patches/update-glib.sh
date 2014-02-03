#!/bin/sh

GIT=${GIT-git}
PATCH=${PATCH-patch}
SED=${SED-sed}
repo=
tag=2.38.2
commit=n

usage()
{
    cat << EOF
Usage:
 $0 [OPTIONS] REPO [TAG]
Fetch archive of TAGged version of glib from local checkout at REPO

Options:
 -c, --commit       commit snapshot after each change
 -h, --help         display this help and exit

If TAG is not specified, $tag is used
EOF
}

while [ -n "$1" ]; do
    case "$1" in
    -c|--commit)
        commit=y
        ;;
    -h|--help)
        usage
        exit
        ;;
    -*)
        echo "$0: unrecognized option '$1'" >&2
        echo "Try '$0 --help' for more information." >&2
        exit 1
        ;;
    *)
        # end of options
        break
        ;;
    esac
    shift
done

repo=$1
[ -z "$2" ] || tag=$2

# Remove previous snapshot
if [ -d glib ]; then
    echo "removing previous glib snapshot"
    rm -rf glib
fi

# Create new snapshot
echo "creating new snapshot of $repo tag $tag"
(cd "$repo" && $GIT archive --format=tar --prefix=glib/ "$tag") | \
    tar -xf - || exit $?
if [ $commit = y ]; then
    $GIT add glib
    $GIT commit -q \
        -m "glib: creating new snapshot of $repo tag $tag" -- glib
fi

# Prune parts we don't want
echo "removing unneeded directories and files"
rm -rf \
    glib/debian \
    glib/docs \
    glib/po \
    glib/tests \
    glib/glib/tests \
    glib/build \
    glib/gmodule \
    glib/gthread \
    glib/gobject \
    glib/gio \
    glib/glib/pcre \
    glib/glib/update-pcre
rm -f \
    glib/autogen.sh \
    glib/INSTALL.in \
    glib/README.commits \
    glib/HACKING \
    glib/NEWS \
    glib/NEWS.pre-1-3 \
    glib/README.win32 \
    glib/.dir-locals.el \
    glib/check-abis.sh \
    glib/config.h.win32.in \
    glib/glib-gettextize.in \
    glib/glib-tap.mk \
    glib/glib-zip.in \
    glib/sanity_check \
    glib/tap-test \
    glib/glib/glib.stp \
    glib/glib/glib_probes.d \
    glib/glib/glibconfig.h.win32.in \
    glib/glib/gregex.[ch] \
    glib/msvc_recommended_pragmas.h \
    glib/win32-fixup.pl \
    glib/glib/libglib-gdb.py.in
find glib -name 'makefile.msc*' | xargs rm -f
find glib -name 'ChangeLog*' | xargs rm -f
find glib -name '*.pc.in' | xargs rm -f
[ $commit = y ] && $GIT commit -q \
    -m "glib: removing unneeded directories and files" -- glib

# Apply patches
patches=`grep '^[^#]' glib-patches/patchlist 2>/dev/null`
for p in $patches; do
    echo "applying patch glib-patches/$p"
    $PATCH -p1 -i glib-patches/$p || exit $?
    [ $commit = y ] && $GIT commit -q \
        -m "glib: applying patch glib-patches/$p" -- glib
done

echo "snapshot successfully updated"
