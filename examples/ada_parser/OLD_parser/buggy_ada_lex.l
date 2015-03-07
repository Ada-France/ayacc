IDENT            [a-z_A-Z][a-z_A-Z0-9]*       
INT_LIT          ([0-9][0-9_]*([.][0-9_]+)?([Ee][-+]?[0-9_]+)?)|([0-9][0-9_]*#[0-9a-fA-F_]+([.][0-9a-fA-F_]+)?#([Ee][-+]?[0-9_]+)?) 
STRING_LIT       \"([^"]*(\"\")*)*\" 
CHAR_LIT         \'[^\n]\'          

----------------------------------------------------------------------------
--                     adapted for alex
----------------------------------------------------------------------------
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

%%
[aA][bB][oO][rR][tT]                {ECHO; return(ABORT_TOKEN);}
[aA][bB][sS]                        {ECHO; return(ABS_TOKEN);}
[aA][cC][cC][eE][pP][tT]            {ECHO; return(ACCEPT_TOKEN);}
[aA][cC][cC][eE][sS][sS]            {ECHO; return(ACCESS_TOKEN);}
[aA][lL][lL]                        {ECHO; return(ALL_TOKEN);} 
[aA][nN][dD]                        {ECHO; return(AND_TOKEN);} 
[aA][rR][rR][aA][yY]                {ECHO; return(ARRAY_TOKEN);}
[aA][tT]                            {ECHO; return(AT_TOKEN);}
[bB][eE][gG][iI][nN]                {ECHO; return(BEGIN_TOKEN);}
[bB][oO][dD][yY]                    {ECHO; return(BODY_TOKEN);}
[cC][aA][sS][eE]                    {ECHO; return(CASE_TOKEN);}
[cC][oO][nN][sS][tT][aA][nN][tT]    {ECHO; return(CONSTANT_TOKEN);}
[dD][eE][cC][lL][aA][rR][eE]        {ECHO; return(DECLARE_TOKEN);}
[dD][eE][lL][aA][yY]                {ECHO; return(DELAY_TOKEN);}
[dD][eE][lL][tT][aA]                {ECHO; return(DELTA_TOKEN);}
[dD][iI][gG][iI][tT][sS]            {ECHO; return(DIGITS_TOKEN);}
[dD][oO]                            {ECHO; return(DO_TOKEN);}
[eE][lL][sS][eE]                    {ECHO; return(ELSE_TOKEN);}
[eE][lL][sS][iI][fF]                {ECHO; return(ELSIF_TOKEN);}
[eE][nN][dD]                        {ECHO; return(END_TOKEN);}
[eE][nN][tT][rR][yY]                {ECHO; return(ENTRY_TOKEN);}
[eE][xX][cC][eE][pP][tT][iI][oO][nN] {ECHO; return(EXCEPTION_TOKEN);}
[eE][xX][iI][tT]                    {ECHO; return(EXIT_TOKEN);}
[fF][oO][rR]                        {ECHO; return(FOR_TOKEN);}
[fF][uU][nN][cC][tT][iI][oO][nN]    {ECHO; return(FUNCTION_TOKEN);}
[gG][eE][nN][eE][rR][iI][cC]        {ECHO; return(GENERIC_TOKEN);}
[gG][oO][tT][oO]                    {ECHO; return(GOTO_TOKEN);}
[iI][fF]                            {ECHO; return(IF_TOKEN);}
[iI][nN]                            {ECHO; return(IN_TOKEN);}
[iI][sS]                            {ECHO; return(IS_TOKEN);}
[lL][iI][mM][iI][tT][eE][dD]        {ECHO; return(LIMITED_TOKEN);}
[lL][oO][oO][pP]                    {ECHO; return(LOOP_TOKEN);}
[mM][oO][dD]                        {ECHO; return(MOD_TOKEN);}
[nN][eE][wW]                        {ECHO; return(NEW_TOKEN);}
[nN][oO][tT]                        {ECHO; return(NOT_TOKEN);}
[nN][uU][lL][lL]                    {ECHO; return(NULL_TOKEN);}
[oO][fF]                            {ECHO; return(OF_TOKEN);}
[oO][rR]                            {ECHO; return(OR_TOKEN);}
[oO][tT][hH][eE][rR][sS]            {ECHO; return(OTHERS_TOKEN);}
[oO][uU][tT]                        {ECHO; return(OUT_TOKEN);}
[pP][aA][cC][kK][aA][gG][eE]        {ECHO; return(PACKAGE_TOKEN);}
[pP][rR][aA][gG][mM][aA]            {ECHO; return(PRAGMA_TOKEN);}
[pP][rR][iI][vV][aA][tT][eE]        {ECHO; return(PRIVATE_TOKEN);}
[pP][rR][oO][cC][eE][dD][uU][rR][eE] {ECHO; return(PROCEDURE_TOKEN);}
[rR][aA][iI][sS][eE]                {ECHO; return(RAISE_TOKEN);}
[rR][aA][nN][gG][eE]                {ECHO; return(RANGE_TOKEN);}
[rR][eE][cC][oO][rR][dD]            {ECHO; return(RECORD_TOKEN);}
[rR][eE][mM]                        {ECHO; return(REM_TOKEN);}
[rR][eE][nN][aA][mM][eE][sS]        {ECHO; return(RENAMES_TOKEN);}
[rR][eE][tT][uU][rR][nN]            {ECHO; return(RETURN_TOKEN);}
[rR][eE][vV][eE][rR][sS][eE]        {ECHO; return(REVERSE_TOKEN);}
[sS][eE][lL][eE][cC][tT]            {ECHO; return(SELECT_TOKEN);}
[sS][eE][pP][aA][rR][aA][tT][eE]    {ECHO; return(SEPARATE_TOKEN);}
[sS][uU][bB][tT][yY][pP][eE]        {ECHO; return(SUBTYPE_TOKEN);}
[tT][aA][sS][kK]                    {ECHO; return(TASK_TOKEN);}
[tT][eE][rR][mM][iI][nN][aA][tT][eE] {ECHO; return(TERMINATE_TOKEN);}
[tT][hH][eE][nN]                    {ECHO; return(THEN_TOKEN);}
[tT][yY][pP][eE]                    {ECHO; return(TYPE_TOKEN);}
[uU][sS][eE]                        {ECHO; return(USE_TOKEN);}
[wW][hH][eE][nN]                    {ECHO; return(WHEN_TOKEN);}
[wW][hH][iI][lL][eE]                {ECHO; return(WHILE_TOKEN);}
[wW][iI][tT][hH]                    {ECHO; return(WITH_TOKEN);}
[xX][oO][rR]                        {ECHO; return(XOR_TOKEN);}
"=>"    {ECHO; return(ARROW);}
".."    {ECHO; return(DOUBLE_DOT);}
"**"    {ECHO; return(DOUBLE_STAR);}
":="    {ECHO; return(ASSIGNMENT);}
"/="    {ECHO; return(INEQUALITY);}
">="    {ECHO; return(GREATER_THAN_OR_EQUAL);}
"<="    {ECHO; return(LESS_THAN_OR_EQUAL);}
"<<"    {ECHO; return(LEFT_LABEL_BRACKET);}
">>"    {ECHO; return(RIGHT_LABEL_BRACKET);}
"<>"    {ECHO; return(BOX);}
"&"     {ECHO; return('&'); }
"("     {ECHO; return('('); }
")"     {ECHO; return(')'); }
"*"     {ECHO; return('*'); }
"+"     {ECHO; return('+'); }
","     {ECHO; return(','); }
"-"     {ECHO; return('-'); }
"."     {ECHO; return('.'); }
"/"     {ECHO; return('/'); }
":"     {ECHO; return(':'); }
";"     {ECHO; return(';'); }
"<"     {ECHO; return('<'); }
"="     {ECHO; return('='); }
">"     {ECHO; return('>'); }
"|"     {ECHO; return('|'); }
"'"     {ECHO; return('''); }
{IDENT}       {ECHO; 
	       return(IDENTIFIER);}
{INT_LIT}     {ECHO;
	       return(INTEGER_LITERAL);}
{STRING_LIT}  {ECHO;
	       return(STRING_LITERAL);}
{CHAR_LIT}    {ECHO;
	       return(CHARACTER_LITERAL);}
[ \t]         {ECHO;}          --/* ignore spaces and tabs */
"--".*        {ECHO;}          --/* ignore comments to end-of-line */
.             {ECHO; 
               text_io.put_line("?? lexical error" & ada_lex_dfa.yytext & "??");
	       num_errors := num_errors + 1;}
[\n]          {ECHO;
	       linenum;}
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

