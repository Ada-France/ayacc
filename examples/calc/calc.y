%token '(' ')' number identifier new_line

%right     '='
%left      '+' '-' 
%left      '*' '/' 
%right     dummy
%nonassoc  exp

{
type key_type is (cval, ival, noval); 

type yystype is record
  register : character;
  value    : integer; 
end record;
        
}

%% 

statements : statements statement 
           | 
           ;

statement  : expr end
               { put_line(integer'image($1.value)); }
           | error end 
               { put_line("Try again"); 
                 yyerrok; -- yyclearin;
               }
             statement
           ; 

expr       : id '=' expr 
               { registers($1.register) := $3.value; 
                 $$.value := $3.value; }
           | expr '+' expr 
               { $$.value :=  $1.value + $3.value; }
           | expr '-' expr 
               { $$.value :=  $1.value - $3.value; }
           | expr '*' expr 
               { $$.value :=  $1.value * $3.value; }
           | expr '/' expr 
               { $$.value :=  $1.value / $3.value; }
           | expr exp expr  
               { $$.value :=  integer(float($1.value) ** $3.value); }
           | '-' expr  %prec dummy 
               { $$.value := - $2.value; }
           | '(' expr ')' 
               { $$.value :=  $2.value; }
           | number
               { $$.value :=  character'pos(calc_lex_dfa.yytext(1)) -
		              character'pos('0'); } 
           | id 
	       { $$.value :=  registers($1.register); }
           ; 

id         : identifier
               { $$.register := to_upper(calc_lex_dfa.yytext(1)); }
	   ;

end        : new_line
           | end_of_input 
           ;

%% 

package parser is 
    procedure yyparse; 
end parser; 

with yylex, calc_lex_dfa, calc_lex_io, text_io, calc_tokens, calc_goto, calc_shift_reduce; 
use  text_io, calc_tokens, calc_goto, calc_lex_io, calc_shift_reduce; 

package body parser is 

    registers : array(Character '('A') .. Character '('Z')) of integer; 

    function to_upper(ch : in character) return character is
    begin
      if ch in 'a'..'z' then
	return character'val( character'pos(ch) - (character'pos('a') -
						   character'pos('A')) );
      else
	return ch;
      end if;
    end to_upper;

    procedure yyerror(s: string) is 
    begin 
        put_line(s); 
    end;  
##

end parser;
