if USE_INSTALLED_GLIB
included_glib_includes = @GLIB_CFLAGS@
pkg_config_LDADD=@GLIB_LIBS@
else
GLIB_SUBDIR = glib-1.2.10
included_glib_includes = -I./glib-1.2.10
pkg_config_LDADD=glib-1.2.10/libglib.la
endif
pkg_config_LDADD += popt/libpopt.la
popt_includes = -I./popt
SUBDIRS = $(GLIB_SUBDIR) popt check

m4dir = $(datadir)/aclocal
m4_DATA = pkg.m4

dist_doc_DATA = pkg-config-guide.html

man_MANS = pkg-config.1
EXTRA_DIST = $(m4_DATA) $(man_MANS) README.win32

bin_PROGRAMS = pkg-config
AM_CFLAGS=@WARN_CFLAGS@

INCLUDES=-DPKG_CONFIG_PC_PATH="\"$(pc_path)\"" $(included_glib_includes) \
	$(popt_includes)

pkg_config_SOURCES= \
	pkg.h \
	pkg.c \
	parse.h \
	parse.c \
	main.c \
	findme.c \
	findme.h
