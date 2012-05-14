#!/bin/sh
# Run this to generate all the initial makefiles, etc.

PROJECT=pkg-config
srcdir=`dirname "$0"`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

# Rebuild the autotools for pkg-config
${AUTORECONF-autoreconf} -iv || exit $?

cd $ORIGDIR

if [ -z "$NOCONFIGURE" ] && [ "$1" != --no-configure ]; then
    "$srcdir"/configure "$@"
    echo 
    echo "Now type 'make' to compile $PROJECT."
else
    echo "Now type './configure && make' to compile $PROJECT."
fi
