-- $Header: /dc/uc/self/arcadia/ayacc/src/RCS/output_file_body.a,v 1.2 1993/05/31 22:36:35 self Exp self $

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

-- Module       : output_file_body.ada
-- Component of : ayacc
-- Version      : 1.2
-- Date         : 11/21/86  12:32:10
-- SCCS File    : disk21~/rschm/hasee/sccs/ayacc/sccs/sxoutput_file_body.ada

--**
--  7-Aug-2008 GdM: Added renaming for YY_IO
--**

-- $Header: /dc/uc/self/arcadia/ayacc/src/RCS/output_file_body.a,v 1.2 1993/05/31 22:36:35 self Exp self $
-- $Log: output_file_body.a,v $
-- Revision 1.2  1993/05/31  22:36:35  self
-- added exception handler when opening files
--
-- Revision 1.1  1993/05/31  22:05:03  self
-- Initial revision
--
--Revision 1.1  88/08/08  14:16:40  arcadia
--Initial revision
--
-- Revision 0.1  86/04/01  15:08:26  ada
--  This version fixes some minor bugs with empty grammars
--  and $$ expansion. It also uses vads5.1b enhancements
--  such as pragma inline.
--
--
-- Revision 0.0  86/02/19  18:37:50  ada
--
-- These files comprise the initial version of Ayacc
-- designed and implemented by David Taback and Deepak Tolani.
-- Ayacc has been compiled and tested under the Verdix Ada compiler
-- version 4.06 on a vax 11/750 running Unix 4.2BSD.
--

with Ada.Text_IO;
with Actions_File, Ayacc_File_Names, Options, Parse_Template_File, Source_File;
with Parse_Template_File.Templates;
use Actions_File, Ayacc_File_Names;

package body Output_File is

   use Ada;
   use Ada.Text_IO;

   -- SCCS_ID : constant String := "@(#) output_file_body.ada, Version 1.2";

   Outfile  : File_Type;
   Skelfile : File_Type;
   Use_External_Skeleton : Boolean := False;
   Body_Current_Line : Positive := 1;

   procedure Open_Skeleton (Path : in String) is
   begin
      if Is_Open (Skelfile) then
         raise Skeleton_Already_Defined;
      end if;
      Open (Skelfile, In_File, Path);

      Use_External_Skeleton := True;
   end Open_Skeleton;

   procedure Open is
   begin
      Create (Outfile, Out_File, Get_Out_File_Name);

   exception
      when Name_Error | Use_Error =>
         Put_Line ("Ayacc: Error Opening """ & Get_Out_File_Name & """.");
         raise;
   end Open;

   procedure Close is
   begin
      Close (Outfile);
   end Close;

   procedure Write_Template (Outfile  : in Ada.Text_IO.File_Type) is
      function Has_Line return Boolean is
      begin
         return not Ada.Text_IO.End_Of_File (Skelfile);
      end Has_Line;

      function Get_Line return String is
      begin
         return Ada.Text_IO.Get_Line (Skelfile);
      end Get_Line;

      procedure Write is new Parse_Template_File.Template_Writer (Has_Line, Get_Line);

   begin
      Write (Outfile);
    end Write_Template;

   -- skelout - write out one section of the skeleton file
   --
   -- DESCRIPTION
   --    Either outputs internal skeleton, or from a file with "%%" dividers
   --    if a skeleton file is specified by the user.
   --    Copies from skelfile to stdout until a line beginning with "%%" or
   --    EOF is found.

   procedure Skelout is
      use Parse_Template_File;
   begin
      if Use_External_Skeleton then
         Write_Template (Outfile);
      else
         Write_Template (Outfile,
                         Parse_Template_File.Templates.body_ayacc,
                         Body_Current_Line);
      end if;
   end Skelout;

   -- Make the parser body section by reading the source --
   -- and template files and merging them appropriately  --

   procedure Make_Output_File is
      Text   : String (1 .. 260);
      Length : Natural;
      I      : Integer;
      Proc_Decl : String (1 .. 260);
      Decl_Len  : Natural := 0;
   begin
      Open; -- Open the output file.
      Skelout;

      -- Read the first part of the source file up to '##'
      -- or to end of file.
      while not Source_File.Is_End_Of_File loop
         Source_File.Read_Line (Text, Length);
         if Length > 1 then
            I := 1;
            while (I < Length - 1 and then Text (I) = ' ') loop
               I := I + 1;
            end loop;
            if I + Length >= 21
              and then Text (I .. I + 21) = "##%procedure YYParse ("
            then
               Decl_Len := Length - I - 2;
               Proc_Decl (1 .. Decl_Len) := Text (I + 3 .. Length);
               exit;
            end if;
            if Text (I .. I + 1) = "##" then
               exit;
            end if;
         end if;
         Put_Line (Outfile, Text (1 .. Length));
      end loop;

      Parse_Template_File.Open;

      Skelout;

      Put_Line (Outfile, "      package yy_goto_tables renames");
      Put_Line (Outfile, "         " & Goto_Tables_Unit_Name & ';');

      Put_Line (Outfile, "      package yy_shift_reduce_tables renames");
      Put_Line (Outfile, "         " & Shift_Reduce_Tables_Unit_Name & ';');

      Put_Line (Outfile, "      package yy_tokens renames");
      Put_Line (Outfile, "         " & Tokens_Unit_Name & ';');

--          Put_Line (Outfile, "    package yy_io                  renames -- (+GdM 2008)");
--          declare
--            t: constant String:= Tokens_Unit_Name;
--          begin
--            Put_Line (Outfile, "      " & t(t'First..t'Last-6) & "IO" & ';');
--          end;

-- UMASS CODES :
      if Options.Error_Recovery_Extension then
         Put_Line (Outfile, "    -- UMASS CODES :");
         Put_Line (Outfile, "    package yy_error_report renames");
         Put_Line (Outfile, "      " & Error_Report_Unit_Name & ";");
         Put_Line (Outfile, "    -- END OF UMASS CODES.");
      end if;
-- END OF UMASS CODES.

      -- Consume Template Up To User Action Routines.
      Skelout;

      Actions_File.Open (Actions_File.Read_File);
      loop
         exit when Actions_File.Is_End_Of_File;
         Actions_File.Read_Line (Text, Length);
         Put_Line (Outfile, Text (1 .. Length));
      end loop;
      Actions_File.Delete;

      -- Finish writing the template file
      Skelout;
      Parse_Template_File.Close;

      -- Copy rest of input file after ##
      while not Source_File.Is_End_Of_File loop
         Source_File.Read_Line (Text, Length);
-- UMASS CODES :
--    If the generated codes has the extension of
--    error recovery, there may be another section
--    for error reporting. So we return if we find "%%".
         if Options.Error_Recovery_Extension then
            if Length > 1 and then Text (1 .. 2) = "%%" then
               exit;
            end if;
         end if;
-- END OF UMASS CODES.
         Put_Line (Outfile, Text (1 .. Length));
      end loop;

      Close;
   end Make_Output_File;

end Output_File;
