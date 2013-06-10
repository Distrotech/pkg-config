#
# Settings from the configure script
#

prefix=/usr/local
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib
datarootdir=${prefix}/share
datadir=${datarootdir}
pc_path="${libdir}/pkgconfig:${datadir}/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig"
system_include_path="/usr/include"
system_library_path="/usr/lib:/lib"
list_indirect_deps=no
PACKAGE_VERSION=0.28
