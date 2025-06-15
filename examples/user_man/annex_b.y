%token id, '+', '*'
{  subtype YYSType is Integer; }
%%
E : E '+' T
|T ;
T : T '*' id | id
;
%%
private with Annex_B_Goto, Annex_B_Shift_Reduce, Annex_B_Tokens;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

procedure Annex_B is
   use Annex_B_Tokens;
   Input : array (1..6) of Token := (ID, '*', ID, '+', ID, End_Of_Input);
   Index : Natural := 0;
   function YYLex return Token is begin
      Index := Index + 1;
      return Input (Index);
   end YYLex;
   procedure YYError(S : in string) is begin
      Ada.Text_IO.Put_Line(S);
      raise Annex_B_Tokens.Syntax_Error;
   end YYError;
##
begin
   YYParse;
end;
