TESTS_PKG_CONFIG = $(top_builddir)/pkg-config$(EXEEXT)
TESTS_ENVIRONMENT = PKG_CONFIG='$(TESTS_PKG_CONFIG)' $(TESTS_SHELL)

TESTS = \
	check-cflags \
	check-libs \
	check-non-l-flags \
	check-define-variable \
	check-libs-private \
	check-requires-private \
	check-circular-requires \
	check-includedir \
	check-conflicts \
	check-missing \
	check-idirafter \
	check-whitespace \
	check-cmd-options \
	check-version \
	check-requires-version \
	check-print-options \
	check-path \
	check-sysroot \
	check-uninstalled \
	check-debug

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
	inst-uninstalled.pc \
	other.pc \
	requires-version-1.pc \
	requires-version-2.pc \
	requires-version-3.pc \
	non-l.pc \
	non-l-required.pc \
	circular-1.pc \
	circular-2.pc \
	circular-3.pc
