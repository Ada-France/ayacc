
## NAME

ayacc \- An Ada LALR(1) parser generator

## SYNOPSIS

*ayacc* [ -CEPcdkrsv ] [ -D
*directory* ] [ -S
*skeleton* ][ -n
*size* ] [ -e
*ext* ]
*grammar* 
## DESCRIPTION


*Ayacc* provides Ada programmers with a convenient tool for the 
automatic construction of parsers from a high level description 
of a context free grammar.
The input to
*Ayacc* consists of a 
BNF-like specification of a grammar accompanied by a set of 
Ada program statements to be executed as each production is 
recognized.
*Ayacc* outputs a set of Ada program units that act as 
a parser for the specified grammar;
these program units 
may be interfaced to additional user-supplied routines to produce a 
functional program.

*Ayacc* will produce a procedure called
**YYParse** and three packages:
**Tokens,** **Goto_Table,** and
**Shift_Reduce_Table.** All of these packages must be visible to
**YYParse.** Package
**Tokens** contains the enumeration type that is returned by the lexical analyzer.
Packages
**Goto_table** and
**Shift_Reduce_Table** contain the parsing tables used by
**YYParse.** 
The user must supply
**YYParse** with 
a lexical analyzer and an error reporting
routine.
The declarations of these routines should look like the following:

    function YYLEX return Tokens.TOKEN;
    procedure YYERROR(MESSAGE: in String);
    

The format of the
*ayacc* input file must be as follows,

    declarations section
    %%
    rules section
    %%
    user declarations section

The
*declarations section* is used to specify the generated
*tokens* package.  It can contain a series of the following
*yacc*(1) directives:

    %left
    %nonassoc
    %prec
    %right
    %start
    %token

and specific
*ayacc* directives

    %lex
    %unit
    %use
    %with
    %define
    %code

A token declaration consists of the keyword 
*%token* followed by a list of token names that may optionally be separated 
by commas.  Token names must follow Ada enumeration type naming
conventions.  
*Ayacc* provides a means to associate an Ada data type with a grammar symbol.
This type must be called
*YYSType* and must be declared in the tokens declarations section and be
surrounded by '{' '}'s . e.g.

    {
      subtype YYSType is Integer;
    }

Since types declared in this section may require visibility to additional
packages, context clauses for the 
*tokens* package may be defined by using the keywords
*%with* and
*%use.* These keywords must be located before the 
*YYStype* declaration.

The
*%unit* keyword can be used to control the name of the Ada package that
contains the generated parser.

The
*%code* keyword introduces either the
*decl* or
*init* code block.   Such code block contains Ada code that will be inserted
in specific places in the generated Ada parser body.  Everything enclosed
in '{' and '}' is written verbatim.

    %code decl {
    -- Put your Ada code here
    }

The
*decl* code block is inserted in the declaration part of the
*YYParse* procedure and can be used to declare types, variables, function and procedures
accessible from within the
*YYParse* body.

The
*init* code block contains some Ada statements that are executed at the beginning
of the
*YYParse* procedure.

The
*%lex* option instructs the generator to use the specified instruction to call
the
*YYLex* operation.  By default, the
*YYLex* function is called without arguments as follows:

    yy.input_symbol := YYLex;

By using the
*%lex* option, it is possible to give some arguments to the lexer and
indicate another way to call it.  For example,

    %lex Get_Token (Context)

instructs the generator to emit calls such as:

    yy.input_symbol := Get_Token (Context);

The 
*rules section* defines the grammar to be parsed.
Each rules consists of a nonterminal symbol followed by
a colon and a list of grammar symbols terminated by a semicolon.
For example, a rule corresponding to a street address might be
written as,

    Address: Street City ',' State Zip;

A vertical bar may be used to combine rules with identical left hand sides.
Nonterminal names may be made up of alphanumeric characters as well as
periods and underscores.  
Ada reserved words are allowed.
Unlike,
*yacc* all tokens and nonterminal names are case insensitive.
The start symbol of the grammar may be specified using the keyword
*%start* followed by the symbol.
If the start symbol is not specified, 
*ayacc* will use the left hand side of the first grammar rule.

*Ayacc* allows each grammar rule to have associated actions which are
executed whenever the rule is recognized by the parser.  An action
consists of Ada statements enclosed in braces and placed after the
body of a rule.
*Ayacc* uses a pseudo-variable notation to denote the values
associate values with nonterminal and token symbols.  The left hand side
of a rule may be set to a value by an assignment to the variable,
*$$.* For example, if
*YYSType* is an integer, the action:

    A : B C D {$$ := 1;}

sets the value of A to 1.  Values of symbols on the right hand side of
the rule, may be accessed through the variables 
*$1..$n * ,where 
*n* refers to the nth element of the right hand side.  For example.

    A : B '+' C {$$ := $1 + $3;}

sets A to the sum of the values of B and C.

The 
*user declarations section* is optional. By default,
*ayacc* generates a parameterless procedure,
*YYParse.* If the user desires,
the procedure may be incorporated within a package provided in this
section.  The user must use the key marker,
*##,* to indicate where the body of
*YYParse* is to be inserted.  The user is responsible for providing with
clauses for the 
*tokens, parse table,* and
*Text_IO* packages.

The
*YYParse* procedure has no argument but it is possible to specify some arguments in order
to provide some context for the grammar rules which are executed within the
*YYParse* procedure.  To specify a specific signature to
*YYParse* you can define the
*YYParse* procedure arguments by declaring the procedure name followed by its arguments
and using the
*##%* prefix.  For example, to provide two parameters to the grammar rules
*Arg1* and
*Arg2* the following key marker could be used:

    ##%procedure YYParse (Arg1 : in out Type1; Arg2 : in out Typ2)

Note that
*Ayacc* will not verify the validity of argument and their types but the
compilation of the Ada package will.

## OPTIONS



-c
Specifies the generation of a
**C** Lex interface.


-C
Disable the generation of the
**yyclearin** procedure (use it when
**yyclearin** is not used in the grammar).


-E
Disable the generation of the
**yyerrok** procedure (use it when
**yyerrok** is not used in the grammar).


-P
instructs ayacc to generate a private Ada package for the tokens package.
This option is useful when the main parser package is also declared as a private Ada package.
Use of this option implies that the
**yylex** function is also declared in a private Ada package of the same parent.
If
*aflex*(1) is used, the same
*-P* option must be passed to
**aflex**. 

-d
Specifies the production of debugging output in the generated parser.


-D directory
Write the generated files to the directory specified.


-S skeleton
Specify the skeleton to use


-k
Keep the case of symbols found in the grammar for the generation of the
*Token* type.  The default is to convert the symbol using mixed case.


-r
Generate some error recovery support.


-s
Print statistics about the parser such as the number of shift/reduce and reduce/reduce conflicts.


-n size
Defines the size of the value and stack stack.  The default value is 8192.


-v
Produce a readable report of the states generated by the parser.


-e
Define the extension of the generated main file.  The default is to use
*.adb* for the extension.

## DEFINES


The grammar file supports some
IR bison (1)
define controls to tune the Ada code generation according to your needs.


%define api.pure {true|false}
Request a pure (reentrant) parser.  When the parser is reentrant, the
*YYVal* and
*YYLVal* variables are not declared in the tokens package as global variables but
they are declared as local variable within the
*YYParse* procedure.  The default is
*false* and generates a non-reentrant parser.


%define api.private {true|false}
Request to generate
*private* Ada child package for the tokens and goto packages.


%define parse.yyclearin {true|false}
Controls the generation of the
*yyclearin* procedure.  By default (true), the
*yyclearin* procedure is generated and setting the configuration to false allows
to avoid that generation if you don't use it in grammar rules.


%define parse.yyerrok {true|false}
Controls the generation of the
*yyerrok* procedure.  By default (true), the
*yyerrok* procedure is generated and setting the configuration to false allows
to avoid that generation if you don't use it in grammar rules.


%define parse.error {true|false}
Enables the generation of the
*AYacc* extended error recovery support.  This option is similar to using the
*-e* option.


%define parse.stacksize {number}
Controls the size of the parser stack.  The default value is 8192.


%define parse.name {identifier}
Controls the name of the generated parser procedure.  The default name is
**YYParse**. 

%define parse.params "string"
Controls the parameters of the parser procedure.  The default procedure has
no parameter.  The string must be a valid list of parameter declarations.
*AYacc* will not verify the validity of the parameters.

## FILES

file.y	the input file to
*Ayacc* 
file.ada	the generated parser

file.goto.ads	package
**Goto_Table** 
file.shift_reduce.ads	package
**Shift_Reduce_Table** 
file.tokens.ads	package
**Tokens** 
file.verbose	the verbose output

file.c_lex.ada	package
**c_lex** for interfacing with lex

file.h	the C include file for interfacing with lex

## SEE ALSO

Ayacc User's Manual

*aflex*(1), *bison*(1), *flex*(1), *yacc*(1) 