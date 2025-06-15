-- $Header: /dc/uc/self/arcadia/ayacc/src/RCS/parse_template_file.a,v 1.1 1993/01/15 23:39:54 self Exp self $

-- Copyright (c) 1990 Regents of the University of California.
-- All rights reserved.
--
--    The primary authors of ayacc were David Taback and Deepak Tolani.
--    Enhancements were made by Ronald J. Schmalz.
--
--    Send requests for ayacc information to ayacc-info@ics.uci.edu
--    Send bug reports for ayacc to ayacc-bugs@ics.uci.edu
--
-- Redistribution and use in source and binary forms are permitted
-- provided that the above copyright notice and this paragraph are
-- duplicated in all such forms and that any documentation,
-- advertising materials, and other materials related to such
-- distribution and use acknowledge that the software was developed
-- by the University of California, Irvine.  The name of the
-- University may not be used to endorse or promote products derived
-- from this software without specific prior written permission.
-- THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
-- IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
-- WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

-- Module       : parse_template_file.ada
-- Component of : ayacc
-- Version      : 1.2
-- Date         : 11/21/86  12:33:32
-- SCCS File    : disk21~/rschm/hasee/sccs/ayacc/sccs/sxparse_template_file.ada

--**
--  6-Aug-2008 GdM: Added "at line ..." to Syntax Error
--        2006 GdM: Added ref to YY_Sizes package (no more hardcoding of sizes)

--**

-- $Header: /dc/uc/self/arcadia/ayacc/src/RCS/parse_template_file.a,v 1.1 1993/01/15 23:39:54 self Exp self $
-- $Log: parse_template_file.a,v $
-- Revision 1.1  1993/01/15  23:39:54  self
-- Initial revision
--
--Revision 1.1  88/08/08  14:20:23  arcadia
--Initial revision
--
-- Revision 0.1  86/04/01  15:09:47  ada
--  This version fixes some minor bugs with empty grammars
--  and $$ expansion. It also uses vads5.1b enhancements
--  such as pragma inline.
--
--
-- Revision 0.0  86/02/19  18:40:09  ada
--
-- These files comprise the initial version of Ayacc
-- designed and implemented by David Taback and Deepak Tolani.
-- Ayacc has been compiled and tested under the Verdix Ada compiler
-- version 4.06 on a vax 11/750 running Unix 4.2BSD.
--

with Ada.Strings.Fixed;
with Ada.Directories;

with Options;
with Ayacc_File_Names;
package body Parse_Template_File is

   use Ada.Text_IO;

   -- SCCS_ID : constant String := "@(#) parse_template_file.ada, Version 1.2";
   -- Rcs_ID : constant String := "$Header: /dc/uc/self/arcadia/ayacc/src/RCS/parse_template_file.a,v 1.1 1993/01/15 23:39:54 self Exp self $";

   DECL_CODE_FILENAME    : constant String := "code.miq";
   INIT_CODE_FILENAME    : constant String := "init.miq";

   function Get_Filename (Code : in Code_Filename) return String is
   begin
      case Code is
         when DECL_CODE =>
            return DECL_CODE_FILENAME;

         when INIT_CODE =>
            return INIT_CODE_FILENAME;

      end case;
   end Get_Filename;

   procedure Include_File (Outfile : in File_Type;
                           Filename : in String) is
      Input : File_Type;
   begin
      if not Ada.Directories.Exists (Filename) then
         return;
      end if;
      Open (Input, Ada.Text_IO.In_File, Filename);
      while not End_Of_File (Input) loop
         Put_Line (Outfile, Get_Line (Input));
      end loop;
      Close (Input);
   end Include_File;

   procedure Write_Indented (Outfile : in Ada.Text_IO.File_Type;
                             Line    : in String) is
      First : constant Positive_Count := Ada.Text_IO.Col (Outfile);
      Start : constant Natural := Ada.Strings.Fixed.Index (Line, "(");
      Pos   : Natural := Line'First;
      Sep   : Natural;
   begin
      while Pos <= Line'Last loop
         Sep := Ada.Strings.Fixed.Index (Line, ";", Pos);
         if Sep > 0 then
            Put_Line (Outfile, Line (Pos .. Sep));
            Pos := Sep + 1;
            Set_Col (Outfile, First + Positive_Count (Start - Line'First));
         else
            Put (Outfile, Line (Pos .. Line'Last));
            return;
         end if;
      end loop;
   end Write_Indented;

   procedure Write_Line (Outfile : in File_Type;
                         Line    : in String) is
      Start : Natural := Line'First;
      Pos   : Natural;
   begin
      while Start <= Line'Last loop
         Pos := Ada.Strings.Fixed.Index (Line, "${", Start);
         if Pos = 0 then
            Put_Line (Outfile, Line (Start .. Line'Last));
            exit;
         elsif Line (Pos .. Pos + 7) = "${YYLEX}" then
            declare
               Name : constant String := Ayacc_File_Names.Lex_Function_Name;
            begin
               Put (Outfile, Line (Start .. Pos - 1));
               if Name'Length > 0 then
                  Put (Outfile, Name);
               else
                  Put (Outfile, "YYLex");
               end if;
               Start := Pos + 8;

            end;
         elsif Line (Pos .. Pos + 9) = "${YYPARSE}" then
            Put (Outfile, Line (Start .. Pos - 1));
            Put (Outfile, Ayacc_File_Names.Get_Parse_Name);
            Start := Pos + 10;

         elsif Line (Pos .. Pos + 6) = "${NAME}" then
            Put (Outfile, Line (Start .. Pos - 1));
            Put (Outfile, Options.Ayacc_Stack_Size);
            Start := Pos + 7;

         elsif Line (Pos .. Pos + 14) = "${YYPARSEPARAM}" then
            Put (Outfile, Line (Start .. Pos - 1));
            Write_Indented (Outfile, Ayacc_File_Names.get_Parse_Params);
            Start := Pos + 15;

         elsif Line (Pos .. Pos + 13) = "${YYSTACKSIZE}" then
            begin
               Put (Outfile, Line (Start .. Pos - 1));
               Put (Outfile, Options.Ayacc_Stack_Size);
               Start := Pos + 14;
            end;
         else
            Put_Line (Outfile, Line (Start .. Line'Last));
            exit;
         end if;
         if Start > Line'Last then
            New_Line (Outfile);
         end if;
      end loop;
   end Write_Line;

   procedure Template_Writer (Outfile  : in File_Type) is

      type Section_Type is (S_COMMON,
                            S_IF_DEBUG,
                            S_IF_ERROR,
                            S_IF_PRIVATE,
                            S_IF_REENTRANT,
                            S_IF_YYERROK,
                            S_IF_YYCLEARIN);
      Current    : Section_Type := S_COMMON;
      Is_Visible : Boolean := True;
      Invert     : Boolean := False;
      Continue   : Boolean := True;
   begin
      while Continue and then Has_Line loop
         declare
            Line : constant String := Get_Line;
         begin
            if Line'Length = 0 then
               if Is_Visible then
                  New_Line (Outfile);
               end if;
            elsif Line (Line'First) = '%' then
               if Line = "%if debug" then
                  Current := S_IF_DEBUG;
                  Invert := False;
               elsif Line = "%if error" then
                  Current := S_IF_ERROR;
                  Invert := False;
               elsif Line = "%if private" then
                  Current := S_IF_PRIVATE;
                  Invert := False;
               elsif Line = "%if reentrant" then
                  Current := S_IF_REENTRANT;
                  Invert := False;
               elsif Line = "%if yyerrok" then
                  Current := S_IF_YYERROK;
                  Invert := False;
               elsif Line = "%if yyclearin" then
                  Current := S_IF_YYCLEARIN;
                  Invert := False;
               elsif Line = "%end" then
                  Current := S_COMMON;
                  Invert := False;
               elsif Line = "%else" then
                  Invert := True;
               elsif Line'Length > 3 and then Line (Line'First + 1) = '%' then
                  Continue := False;
                  return;
               elsif Line = "%yydecl" then
                  if Is_Visible then
                     Include_File (Outfile, DECL_CODE_FILENAME);
                  end if;
               elsif Line = "%yyinit" then
                  if Is_Visible then
                     Include_File (Outfile, INIT_CODE_FILENAME);
                  end if;
               else
                  --  Very crude error report when the template % line is invalid.
                  --  This could happen only during development when templates
                  --  are modified.
                  raise Program_Error with "Invalid template '%' rule: " & Line;
               end if;
               Is_Visible := (Current = S_COMMON)
                 or else (Current = S_IF_DEBUG and then Options.Debug)
                 or else (Current = S_IF_PRIVATE and then Options.Package_Private)
                 or else (Current = S_IF_REENTRANT and then Options.Reentrant)
                 or else (Current = S_IF_YYERROK and then not Options.Skip_Yyerrok)
                 or else (Current = S_IF_YYCLEARIN and then not Options.Skip_Yyclearin)
                 or else (Current = S_IF_ERROR and then Options.Error_Recovery_Extension);
               if Invert then
                  Is_Visible := not Is_Visible;
               end if;

            elsif Is_Visible then
               Write_Line (Outfile, Line);
            end if;
         end;
      end loop;
   end Template_Writer;

   procedure Write_Template (Outfile  : in File_Type;
                             Lines    : in Content_Array;
                             Position : in out Positive) is
      function Has_Line return Boolean is
      begin
         return Position <= Lines'Last;
      end Has_Line;

      function Get_Line return String is
      begin
         Position := Position + 1;
         return Lines (Position - 1).all;
      end Get_Line;

      procedure Write is new Template_Writer (Has_Line, Get_Line);

   begin
      Write (Outfile);
   end Write_Template;

   procedure Cleanup is
   begin
      if Ada.Directories.Exists (DECL_CODE_FILENAME) then
         Ada.Directories.Delete_File (DECL_CODE_FILENAME);
      end if;
      if Ada.Directories.Exists (INIT_CODE_FILENAME) then
         Ada.Directories.Delete_File (INIT_CODE_FILENAME);
      end if;
   end Cleanup;

end Parse_Template_File;
