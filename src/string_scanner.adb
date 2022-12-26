-- Module       : string_scanner.ada
-- Component of : common_library
-- Version      : 1.2
-- Date         : 11/21/86  16:36:26
-- SCCS File    : disk21~/rschm/hasee/sccs/common_library/sccs/sxstring_scanner.ada

with Unchecked_Deallocation;

package body String_Scanner is

   -- SCCS_ID : constant String := "@(#) string_scanner.ada, Version 1.2";

   White_Space : constant String := " " & Ascii.Ht;
   Number_1    : constant String := "0123456789";
   Number      : constant String := Number_1 & "_";
-- Quote         : constant string := """";
   Ada_Id_1 : constant String :=
     "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
   Ada_Id : constant String := Ada_Id_1 & Number;

   procedure Free_Scanner is new Unchecked_Deallocation (Scan_Record, Scanner);
   pragma Page;
   function Is_Valid (T : in Scanner) return Boolean is

   begin

      return T /= null;

   end Is_Valid;

   function Make_Scanner (S : in String_Type) return Scanner is

      T : constant Scanner := new Scan_Record;

   begin

      T.Text := String_Pkg.Make_Persistent (S);
      return T;

   end Make_Scanner;

----------------------------------------------------------------

   procedure Destroy_Scanner (T : in out Scanner) is

   begin

      if Is_Valid (T) then
         String_Pkg.Flush (T.Text);
         Free_Scanner (T);
      end if;

   end Destroy_Scanner;

----------------------------------------------------------------

   function More (T : in Scanner) return Boolean is

   begin

      if Is_Valid (T) then
         if T.Index > String_Pkg.Length (T.Text) then
            return False;
         else
            return True;
         end if;
      else
         return False;
      end if;

   end More;

----------------------------------------------------------------

   function Get (T : in Scanner) return Character is

   begin

      if not More (T) then
         raise Out_Of_Bounds;
      end if;
      return String_Pkg.Fetch (T.Text, T.Index);

   end Get;

----------------------------------------------------------------

   procedure Forward (T : in Scanner) is

   begin

      if Is_Valid (T) then
         if String_Pkg.Length (T.Text) >= T.Index then
            T.Index := T.Index + 1;
         end if;
      end if;

   end Forward;

----------------------------------------------------------------

   procedure Backward (T : in Scanner) is

   begin

      if Is_Valid (T) then
         if T.Index > 1 then
            T.Index := T.Index - 1;
         end if;
      end if;

   end Backward;

----------------------------------------------------------------

   procedure Next (T : in Scanner; C : out Character) is

   begin

      C := Get (T);
      Forward (T);

   end Next;

----------------------------------------------------------------

   function Position (T : in Scanner) return Positive is

   begin

      if not More (T) then
         raise Out_Of_Bounds;
      end if;
      return T.Index;

   end Position;

----------------------------------------------------------------

   function Get_String (T : in Scanner) return String_Type is

   begin

      if Is_Valid (T) then
         return String_Pkg.Make_Persistent (T.Text);
      else
         return String_Pkg.Make_Persistent ("");
      end if;

   end Get_String;

----------------------------------------------------------------

   function Get_Remainder (T : in Scanner) return String_Type is

      S_Str : String_Type;

   begin

      if More (T) then
         String_Pkg.Mark;
         S_Str :=
           String_Pkg.Make_Persistent
             (String_Pkg.Substr
                (T.Text, T.Index, String_Pkg.Length (T.Text) - T.Index + 1));
         String_Pkg.Release;
      else
         S_Str := String_Pkg.Make_Persistent ("");
      end if;
      return S_Str;

   end Get_Remainder;

----------------------------------------------------------------

   procedure Mark (T : in Scanner) is

   begin

      if Is_Valid (T) then
         if T.Mark /= 0 then
            raise Scanner_Already_Marked;
         else
            T.Mark := T.Index;
         end if;
      end if;

   end Mark;

----------------------------------------------------------------

   procedure Restore (T : in Scanner) is

   begin

      if Is_Valid (T) then
         if T.Mark /= 0 then
            T.Index := T.Mark;
            T.Mark  := 0;
         end if;
      end if;

   end Restore;
   pragma Page;
   function Is_Any (T : in Scanner; Q : in String) return Boolean is

      N : Natural;

   begin

      if not More (T) then
         return False;
      end if;
      String_Pkg.Mark;
      N := String_Pkg.Match_Any (T.Text, Q, T.Index);
      if N /= T.Index then
         N := 0;
      end if;
      String_Pkg.Release;
      return N /= 0;

   end Is_Any;
   pragma Page;
   procedure Scan_Any
     (T      : in     Scanner; Q : in String; Found : out Boolean;
      Result : in out String_Type)
   is

      -- S_Str : String_Type;
      N : Natural;

   begin

      if Is_Any (T, Q) then
         N := String_Pkg.Match_None (T.Text, Q, T.Index);
         if N = 0 then
            N := String_Pkg.Length (T.Text) + 1;
         end if;
         Result  := Result & String_Pkg.Substr (T.Text, T.Index, N - T.Index);
         T.Index := N;
         Found   := True;
      else
         Found := False;
      end if;

   end Scan_Any;
   pragma Page;
   function Quoted_String (T : in Scanner) return Integer is

      Count : Integer := 0;
      I     : Positive;
      N     : Natural;

   begin

      if not Is_Valid (T) then
         return Count;
      end if;
      I := T.Index;
      while Is_Any (T, """") loop
         T.Index := T.Index + 1;
         if not More (T) then
            T.Index := I;
            return 0;
         end if;
         String_Pkg.Mark;
         N := String_Pkg.Match_Any (T.Text, """", T.Index);
         String_Pkg.Release;
         if N = 0 then
            T.Index := I;
            return 0;
         end if;
         T.Index := N + 1;
      end loop;
      Count   := T.Index - I;
      T.Index := I;
      return Count;

   end Quoted_String;
   pragma Page;
   function Enclosed_String
     (B : in Character; E : in Character; T : in Scanner) return Natural
   is

      Count : Natural := 1;
      I     : Positive;
      Inx_B : Natural;
      Inx_E : Natural;
      Depth : Natural := 1;

   begin

      if not Is_Any (T, B & "") then
         return 0;
      end if;
      I := T.Index;
      Forward (T);
      while Depth /= 0 loop
         if not More (T) then
            T.Index := I;
            return 0;
         end if;
         String_Pkg.Mark;
         Inx_B := String_Pkg.Match_Any (T.Text, B & "", T.Index);
         Inx_E := String_Pkg.Match_Any (T.Text, E & "", T.Index);
         String_Pkg.Release;
         if Inx_E = 0 then
            T.Index := I;
            return 0;
         end if;
         if Inx_B /= 0 and then Inx_B < Inx_E then
            Depth := Depth + 1;
         else
            Inx_B := Inx_E;
            Depth := Depth - 1;
         end if;
         T.Index := Inx_B + 1;
      end loop;
      Count   := T.Index - I;
      T.Index := I;
      return Count;

   end Enclosed_String;
   pragma Page;
   function Is_Word (T : in Scanner) return Boolean is

   begin

      if not More (T) then
         return False;
      else
         return not Is_Any (T, White_Space);
      end if;

   end Is_Word;

----------------------------------------------------------------

   procedure Scan_Word
     (T    : in Scanner; Found : out Boolean; Result : out String_Type;
      Skip : in Boolean := False)
   is

      -- S_Str : String_Type;
      N : Natural;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if Is_Word (T) then
         String_Pkg.Mark;
         N := String_Pkg.Match_Any (T.Text, White_Space, T.Index);
         if N = 0 then
            N := String_Pkg.Length (T.Text) + 1;
         end if;
         Result :=
           String_Pkg.Make_Persistent
             (String_Pkg.Substr (T.Text, T.Index, N - T.Index));
         T.Index := N;
         Found   := True;
         String_Pkg.Release;
      else
         Found := False;
      end if;
      return;

   end Scan_Word;
   pragma Page;
   function Is_Number (T : in Scanner) return Boolean is

   begin

      return Is_Any (T, Number_1);

   end Is_Number;

----------------------------------------------------------------

   procedure Scan_Number
     (T    : in Scanner; Found : out Boolean; Result : out String_Type;
      Skip : in Boolean := False)
   is

      C     : Character;
      S_Str : String_Type;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if not Is_Number (T) then
         Found := False;
         return;
      end if;
      String_Pkg.Mark;
      while Is_Number (T) loop
         Scan_Any (T, Number_1, Found, S_Str);
         if More (T) then
            C := Get (T);
            if C = '_' then
               Forward (T);
               if Is_Number (T) then
                  S_Str := S_Str & "_";
               else
                  Backward (T);
               end if;
            end if;
         end if;
      end loop;
      Result := String_Pkg.Make_Persistent (S_Str);
      String_Pkg.Release;

   end Scan_Number;

----------------------------------------------------------------

   procedure Scan_Number
     (T    : in Scanner; Found : out Boolean; Result : out Integer;
      Skip : in Boolean := False)
   is

      F     : Boolean;
      S_Str : String_Type;

   begin

      Scan_Number (T, F, S_Str, Skip);
      if F then
         Result := Integer'Value (String_Pkg.Value (S_Str));
      end if;
      Found := F;

   end Scan_Number;
   pragma Page;
   function Is_Signed_Number (T : in Scanner) return Boolean is

      I : Positive;
      C : Character;
      F : Boolean;

   begin

      if More (T) then
         I := T.Index;
         C := Get (T);
         if C = '+' or C = '-' then
            T.Index := T.Index + 1;
         end if;
         F       := Is_Any (T, Number_1);
         T.Index := I;
         return F;
      else
         return False;
      end if;

   end Is_Signed_Number;

----------------------------------------------------------------

   procedure Scan_Signed_Number
     (T    : in Scanner; Found : out Boolean; Result : out String_Type;
      Skip : in Boolean := False)
   is

      C     : Character;
      S_Str : String_Type;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if Is_Signed_Number (T) then
         C := Get (T);
         if C = '+' or C = '-' then
            Forward (T);
         end if;
         Scan_Number (T, Found, S_Str);
         String_Pkg.Mark;
         if C = '+' or C = '-' then
            Result := String_Pkg.Make_Persistent (("" & C) & S_Str);
         else
            Result := String_Pkg.Make_Persistent (S_Str);
         end if;
         String_Pkg.Release;
         String_Pkg.Flush (S_Str);
      else
         Found := False;
      end if;

   end Scan_Signed_Number;

----------------------------------------------------------------

   procedure Scan_Signed_Number
     (T    : in Scanner; Found : out Boolean; Result : out Integer;
      Skip : in Boolean := False)
   is

      F     : Boolean;
      S_Str : String_Type;

   begin

      Scan_Signed_Number (T, F, S_Str, Skip);
      if F then
         Result := Integer'Value (String_Pkg.Value (S_Str));
      end if;
      Found := F;

   end Scan_Signed_Number;
   pragma Page;
   function Is_Space (T : in Scanner) return Boolean is

   begin

      return Is_Any (T, White_Space);

   end Is_Space;

----------------------------------------------------------------

   procedure Scan_Space
     (T : in Scanner; Found : out Boolean; Result : out String_Type)
   is

      S_Str : String_Type;

   begin

      String_Pkg.Mark;
      Scan_Any (T, White_Space, Found, S_Str);
      Result := String_Pkg.Make_Persistent (S_Str);
      String_Pkg.Release;

   end Scan_Space;

----------------------------------------------------------------

   procedure Skip_Space (T : in Scanner) is

      S_Str : String_Type;
      Found : Boolean;

   begin

      String_Pkg.Mark;
      Scan_Any (T, White_Space, Found, S_Str);
      String_Pkg.Release;

   end Skip_Space;
   pragma Page;
   function Is_Ada_Id (T : in Scanner) return Boolean is

   begin

      return Is_Any (T, Ada_Id_1);

   end Is_Ada_Id;

----------------------------------------------------------------

   procedure Scan_Ada_Id
     (T    : in Scanner; Found : out Boolean; Result : out String_Type;
      Skip : in Boolean := False)
   is

      C     : Character;
      F     : Boolean;
      S_Str : String_Type;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if Is_Ada_Id (T) then
         String_Pkg.Mark;
         Next (T, C);
         Scan_Any (T, Ada_Id, F, S_Str);
         Result := String_Pkg.Make_Persistent (("" & C) & S_Str);
         Found  := True;
         String_Pkg.Release;
      else
         Found := False;
      end if;

   end Scan_Ada_Id;
   pragma Page;
   function Is_Quoted (T : in Scanner) return Boolean is

   begin

      if Quoted_String (T) = 0 then
         return False;
      else
         return True;
      end if;

   end Is_Quoted;

----------------------------------------------------------------

   procedure Scan_Quoted
     (T    : in Scanner; Found : out Boolean; Result : out String_Type;
      Skip : in Boolean := False)
   is

      Count : Integer;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      Count := Quoted_String (T);
      if Count /= 0 then
         Count   := Count - 2;
         T.Index := T.Index + 1;
         if Count /= 0 then
            String_Pkg.Mark;
            Result :=
              String_Pkg.Make_Persistent
                (String_Pkg.Substr (T.Text, T.Index, Positive (Count)));
            String_Pkg.Release;
         else
            Result := String_Pkg.Make_Persistent ("");
         end if;
         T.Index := T.Index + Count + 1;
         Found   := True;
      else
         Found := False;
      end if;

   end Scan_Quoted;
   pragma Page;
   function Is_Enclosed
     (B : in Character; E : in Character; T : in Scanner) return Boolean
   is

   begin

      if Enclosed_String (B, E, T) = 0 then
         return False;
      else
         return True;
      end if;

   end Is_Enclosed;

----------------------------------------------------------------

   procedure Scan_Enclosed
     (B : in Character; E : in Character; T : in Scanner; Found : out Boolean;
      Result :    out String_Type; Skip : in Boolean := False)
   is

      Count : Natural;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      Count := Enclosed_String (B, E, T);
      if Count /= 0 then
         Count   := Count - 2;
         T.Index := T.Index + 1;
         if Count /= 0 then
            String_Pkg.Mark;
            Result :=
              String_Pkg.Make_Persistent
                (String_Pkg.Substr (T.Text, T.Index, Positive (Count)));
            String_Pkg.Release;
         else
            Result := String_Pkg.Make_Persistent ("");
         end if;
         T.Index := T.Index + Count + 1;
         Found   := True;
      else
         Found := False;
      end if;

   end Scan_Enclosed;
   pragma Page;
   function Is_Sequence (Chars : in String_Type; T : in Scanner) return Boolean
   is

   begin

      return Is_Any (T, String_Pkg.Value (Chars));

   end Is_Sequence;

----------------------------------------------------------------

   function Is_Sequence (Chars : in String; T : in Scanner) return Boolean is

   begin

      return Is_Any (T, Chars);

   end Is_Sequence;

----------------------------------------------------------------

   procedure Scan_Sequence
     (Chars  : in     String_Type; T : in Scanner; Found : out Boolean;
      Result :    out String_Type; Skip : in Boolean := False)
   is

      I     : Positive;
      Count : Integer := 0;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if not Is_Valid (T) then
         Found := False;
         return;
      end if;
      I := T.Index;
      while Is_Any (T, Value (Chars)) loop
         Forward (T);
         Count := Count + 1;
      end loop;
      if Count /= 0 then
         String_Pkg.Mark;
         Result :=
           String_Pkg.Make_Persistent
             (String_Pkg.Substr (T.Text, I, Positive (Count)));
         Found := True;
         String_Pkg.Release;
      else
         Found := False;
      end if;

   end Scan_Sequence;

----------------------------------------------------------------

   procedure Scan_Sequence
     (Chars  : in     String; T : in Scanner; Found : out Boolean;
      Result :    out String_Type; Skip : in Boolean := False)
   is

   begin

      String_Pkg.Mark;
      Scan_Sequence (String_Pkg.Create (Chars), T, Found, Result, Skip);
      String_Pkg.Release;

   end Scan_Sequence;
   pragma Page;
   function Is_Not_Sequence
     (Chars : in String_Type; T : in Scanner) return Boolean
   is

      N : Natural;

   begin

      if not Is_Valid (T) then
         return False;
      end if;
      String_Pkg.Mark;
      N := String_Pkg.Match_Any (T.Text, Chars, T.Index);
      if N = T.Index then
         N := 0;
      end if;
      String_Pkg.Release;
      return N /= 0;

   end Is_Not_Sequence;

----------------------------------------------------------------

   function Is_Not_Sequence (Chars : in String; T : in Scanner) return Boolean
   is

   begin

      return Is_Not_Sequence (String_Pkg.Create (Chars), T);

   end Is_Not_Sequence;

----------------------------------------------------------------

   procedure Scan_Not_Sequence
     (Chars  : in     String; T : in Scanner; Found : out Boolean;
      Result :    out String_Type; Skip : in Boolean := False)
   is

      N : Natural;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if Is_Not_Sequence (Chars, T) then
         String_Pkg.Mark;
         N      := String_Pkg.Match_Any (T.Text, Chars, T.Index);
         Result :=
           String_Pkg.Make_Persistent
             (String_Pkg.Substr (T.Text, T.Index, N - T.Index));
         T.Index := N;
         Found   := True;
         String_Pkg.Release;
      else
         Found := False;
      end if;

   end Scan_Not_Sequence;

----------------------------------------------------------------

   procedure Scan_Not_Sequence
     (Chars  : in     String_Type; T : in Scanner; Found : out Boolean;
      Result :    out String_Type; Skip : in Boolean := False)
   is

   begin

      Scan_Not_Sequence (String_Pkg.Value (Chars), T, Found, Result, Skip);

   end Scan_Not_Sequence;
   pragma Page;
   function Is_Literal (Chars : in String_Type; T : in Scanner) return Boolean
   is

      N : Natural;

   begin

      if not Is_Valid (T) then
         return False;
      end if;
      String_Pkg.Mark;
      N := String_Pkg.Match_S (T.Text, Chars, T.Index);
      if N /= T.Index then
         N := 0;
      end if;
      String_Pkg.Release;
      return N /= 0;

   end Is_Literal;

----------------------------------------------------------------

   function Is_Literal (Chars : in String; T : in Scanner) return Boolean is

      Found : Boolean;

   begin

      String_Pkg.Mark;
      Found := Is_Literal (String_Pkg.Create (Chars), T);
      String_Pkg.Release;
      return Found;

   end Is_Literal;

----------------------------------------------------------------

   procedure Scan_Literal
     (Chars : in String_Type; T : in Scanner; Found : out Boolean;
      Skip  : in Boolean := False)
   is

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if Is_Literal (Chars, T) then
         T.Index := T.Index + String_Pkg.Length (Chars);
         Found   := True;
      else
         Found := False;
      end if;

   end Scan_Literal;

----------------------------------------------------------------

   procedure Scan_Literal
     (Chars : in String; T : in Scanner; Found : out Boolean;
      Skip  : in Boolean := False)
   is

   begin

      String_Pkg.Mark;
      Scan_Literal (String_Pkg.Create (Chars), T, Found, Skip);
      String_Pkg.Release;

   end Scan_Literal;
   pragma Page;
   function Is_Not_Literal (Chars : in String; T : in Scanner) return Boolean
   is

      N : Natural;

   begin

      if not Is_Valid (T) then
         return False;
      end if;
      String_Pkg.Mark;
      N := String_Pkg.Match_S (T.Text, Chars, T.Index);
      if N = T.Index then
         N := 0;
      end if;
      String_Pkg.Release;
      return N /= 0;

   end Is_Not_Literal;

----------------------------------------------------------------

   function Is_Not_Literal
     (Chars : in String_Type; T : in Scanner) return Boolean
   is

   begin

      if not More (T) then
         return False;
      end if;
      return Is_Not_Literal (String_Pkg.Value (Chars), T);

   end Is_Not_Literal;

----------------------------------------------------------------

   procedure Scan_Not_Literal
     (Chars  : in     String; T : in Scanner; Found : out Boolean;
      Result :    out String_Type; Skip : in Boolean := False)
   is

      N : Natural;

   begin

      if Skip then
         Skip_Space (T);
      end if;
      if Is_Not_Literal (Chars, T) then
         String_Pkg.Mark;
         N      := String_Pkg.Match_S (T.Text, Chars, T.Index);
         Result :=
           String_Pkg.Make_Persistent
             (String_Pkg.Substr (T.Text, T.Index, N - T.Index));
         T.Index := N;
         Found   := True;
         String_Pkg.Release;
      else
         Found := False;
         return;
      end if;

   end Scan_Not_Literal;

----------------------------------------------------------------

   procedure Scan_Not_Literal
     (Chars  : in     String_Type; T : in Scanner; Found : out Boolean;
      Result :    out String_Type; Skip : in Boolean := False)
   is

   begin

      Scan_Not_Literal (String_Pkg.Value (Chars), T, Found, Result, Skip);

   end Scan_Not_Literal;

end String_Scanner;
pragma Page;
