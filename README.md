# Ayacc

[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/ayacc.json)](https://alire.ada.dev/crates/ayacc)
[![Build Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/ayacc/badges/build.json)](https://porion.vacs.fr/porion/projects/view/ayacc/summary)
[![License](http://img.shields.io/badge/license-UCI-blue.svg)](LICENSE)

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
- The grammar supports the `%unit` directive to control the Ada child packages
- It is possible to customize the `YYParse` procedure and pass some context
  arguments that are available to the grammar rules.
- The call to `YYLex` can be customized with the `%lex` directive allowing to
  give some context arguments when calling the lexer.
- Ayacc can now generate reentrant parsers.

## Version 1.4.0 - May 2023

- Support the Bison `%define variable value` option to configure the parser generator
- Support the Bison `%code name { ... }` directive to insert code verbatim into the output parser
- Recognize some Bison variables `api.pure`, `api.private`, `parse.error`, `parse.stacksize`,
  `parse.name`, `parse.params`, `parse.yyclearin`, `parse.yyerrok`, `parse.error`
- New option `-S skeleton` to allow using an external skeleton file for the parser generator
- Ayacc templates provide more control for tuning the code generation and
  they are embedded with [Advanced Resource Embedder](https://gitlab.com/stcarrez/resource-embedder)
- New option `-P` to generate a private Ada package for the tokens package
- Improvement to allow passing parameters to `YYParse` for the grammar rules
- New `%lex` directive to control the call of `YYLex` function
- Fix #6: ayacc gets stuck creating an infinitely large file after encountering a comment in an action
- Reformat code using gnatpp

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

# Articles and Documentation

* Man page: [ayacc (1)](https://github.com/Ada-France/ayacc/blob/master/doc/ayacc.md)

* [Aflex 1.5 and Ayacc 1.3.0](https://blog.vacs.fr/vacs/blogs/post.html?post=2021/12/18/Aflex-1.5-and-Ayacc-1.3.0)
  explains how to use Aflex and Ayacc together, 
  [Aflex 1.5 et Ayacc 1.3.0](https://www.ada-france.org/adafr/blogs/post.html?post=2021/12/19/Aflex-1.5-et-Ayacc-1.3.0)
  is the French translation.

# Projects Using Ayacc

* [Pascal to Ada translator](https://github.com/zertovitch/pascal-to-ada)
* [GWindows: GUI framework for MS Windows](https://github.com/zertovitch/gwindows)
* [Ada parser for CSS files with CSS Object Model API](https://github.com/stcarrez/ada-css)
* [Memory Analysis Tool](https://github.com/stcarrez/mat)
* [Porion Build Manager](https://gitlab.com/stcarrez/porion)


