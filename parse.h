#ifndef PKG_CONFIG_PARSE_H
#define PKG_CONFIG_PARSE_H

#include "pkg.h"

Package *parse_package_file (const char *path);

Package *get_compat_package (const char *name);

GSList  *parse_module_list (Package *pkg, const char *str, const char *path);

#endif



