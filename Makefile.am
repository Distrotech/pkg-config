pkg_config_LDADD=@GLIB_LIBS@

if INTERNAL_GLIB
GLIB_SUBDIR = glib
endif

if USE_INSTALLED_POPT
pkg_config_LDADD += $(POPT_LIBS)
else
pkg_config_LDADD += popt/libpopt.la
popt_includes = -I$(top_srcdir)/popt
POPT_SUBDIR = popt
endif

SUBDIRS = $(GLIB_SUBDIR) $(POPT_SUBDIR) . check

m4dir = $(datadir)/aclocal
m4_DATA = pkg.m4

dist_doc_DATA = pkg-config-guide.html

man_MANS = pkg-config.1
EXTRA_DIST = $(m4_DATA) $(man_MANS) README.win32

bin_PROGRAMS = pkg-config
AM_CFLAGS=@WARN_CFLAGS@

if NATIVE_WIN32
INCLUDES= \
	-DPKG_CONFIG_PC_PATH="\"$(subst /,\/,$(pc_path))\"" \
	-DPKG_CONFIG_SYSTEM_INCLUDE_PATH="\"$(subst /,\/,$(system_include_path))\"" \
	-DPKG_CONFIG_SYSTEM_LIBRARY_PATH="\"$(subst /,\/,$(system_library_path))\"" \
	@GLIB_CFLAGS@ \
	$(popt_includes)
else
INCLUDES= \
	-DPKG_CONFIG_PC_PATH="\"$(pc_path)\"" \
	-DPKG_CONFIG_SYSTEM_INCLUDE_PATH="\"$(system_include_path)\"" \
	-DPKG_CONFIG_SYSTEM_LIBRARY_PATH="\"$(system_library_path)\"" \
	@GLIB_CFLAGS@ \
	$(popt_includes)
endif

pkg_config_SOURCES= \
	pkg.h \
	pkg.c \
	parse.h \
	parse.c \
	main.c
DISTCHECK_CONFIGURE_FLAGS = --with-installed-popt --with-internal-glib

# Override the normal dist so that we can make sure the glib subdir is
# configured first. Otherwise it will just bomb entering the directory.
dist dist-all: check-glib-Makefile
	@$(MAKE) $(AM_MAKEFLAGS) dist-gzip
check-glib-Makefile:
	@if test ! -f glib/Makefile; then \
	  echo $(SHELL) $(top_srcdir)/configure --with-internal-glib; \
	  $(SHELL) $(top_srcdir)/configure --with-internal-glib; \
	fi
