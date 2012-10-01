TESTS_PKG_CONFIG = $(top_builddir)/pkg-config$(EXEEXT)
TESTS_ENVIRONMENT = PKG_CONFIG='$(TESTS_PKG_CONFIG)' $(TESTS_SHELL)

TESTS = \
	check-cflags \
	check-libs \
	check-define-variable \
	check-libs-private \
	check-requires-private \
	check-includedir \
	check-conflicts \
	check-missing \
	check-idirafter \
	check-whitespace \
	check-cmd-options \
	check-version \
	check-print-options \
	check-path \
	check-sysroot \
	check-uninstalled

EXTRA_DIST = \
	$(TESTS) \
	common \
	simple.pc \
	requires-test.pc \
	public-dep.pc \
	private-dep.pc \
	includedir.pc \
	missing-requires-private.pc \
	missing-requires.pc \
	idirafter.pc \
	conflicts-test.pc \
	whitespace.pc \
	fields-blank.pc \
	sub/sub1.pc \
	sub/sub2.pc \
	inst.pc \
	inst-uninstalled.pc
