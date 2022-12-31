
## NAME

ayacc \- An Ada LALR(1) parser generator

## SYNOPSIS

*ayacc* [ -CEPcdkrsv ] [ -D
*directory* ] [ -n
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
**yyparse** and three packages:
**Tokens,** **Goto_Table,** and
**Shift_Reduce_Table.** All of these packages must be visible to
**yyparse.** Package
**Tokens** contains the enumeration type that is returned by the lexical analyzer.
Packages
**Goto_table** and
**Shift_Reduce_Table** contain the parsing tables used by
**yyparse.** 
The user must supply
**yyparse** with 
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


-D
Write the generated files to the directory specified.


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