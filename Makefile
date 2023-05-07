AYACC_BUILD=distrib
GNATMAKE=gprbuild
GNATCLEAN=gnatclean
GPRPATH=ayacc.gpr
PROCESSORS=1

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = $(INSTALL) -m 755

MAKE_ARGS=-XAYACC_BUILD=${AYACC_BUILD} -XPROCESSORS=$(PROCESSORS)

prefix = /usr/local
bindir = ${prefix}/bin
mandir = ${prefix}/share/man

all build:
	$(GNATMAKE) -p -P "$(GPRPATH)" $(MAKE_ARGS)

# Not intended for manual invocation.
# Invoked if automatic builds are enabled.
# Analyzes only on those sources that have changed.
# Does not build executables.
autobuild:
	$(GNATMAKE) -gnatc -c -k  -P "$(GPRPATH)" $(MAKE_ARGS)

# Clean the root project of all build products.
clean:
	-$(GNATCLEAN) -q -P "$(GPRPATH)"
	-@rm -rf tests
	-make -C examples/ada_parser clean
	-make -C examples/calc clean

# Check *all* sources for errors, even those not changed.
# Does not build executables.
analyze:
	$(GNATMAKE) -f  -gnatc -c -k  -P "$(GPRPATH)" $(MAKE_ARGS)

# Clean, then build executables for all mains defined by the project.
rebuild: clean build

install:
	mkdir -p $(DESTDIR)$(prefix)/bin
	$(INSTALL_PROGRAM) bin/ayacc $(DESTDIR)${bindir}
	mkdir -p $(DESTDIR)$(mandir)/man1
	$(INSTALL) man/man1/ayacc.1 $(DESTDIR)$(mandir)/man1/ayacc.1

test:
	make -C examples/ada_parser AYACC=../../bin/ayacc clean build
	make -C examples/calc AYACC=../../bin/ayacc clean build

# Used for Ayacc development only: rebuild the embedded templates from `templates/*.ad[bs]` files.
generate:
	@ERRORS=`sed -f templates/check.sed templates/*.adb` ; \
	if test "T$$ERRORS" = "T"; then \
	   are -o src --rule=are-package.xml --no-type-declaration --var-access --content-only . ; \
	else \
	   echo "Invalid %if <option>, %else or %end option in template:"; \
	   echo $$ERRORS; \
           exit 1 ; \
	fi
