ACLOCAL_AMFLAGS = ${ACLOCAL_FLAGS}

pkg_config_LDADD=@GLIB_LIBS@

if INTERNAL_GLIB
GLIB_SUBDIR = glib
endif

SUBDIRS = $(GLIB_SUBDIR) . check

# normally we'd want glib to be part of DIST_SUBDIRS unconditionally,
# but distclean gets broken unless we always run glib's configure
DIST_SUBDIRS = $(GLIB_SUBDIR) . check

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
	@GLIB_CFLAGS@
else
INCLUDES= \
	-DPKG_CONFIG_PC_PATH="\"$(pc_path)\"" \
	-DPKG_CONFIG_SYSTEM_INCLUDE_PATH="\"$(system_include_path)\"" \
	-DPKG_CONFIG_SYSTEM_LIBRARY_PATH="\"$(system_library_path)\"" \
	@GLIB_CFLAGS@
endif

pkg_config_SOURCES= \
	pkg.h \
	pkg.c \
	parse.h \
	parse.c \
	main.c

# Since we can't always have glib in DIST_SUBDIRS, we need to make sure
# glib is configured when we want to run dist. Unfortunately, there's no
# DIST_CONFIGURE_FLAGS.
DISTCHECK_CONFIGURE_FLAGS = --with-internal-glib
if !INTERNAL_GLIB
dist-hook:
	@echo "error: --with-internal-glib is required to include glib in dist"
	@exit 1
endif
