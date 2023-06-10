%% 
[A-Z]       { return IDENTIFIER; }
[a-z]       { return IDENTIFIER; }
[0-9]+      { return NUMBER; }
"**"        { return EXP; }
"("         { return '('; }
")"         { return ')'; }
"+"         { return '+'; }
"/"         { return '/'; }
"*"         { return '*'; }
"="         { return '='; }
"-"         { return '-'; }
\n          { return NEW_LINE; }
[\t ]+      { null;} 
%%

with calc_tokens; 
use  calc_tokens;

package calc_lexer is
  function YYLex return Token;
end;

package body calc_lexer is

##

end calc_lexer;