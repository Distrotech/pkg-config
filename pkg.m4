
dnl PKG_CHECK_MODULES(GSTUFF, gtk+-2.0 >= 1.3 glib = 1.3.4, action-if, action-not)
dnl defines GSTUFF_LIBS, GSTUFF_CFLAGS, see pkg-config man page
AC_DEFUN(PKG_CHECK_MODULES,
[
  succeeded=no

  if test -z "$PKG_CONFIG"; then
    AC_PATH_PROG(PKG_CONFIG, pkg-config, no)
  fi

  if test "$PKG_CONFIG" = "no" ; then
     echo "*** The pkg-config script could not be found. Make sure it is"
     echo "*** in your path, or set the PKG_CONFIG environment variable"
     echo "*** to the full path to pkg-config."
  else
     if ! $PKG_CONFIG --atleast-pkgconfig-version 0.6.0; then
        echo "*** Your version of pkg-config is too old. You need version 0.6.0 or newer."
     else
        AC_MSG_CHECKING(for $2)

        if $PKG_CONFIG --exists "$2" ; then
            AC_MSG_RESULT(yes)
            succeeded=yes

            AC_MSG_CHECKING($1_CFLAGS)
            $1_CFLAGS=`$PKG_CONFIG --cflags "$2"`
            AC_MSG_RESULT($$1_CFLAGS)

            AC_MSG_CHECKING($1_LIBS)
            $1_LIBS=`$PKG_CONFIG --libs "$2"
            AC_MSG_RESULT($$1_LIBS)
        else
            $1_CFLAGS=""
            $1_LIBS=""
            ## If we have a custom action on failure, don't print errors
            ifelse([$4], , $PKG_CONFIG --print-errors "$2",)
        fi

        AC_SUBST($1_CFLAGS)
        AC_SUBST($1_LIBS)
     fi
  fi

  if test $succeeded = yes; then
     ifelse([$3], , :, [$3])
  else
     ifelse([$4], , AC_MSG_ERROR([Library requirements ($2) not met; consider adjusting the PKG_CONFIG_PATH environment variable if your libraries are in a nonstandard prefix so pkg-config can find them.]), [$4])
  fi
])


dnl Check if the C compiler accepts a certain C flag, and if so adds it to
dnl CFLAGS
AC_DEFUN(PKG_CHECK_CFLAG, [
  AC_MSG_CHECKING(if C compiler accepts $1)
  save_CFLAGS="$CFLAGS"

  dnl make sure we add it only once
  dnl this one doesn't seem to work: *[\ \	]$1[\ \ ]*) ;;
  case " $CFLAGS " in
  *\ $1\ *) echo $ac_n "(already in CFLAGS) ... " ;;
  *\ $1\	*) echo $ac_n "(already in CFLAGS) ... " ;;
  *\	$1\ *) echo $ac_n "(already in CFLAGS) ... " ;;
  *\	$1\	*) echo $ac_n "(already in CFLAGS) ... " ;;
  *) CFLAGS="$CFLAGS $1" ;;
  esac

  AC_TRY_COMPILE([#include <stdio.h>], [printf("hello");],
	         [ AC_MSG_RESULT(yes)],dnl
	         [ CFLAGS="$save_CFLAGS" AC_MSG_RESULT(no) ])
])

dnl add $ACLOCAL_FLAGS (and optionally more dirs) to the aclocal
dnl commandline, so make can work even if it needs to rerun aclocal
AC_DEFUN(PKG_ACLOCALFLAGS,
[
  test -n "$ACLOCAL_FLAGS" && ACLOCAL="$ACLOCAL $ACLOCAL_FLAGS"

  for i in "$1"; do
    ACLOCAL="$ACLOCAL -I $i"
  done
])
