SUBDIRS = glib-1.2.8

m4dir = $(datadir)/aclocal
m4_DATA = pkg.m4

man_MANS = pkg-config.1
EXTRA_DIST = $(m4_DATA) $(man_MANS)

bin_PROGRAMS = pkg-config

INCLUDES=-DPKGLIBDIR="\"$(pkglibdir)\"" -I./glib-1.2.8

pkg_config_SOURCES= \
	pkg.h \
	pkg.c \
	partial-glib.h \
	partial-glib.c \
	parse.h \
	parse.c \
	main.c \
	findme.c \
	findme.h \
	popt.c \
	popt.h \
	poptconfig.c \
	popthelp.c \
	poptint.h \
	poptparse.c

pkg_config_LDADD=glib-1.2.8/libglib.la
