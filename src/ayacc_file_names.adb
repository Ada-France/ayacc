with Ada.Strings.Fixed;
with Str_Pack; use Str_Pack;

with String_Pkg;
package body Ayacc_File_Names is

   -- SCCS_ID : constant String := "@(#) file_names.ada, Version 1.2";
   -- Rcs_ID : constant String := "$Header: /cf/ua/arcadia/alex-ayacc/ayacc/src/RCS/file_names.a,v 1.2 88/11/28 13:38:59 arcadia Exp $";

   Max_Name_Length  : constant := 50;
   Max_Param_Length : constant := 250;

   Source_File_Name       : Str (Max_Name_Length);
   Out_File_Name          : Str (Max_Name_Length);
   Verbose_File_Name      : Str (Max_Name_Length);
   Template_File_Name     : Str (Max_Name_Length);
   Actions_File_Name      : Str (Max_Name_Length);
   Shift_Reduce_File_Name : Str (Max_Name_Length);
   Goto_File_Name         : Str (Max_Name_Length);
   Tokens_File_Name       : Str (Max_Name_Length);
-- UMASS CODES :
   Error_Report_File_Name : Str (Max_Name_Length);
   Listing_File_Name      : Str (Max_Name_Length);
-- END OF UMASS CODES.
   C_Lex_File_Name   : Str (Max_Name_Length);
   Include_File_Name : Str (Max_Name_Length);
   Unit_Name         : Str (Max_Name_Length);
   Lex_Func_Name          : Str (Max_Name_Length);
   Parse_Name             : Str (Max_Name_Length);
   Parse_Params           : Str (Max_Param_Length);

--RJS ==========================================

   function End_Of_Unit_Name (Name : in String) return Natural is
      Dot_Position : Natural := Name'Last;
   begin
      while Dot_Position >= Name'First and then Name (Dot_Position) /= '.' loop
         Dot_Position := Dot_Position - 1;
      end loop;
      return Dot_Position - 1;
   end End_Of_Unit_Name;

   function Get_Unit_Name (Filename : in String) return String is

      -- modified to check for valid Ada identifiers. 11/28/88 kn

      Filename_Without_Extension : constant String :=
        Filename (Filename'First .. End_Of_Unit_Name (Filename));

      End_Of_Directory : Natural := Filename_Without_Extension'Last + 1;

      function Is_Alphabetic (Ch : in Character) return Boolean is
      begin
         return Ch in 'A' .. 'Z' or else Ch in 'a' .. 'z';
      end Is_Alphabetic;

      function Is_Alphanum_Or_Underscore (Ch : in Character) return Boolean is
      begin
         return
           Is_Alphabetic (Ch) or else Ch in '0' .. '9' or else Ch = '_'
           or else Ch = '-';
      end Is_Alphanum_Or_Underscore;

      use String_Pkg;

   begin
      -- find end of directory
      for Pos in reverse
        Filename_Without_Extension'First .. Filename_Without_Extension'Last
      loop
         exit when Filename_Without_Extension (Pos) = '/';
         End_Of_Directory := Pos;
      end loop;

      if End_Of_Directory <= Filename_Without_Extension'Last
        and then Is_Alphabetic (Filename_Without_Extension (End_Of_Directory))
      then

         Check_Remaining_Characters :
         for I in End_Of_Directory + 1 .. Filename_Without_Extension'Last loop
            if not Is_Alphanum_Or_Underscore (Filename_Without_Extension (I))
            then
               return "";
            end if;
         end loop Check_Remaining_Characters;

         return
           Value
             (To_Package_Name
                (Filename_Without_Extension
                   (End_Of_Directory .. Filename_Without_Extension'Last)));
      else
         return "";
      end if;

   end Get_Unit_Name;

   procedure Set_Unit_Name (Name : in String) is
   begin
      Assign (Name, Unit_Name);
   end Set_Unit_Name;

   function C_Lex_Unit_Name return String is
      Filename : constant String := Value_Of (Upper_Case (C_Lex_File_Name));
   begin
      return Get_Unit_Name (Filename);
   end C_Lex_Unit_Name;

   function Goto_Tables_Unit_Name return String is
      Filename : constant String := Value_Of (Upper_Case (Goto_File_Name));
   begin
      if Is_Empty (Unit_Name) then
         return Get_Unit_Name (Filename);
      else
         return Value_Of (Unit_Name) & "_Goto";
      end if;
   end Goto_Tables_Unit_Name;

   function Shift_Reduce_Tables_Unit_Name return String is
      Filename : constant String :=
        Value_Of (Upper_Case (Shift_Reduce_File_Name));
   begin
      if Is_Empty (Unit_Name) then
         return Get_Unit_Name (Filename);
      else
         return Value_Of (Unit_Name) & "_Shift_Reduce";
      end if;
   end Shift_Reduce_Tables_Unit_Name;

   function Tokens_Unit_Name return String is
      Filename : constant String := Value_Of (Upper_Case (Tokens_File_Name));
   begin
      if Is_Empty (Unit_Name) then
         return Get_Unit_Name (Filename);
      else
         return Value_Of (Unit_Name) & "_Tokens";
      end if;
   end Tokens_Unit_Name;

   function Lex_Function_Name return String is
   begin
      if Is_Empty (Lex_Func_Name) then
         return "YYLex";
      else
         return Value_Of (Lex_Func_Name);
      end if;
   end Lex_Function_Name;

   procedure Set_Lex_Function_Name (Name : in String) is
   begin
      Assign (Ada.Strings.Fixed.Trim (Name, Ada.Strings.Both), Lex_Func_Name);
   end Set_Lex_Function_Name;

   procedure Set_Parse_Name (Name : in String) is
   begin
      Assign (Name, Parse_Name);
   end Set_Parse_Name;

   function Get_Parse_Name return String is
   begin
      if Is_Empty (Parse_Name) then
         return "YYParse";
      else
         return Value_Of (Parse_Name);
      end if;
   end Get_Parse_Name;

   procedure Set_Parse_Params (Params : in String) is
      Trimed_Param : constant String := Ada.Strings.Fixed.Trim (Params, Ada.Strings.Both);
      First : Natural := Trimed_Param'First;
      Last  : Natural := Trimed_Param'Last;
   begin
      --  Drop () arround param declaration since we insert our own.
      if Trimed_Param'Length > 0 and then Trimed_Param (First) = '(' then
         First := First + 1;
      end if;
      if Trimed_Param'Length > 0 and then Trimed_Param (Last) = ')' then
         Last := Last - 1;
      end if;
      Assign (Ada.Strings.Fixed.Trim (Trimed_Param (First .. Last), Ada.Strings.Both), Parse_Params);
   end Set_Parse_Params;

   function Get_Parse_Params return String is
   begin
      if Is_Empty (Parse_Params) then
         return "";
      else
         return " (" & Value_Of (Parse_Params) & ")";
      end if;
   end Get_Parse_Params;

   -- UMASS CODES :
   function Error_Report_Unit_Name return String is
      Filename : constant String :=
        Value_Of (Upper_Case (Error_Report_File_Name));
   begin
      return Get_Unit_Name (Filename);
   end Error_Report_Unit_Name;
-- END OF UMASS CODES.

--RJS ==========================================

   function Get_Source_File_Name return String is
   begin
      return Value_Of (Source_File_Name);
   end Get_Source_File_Name;

   function Get_Out_File_Name return String is
   begin
      return Value_Of (Out_File_Name);
   end Get_Out_File_Name;

   function Get_Verbose_File_Name return String is
   begin
      return Value_Of (Verbose_File_Name);
   end Get_Verbose_File_Name;

   function Get_Template_File_Name return String is
   begin
      return Value_Of (Template_File_Name);
   end Get_Template_File_Name;

   function Get_Actions_File_Name return String is
   begin
      return Value_Of (Actions_File_Name);
   end Get_Actions_File_Name;

   function Get_Shift_Reduce_File_Name return String is
   begin
      return Value_Of (Shift_Reduce_File_Name);
   end Get_Shift_Reduce_File_Name;

   function Get_Goto_File_Name return String is
   begin
      return Value_Of (Goto_File_Name);
   end Get_Goto_File_Name;

   function Get_Tokens_File_Name return String is
   begin
      return Value_Of (Tokens_File_Name);
   end Get_Tokens_File_Name;

-- UMASS CODES :
   function Get_Error_Report_File_Name return String is
   begin
      return Value_Of (Error_Report_File_Name);
   end Get_Error_Report_File_Name;

   function Get_Listing_File_Name return String is
   begin
      return Value_Of (Listing_File_Name);
   end Get_Listing_File_Name;
-- END OF UMASS CODES.

   function Get_C_Lex_File_Name return String is
   begin
      return Value_Of (C_Lex_File_Name);
   end Get_C_Lex_File_Name;

   function Get_Include_File_Name return String is
   begin
      return Value_Of (Include_File_Name);
   end Get_Include_File_Name;

   procedure Set_File_Names
     (Input_File, Extension, Output_Directory : in String)
   is
      Base : Str (Max_Name_Length);

      function Find_Start_Of_Base (Filename : in String) return Natural is
      begin
         for Index in reverse Filename'Range loop
            if Filename (Index) = '/' then
               return Index;
            end if;
         end loop;

         return Natural'First;  --  Return 0, failed to find a directory.
      end Find_Start_Of_Base;

      Directory_Index : constant Natural := Find_Start_Of_Base (Input_File);
   begin

      if Input_File'Length < 3
        or else
        (Input_File (Input_File'Last) /= 'y'
         and then Input_File (Input_File'Last) /= 'Y')
        or else Input_File (Input_File'Last - 1) /= '.'
      then
         raise Illegal_File_Name;
      end if;

      if Output_Directory = "" then
         Assign
           (Input_File (Input_File'First .. Input_File'Last - 2), To => Base);
      else
         if Directory_Index /= 0 then
            --  Strip out any leading directory, i.e. "../../"
            if Output_Directory (Output_Directory'Last) /= '/' then
               Assign (Output_Directory & '/', To => Base);
            else
               Assign (Output_Directory, To => Base);
            end if;

            Append
              (Input_File (Directory_Index + 1 .. Input_File'Last - 2),
               To => Base);
         else
            Assign
              (Input_File (Input_File'First .. Input_File'Last - 2),
               To => Base);
         end if;
      end if;

      Assign (Input_File, To => Source_File_Name);

      Assign (Base, To => Out_File_Name);
      Append (Extension, To => Out_File_Name);

      Assign (Base, To => Verbose_File_Name);
      Append (".verbose", To => Verbose_File_Name);

      Assign (Base, To => Tokens_File_Name);
      Append ("_tokens.ads", To => Tokens_File_Name);

      -- UMASS CODES :
      Assign (Base, To => Error_Report_File_Name);
      Append ("_error_report" & Extension, To => Error_Report_File_Name);

      Assign (Base, To => Listing_File_Name);
      Append (".lis", To => Listing_File_Name);
      -- END OF UMASS CODES.

      Assign ("yyparse.template", To => Template_File_Name);

      Assign (Base, To => Actions_File_Name);
      Append (".accs", To => Actions_File_Name);

      Assign (Base, To => Shift_Reduce_File_Name);
      Append ("_shift_reduce.ads", To => Shift_Reduce_File_Name);

      Assign (Base, To => Goto_File_Name);
      Append ("_goto.ads", To => Goto_File_Name);

      Assign (Base, To => C_Lex_File_Name);
      Append ("_c_lex" & Extension, To => C_Lex_File_Name);

      Assign (Base, To => Include_File_Name);
      Append (".h", To => Include_File_Name);

   end Set_File_Names;

end Ayacc_File_Names;
