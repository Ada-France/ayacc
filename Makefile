MODE=distrib
GNATMAKE=gprbuild
GNATCLEAN=gnatclean
GPRPATH=ayacc.gpr

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = $(INSTALL) -m 755

MAKE_ARGS=-XBUILD=${MODE}

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
	$(INSTALL_PROGRAM) bin/ayacc ${bindir}
	$(INSTALL) doc/ayacc.man $(mandir)/man1/ayacc.1

test:
	make -C examples/ada_parser AYACC=../../bin/ayacc clean build
	make -C examples/calc AYACC=../../bin/ayacc clean build

