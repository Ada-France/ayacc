Ayacc is an Ada parser generator in the style of yacc(1).

The first implementation was written by David Taback and Deepak Tolani
at the University of California, Irvine.  The last version that was released
appeared to be the Ayacc 1.1 released in 1994.

Ayacc was used and improved by P2Ada, the Pascal to Ada translator.
This version of Ayacc is derived from the P2Ada ayacc implementation
released in August 2010.

This version brings a number of improvements:

- Ayacc now uses more standard options to configure the code generation
- The parser was improved to configure the parser stack size and
  support Ada child packages.
- The grammar supports the %unit directive to control the Ada child packages

## Version 1.3.0 - Dec 2021

- New option `-C` to disable the generation of `yyclearin` procedure,
- New option `-E` to disable the generation of `yyerrok` procedure,
- New option `-D` to write the generated files to the directory specified,
- New option `-k` to keep the case of grammar symbols,
- Fixed various compilation warnings,
- Generate constants for shift reduce and goto arrays,
- Better strong typing in the generated state tables,
- Reduced number of style compilation warnings in generated code

# Build

```
  make
```

# Install
```
  make install prefix=/usr
```
