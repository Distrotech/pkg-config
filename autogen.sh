#!/bin/sh
# Run this to generate all the initial makefiles, etc.

PROJECT=pkg-config
srcdir=`dirname "$0"`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

rm -r glib-1.2.10
gunzip --stdout glib-1.2.10.tar.gz | tar xf - || { 
    echo "glib tarball not unpacked"
    exit 1
}

chmod +w `find glib-1.2.10 -name Makefile.am`
perl -p -i.bak -e "s/lib_LTLIBRARIES/noinst_LTLIBRARIES/g" `find glib-1.2.10 -name Makefile.am`
perl -p -i.bak -e "s/bin_SCRIPTS/noinst_SCRIPTS/g" `find glib-1.2.10 -name Makefile.am`
perl -p -i.bak -e "s/include_HEADERS/noinst_HEADERS/g" `find glib-1.2.10 -name Makefile.am`
perl -p -i.bak -e "s/glibnoinst_HEADERS/noinst_HEADERS/g" `find glib-1.2.10 -name Makefile.am`
perl -p -i.bak -e 's/([a-zA-Z0-9]+)_DATA/noinst_DATA/g' `find glib-1.2.10 -name Makefile.am`
perl -p -i.bak -e "s/info_TEXINFOS/noinst_TEXINFOS/g" `find glib-1.2.10 -name Makefile.am`
perl -p -i.bak -e "s/man_MANS/noinst_MANS/g" `find glib-1.2.10 -name Makefile.am`

## patch gslist.c to have stable sort
perl -p -w -i.bak -e 's/if \(compare_func\(l1->data,l2->data\) < 0\)/if \(compare_func\(l1->data,l2->data\) <= 0\)/g' glib-1.2.10/gslist.c

# Update random auto* files to actually have something which have a snowball's
# chance in a hot place of working with modern auto* tools.

(cd glib-1.2.10 && for p in ../glib-patches/*.diff; do echo $p; patch -p1 < $p || exit 1; done ) || exit 1

# Rebuild the autotools for pkg-config and glib
${AUTORECONF-autoreconf} -iv || exit $?

cd $ORIGDIR

if [ -z "$NOCONFIGURE" ] && [ "$1" != --no-configure ]; then
    "$srcdir"/configure --enable-maintainer-mode "$@"
    echo 
    echo "Now type 'make' to compile $PROJECT."
else
    echo "Now type './configure && make' to compile $PROJECT."
fi
