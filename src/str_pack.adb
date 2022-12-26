package body Str_Pack is

   -- SCCS_ID : constant String := "@(#) str_pack.ada, Version 1.2";
   -- Rcs_ID : constant String := "$Header: str_pack.a,v 0.1 86/04/01 15:13:01 ada Exp $";

   function Upper_Case (S : in Str) return Str is
      Upper_Str : Str (S.Name'Length) := S;
   begin
      for I in 1 .. S.Length loop
         if S.Name (I) in 'a' .. 'z' then
            Upper_Str.Name (I) :=
              Character'Val
                (Character'Pos (S.Name (I)) - Character'Pos ('a') +
                 Character'Pos ('A'));
         end if;
      end loop;
      return Upper_Str;
   end Upper_Case;

   function Lower_Case (S : in Str) return Str is
      Lower_Str : Str (S.Name'Length) := S;
   begin
      for I in 1 .. S.Length loop
         if S.Name (I) in 'A' .. 'Z' then
            Lower_Str.Name (I) :=
              Character'Val
                (Character'Pos (S.Name (I)) - Character'Pos ('A') +
                 Character'Pos ('a'));
         end if;
      end loop;
      return Lower_Str;
   end Lower_Case;

   procedure Upper_Case (S : in out Str) is
   begin
      S := Upper_Case (S);
   end Upper_Case;

   procedure Lower_Case (S : in out Str) is
   begin
      S := Lower_Case (S);
   end Lower_Case;

   procedure Assign (Value : in Str; To : in out Str) is
   begin
      To := Value;
   end Assign;

   procedure Assign (Value : in String; To : in out Str) is
   begin
      To.Name (1 .. Value'Length) := Value;
      To.Length                   := Value'Length;
   end Assign;

   procedure Assign (Value : in Character; To : in out Str) is
   begin
      To.Name (1) := Value;
      To.Length   := 1;
   end Assign;

   procedure Append (Tail : in Str; To : in out Str) is
      F, L : Natural;
   begin
      F                := To.Length + 1;
      L                := F + Tail.Length - 1;
      To.Name (F .. L) := Tail.Name (1 .. Tail.Length);
      To.Length        := L;
   end Append;

   procedure Append (Tail : in String; To : in out Str) is
      F, L : Natural;
   begin
      F                := To.Length + 1;
      L                := F + Tail'Length - 1;
      To.Name (F .. L) := Tail;
      To.Length        := L;
   end Append;

   procedure Append (Tail : in Character; To : in out Str) is
   begin
      To.Length           := To.Length + 1;
      To.Name (To.Length) := Tail;
   end Append;

   function Length_Of (S : Str) return Integer is
   begin
      return S.Length;
   end Length_Of;

   function Value_Of (S : Str) return String is
   begin
      return S.Name (1 .. S.Length);
   end Value_Of;

   function Is_Empty (S : Str) return Boolean is
   begin
      return S.Length = 0;
   end Is_Empty;

end Str_Pack;
