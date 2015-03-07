--/*------------------------------------------------------------------------*/
--/* Lexical input for LEX for LALR(1) Grammar for ANSI Ada                 */
--/*                                                                        */
--/*              Herman Fischer                                            */
--/*            Litton Data Systems                                         */
--/*              March 26, 1984                                            */
--/*                                                                        */
--/* Accompanies Public Domain YACC format Ada grammar                      */
--/*                                                                        */
--/*                                                                        */
--/*                                                                        */
--/*                                                                        */
--/*                                                                        */
--/*                                                                        */
--/*                                                                        */
--/*------------------------------------------------------------------------*/

%START IDENT Z

A		[aA]
B		[bB]
C		[cC]
D		[dD]
E		[eE]
F		[fF]
G		[gG]
H		[hH]
I		[iI]
J		[jJ]
K		[kK]
L		[lL]
M		[mM]
N		[nN]
O		[oO]
P		[pP]
Q		[qQ]
R		[rR]
S		[sS]
T		[tT]
U		[uU]
V		[vV]
W		[wW]
X		[xX]
Y		[yY]
Z		[zZ]

%%
{A}{B}{O}{R}{T}		{ECHO; ENTER(Z); return(ABORT_TOKEN);}
{A}{B}{S}		{ECHO; ENTER(Z); return(ABS_TOKEN);}
{A}{C}{C}{E}{P}{T}	{ECHO; ENTER(Z); return(ACCEPT_TOKEN);}
{A}{C}{C}{E}{S}{S}	{ECHO; ENTER(Z); return(ACCESS_TOKEN);}
{A}{L}{L}		{ECHO; ENTER(IDENT); return(ALL_TOKEN);}
{A}{N}{D}		{ECHO; ENTER(Z); return(AND_TOKEN);}
{A}{R}{R}{A}{Y}		{ECHO; ENTER(Z); return(ARRAY_TOKEN);}
{A}{T}			{ECHO; ENTER(Z); return(AT_TOKEN);}
{B}{E}{G}{I}{N}		{ECHO; ENTER(Z); return(BEGIN_TOKEN);}
{B}{O}{D}{Y}		{ECHO; ENTER(Z); return(BODY_TOKEN);}
{C}{A}{S}{E}		{ECHO; ENTER(Z); return(CASE_TOKEN);}
{C}{O}{N}{S}{T}{A}{N}{T}	{ECHO; ENTER(Z); return(CONSTANT_TOKEN);}
{D}{E}{C}{L}{A}{R}{E} 	{ECHO; ENTER(Z); return(DECLARE_TOKEN);}
{D}{E}{L}{A}{Y}     	{ECHO; ENTER(Z); return(DELAY_TOKEN);}
{D}{E}{L}{T}{A}     	{ECHO; ENTER(Z); return(DELTA_TOKEN);}
{D}{I}{G}{I}{T}{S}   	{ECHO; ENTER(Z); return(DIGITS_TOKEN);}
{D}{O}           	{ECHO; ENTER(Z); return(DO_TOKEN);}
{E}{L}{S}{E}       	{ECHO; ENTER(Z); return(ELSE_TOKEN);}
{E}{L}{S}{I}{F}     	{ECHO; ENTER(Z); return(ELSIF_TOKEN);}
{E}{N}{D}         	{ECHO; ENTER(Z); return(END_TOKEN);}
{E}{N}{T}{R}{Y}     	{ECHO; ENTER(Z); return(ENTRY_TOKEN);}
{E}{X}{C}{E}{P}{T}{I}{O}{N} 	{ECHO; ENTER(Z); return(EXCEPTION_TOKEN);}
{E}{X}{I}{T}       	{ECHO; ENTER(Z); return(EXIT_TOKEN);}
{F}{O}{R}         	{ECHO; ENTER(Z); return(FOR_TOKEN);}
{F}{U}{N}{C}{T}{I}{O}{N} 	{ECHO; ENTER(Z); return(FUNCTION_TOKEN);}
{G}{E}{N}{E}{R}{I}{C} 	{ECHO; ENTER(Z); return(GENERIC_TOKEN);}
{G}{O}{T}{O}       	{ECHO; ENTER(Z); return(GOTO_TOKEN);}
{I}{F}           	{ECHO; ENTER(Z); return(IF_TOKEN);}
{I}{N}           	{ECHO; ENTER(Z); return(IN_TOKEN);}
{I}{S}           	{ECHO; ENTER(Z); return(IS_TOKEN);}
{L}{I}{M}{I}{T}{E}{D} 	{ECHO; ENTER(Z); return(LIMITED_TOKEN);}
{L}{O}{O}{P}       	{ECHO; ENTER(Z); return(LOOP_TOKEN);}
{M}{O}{D}         	{ECHO; ENTER(Z); return(MOD_TOKEN);}
{N}{E}{W}         	{ECHO; ENTER(Z); return(NEW_TOKEN);}
{N}{O}{T}         	{ECHO; ENTER(Z); return(NOT_TOKEN);}
{N}{U}{L}{L}       	{ECHO; ENTER(Z); return(NULL_TOKEN);}
{O}{F}           	{ECHO; ENTER(Z); return(OF_TOKEN);}
{O}{R}           	{ECHO; ENTER(Z); return(OR_TOKEN);}
{O}{T}{H}{E}{R}{S}   	{ECHO; ENTER(Z); return(OTHERS_TOKEN);}
{O}{U}{T}         	{ECHO; ENTER(Z); return(OUT_TOKEN);}
{P}{A}{C}{K}{A}{G}{E} 	{ECHO; ENTER(Z); return(PACKAGE_TOKEN);}
{P}{R}{A}{G}{M}{A}   	{ECHO; ENTER(Z); return(PRAGMA_TOKEN);}
{P}{R}{I}{V}{A}{T}{E} 	{ECHO; ENTER(Z); return(PRIVATE_TOKEN);}
{P}{R}{O}{C}{E}{D}{U}{R}{E} 	{ECHO; ENTER(Z); return(PROCEDURE_TOKEN);}
{R}{A}{I}{S}{E}     	{ECHO; ENTER(Z); return(RAISE_TOKEN);}
{R}{A}{N}{G}{E}     	{ECHO; ENTER(Z); return(RANGE_TOKEN);}
{R}{E}{C}{O}{R}{D}   	{ECHO; ENTER(Z); return(RECORD_TOKEN);}
{R}{E}{M}		{ECHO; ENTER(Z); return(REM_TOKEN);}
{R}{E}{N}{A}{M}{E}{S}	{ECHO; ENTER(Z); return(RENAMES_TOKEN);}
{R}{E}{T}{U}{R}{N}	{ECHO; ENTER(Z); return(RETURN_TOKEN);}
{R}{E}{V}{E}{R}{S}{E}	{ECHO; ENTER(Z); return(REVERSE_TOKEN);}
{S}{E}{L}{E}{C}{T}	{ECHO; ENTER(Z); return(SELECT_TOKEN);}
{S}{E}{P}{A}{R}{A}{T}{E}	{ECHO; ENTER(Z); return(SEPARATE_TOKEN);}
{S}{U}{B}{T}{Y}{P}{E}	{ECHO; ENTER(Z); return(SUBTYPE_TOKEN);}
{T}{A}{S}{K}		{ECHO; ENTER(Z); return(TASK_TOKEN);}
{T}{E}{R}{M}{I}{N}{A}{T}{E}	{ECHO; ENTER(Z); return(TERMINATE_TOKEN);}
{T}{H}{E}{N}		{ECHO; ENTER(Z); return(THEN_TOKEN);}
{T}{Y}{P}{E}		{ECHO; ENTER(Z); return(TYPE_TOKEN);}
{U}{S}{E}		{ECHO; ENTER(Z); return(USE_TOKEN);}
{W}{H}{E}{N}		{ECHO; ENTER(Z); return(WHEN_TOKEN);}
{W}{H}{I}{L}{E}		{ECHO; ENTER(Z); return(WHILE_TOKEN);}
{W}{I}{T}{H}		{ECHO; ENTER(Z); return(WITH_TOKEN);}
{X}{O}{R}		{ECHO; ENTER(Z); return(XOR_TOKEN);}
"=>"    {ECHO; ENTER(Z); return(ARROW);}
".."    {ECHO; ENTER(Z); return(DOUBLE_DOT);}
"**"    {ECHO; ENTER(Z); return(DOUBLE_STAR);}
":="    {ECHO; ENTER(Z); return(ASSIGNMENT);}
"/="    {ECHO; ENTER(Z); return(INEQUALITY);}
">="    {ECHO; ENTER(Z); return(GREATER_THAN_OR_EQUAL);}
"<="    {ECHO; ENTER(Z); return(LESS_THAN_OR_EQUAL);}
"<<"    {ECHO; ENTER(Z); return(LEFT_LABEL_BRACKET);}
">>"    {ECHO; ENTER(Z); return(RIGHT_LABEL_BRACKET);}
"<>"    {ECHO; ENTER(Z); return(BOX);}
"&"     {ECHO; ENTER(Z); return('&'); }
"("     {ECHO; ENTER(Z); return('('); }
")"     {ECHO; ENTER(IDENT); return(')'); }
"*"     {ECHO; ENTER(Z); return('*'); }
"+"     {ECHO; ENTER(Z); return('+'); }
","     {ECHO; ENTER(Z); return(','); }
"-"     {ECHO; ENTER(Z); return('-'); }
"."     {ECHO; ENTER(Z); return('.'); }
"/"     {ECHO; ENTER(Z); return('/'); }
":"     {ECHO; ENTER(Z); return(':'); }
";"     {ECHO; ENTER(Z); return(';'); }
"<"     {ECHO; ENTER(Z); return('<'); }
"="     {ECHO; ENTER(Z); return('='); }
">"     {ECHO; ENTER(Z); return('>'); }
"|"     {ECHO; ENTER(Z); return('|'); }
<IDENT>\'  {ECHO; ENTER(Z); return(''');}

[a-z_A-Z][a-z_A-Z0-9]*       {ECHO; ENTER(IDENT);return(IDENTIFIER);}
[0-9][0-9_]*([.][0-9_]+)?([Ee][-+]?[0-9_]+)?  {
			      ECHO; ENTER(Z);
			      return(INTEGER_LITERAL);}

[0-9][0-9_]*#[0-9a-fA-F_]+([.][0-9a-fA-F_]+)?#([Ee][-+]?[0-9_]+)? {
			      ECHO; ENTER(Z);
			      return(INTEGER_LITERAL);}

\"([^"]*(\"\")*)*\" {ECHO; ENTER(Z); return(STRING_LITERAL);}

<Z>\'([^']|\'\')\'    {ECHO; ENTER(Z); return(CHARACTER_LITERAL);}

[ \t]   ECHO;          -- ignore spaces and tabs
"--".*  ECHO;          -- ignore comments to end-of-line

.             {ECHO; 
               text_io.put_line("?? lexical error" & ada_lex_dfa.yytext & "??");
	       num_errors := num_errors + 1;}
[\n]    {ECHO; linenum;}
%%

with ada_tokens; 
use  ada_tokens;
use text_io;

package ada_lex is
  
  lines      : positive := 1;
  num_errors : natural := 0;

  procedure linenum; 

  function yylex return token;

end ada_lex;

package body ada_lex is

  procedure linenum is
  begin
    text_io.put(integer'image(lines) & ":");
    lines := lines + 1;
  end linenum;

##

end ada_lex;

