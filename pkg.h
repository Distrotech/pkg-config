#ifndef PKG_CONFIG_PKG_H
#define PKG_CONFIG_PKG_H

#ifdef USE_INSTALLED_GLIB
#include <glib.h>
#else
#include "partial-glib.h"
#endif

typedef enum
{
  LESS_THAN,
  GREATER_THAN,
  LESS_THAN_EQUAL,
  GREATER_THAN_EQUAL,
  EQUAL,
  NOT_EQUAL,
  ALWAYS_MATCH
} ComparisonType;

typedef struct _Package Package;
typedef struct _RequiredVersion RequiredVersion;

struct _RequiredVersion
{
  char *name;
  ComparisonType comparison;
  char *version;
  Package *owner;
};

struct _Package
{
  char *key;  /* filename name */
  char *name; /* human-readable name */
  char *version;
  char *description;
  char *pcfiledir; /* directory it was loaded from */
  GSList *requires;
  GSList *l_libs;
  char   *l_libs_merged;
  GSList *L_libs;
  char   *L_libs_merged;
  char   *other_libs;
  char   *other_libs_merged;
  GSList *I_cflags;
  char   *I_cflags_merged;
  char *other_cflags;
  char *other_cflags_merged;
  GHashTable *vars;
  GHashTable *required_versions; /* hash from name to RequiredVersion */
  GSList *conflicts; /* list of RequiredVersion */
  gboolean uninstalled; /* used the -uninstalled file */
};

Package *get_package              (const char *name);
char *   package_get_l_libs       (Package    *pkg);
char *   packages_get_l_libs      (GSList     *pkgs);
char *   package_get_L_libs       (Package    *pkg);
char *   packages_get_L_libs      (GSList     *pkgs);
char *   package_get_other_libs   (Package    *pkg);
char *   packages_get_other_libs  (GSList     *pkgs);
char *   packages_get_all_libs    (GSList     *pkgs);
char *   package_get_I_cflags     (Package    *pkg);
char *   packages_get_I_cflags    (GSList     *pkgs);
char *   package_get_other_cflags (Package    *pkg);
char *   packages_get_all_cflags  (GSList     *pkgs);
char *   package_get_var          (Package    *pkg,
                                   const char *var);
char *   packages_get_var          (GSList     *pkgs,
                                    const char *var);


void add_search_dir (const char *path);
void package_init (void);
int compare_versions (const char * a, const char *b);
gboolean version_test (ComparisonType comparison,
                       const char *a,
                       const char *b);

const char *comparison_to_str (ComparisonType comparison);

void print_package_list (void);

void define_global_variable (const char *varname,
                             const char *varval);

void debug_spew (const char *format, ...);
void verbose_error (const char *format, ...);

gboolean name_ends_in_uninstalled (const char *str);

/* If TRUE, do not automatically prefer uninstalled versions */
extern gboolean disable_uninstalled;

#endif

