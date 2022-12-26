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

-- Module       : parse_table_body.ada
-- Component of : ayacc
-- Version      : 1.2
-- Date         : 11/21/86  12:33:16
-- SCCS File    : disk21~/rschm/hasee/sccs/ayacc/sccs/sxparse_table_body.ada

-- $Header: parse_table_body.a,v 0.1 86/04/01 15:08:38 ada Exp $
-- $Log:        parse_table_body.a,v $
-- Revision 0.1  86/04/01  15:08:38  ada
--  This version fixes some minor bugs with empty grammars
--  and $$ expansion. It also uses vads5.1b enhancements
--  such as pragma inline.
--
--
-- Revision 0.0  86/02/19  18:39:53  ada
--
-- These files comprise the initial version of Ayacc
-- designed and implemented by David Taback and Deepak Tolani.
-- Ayacc has been compiled and tested under the Verdix Ada compiler
-- version 4.06 on a vax 11/750 running Unix 4.2BSD.
--

with Lalr_Symbol_Info, Lr0_Machine, Symbol_Table, Rule_Table, Text_Io, Symbol_Info, Verbose_File, Options, Goto_File, Shift_Reduce_File;

use Lalr_Symbol_Info, Lr0_Machine, Symbol_Table, Rule_Table, Text_Io;

with Ada.Strings.Fixed;
use Ada.Strings, Ada.Strings.Fixed;

package body Parse_Table is

   -- SCCS_ID : constant String := "@(#) parse_table_body.ada, Version 1.2";
   -- Rcs_ID : constant String := "$Header: parse_table_body.a,v 0.1 86/04/01 15:08:38 ada Exp $";

   Show_Verbose : Boolean;     -- Set to options.verbose

   --
   -- The following declarations are for the "action" table.
   --

   type Action_Type is (UNDEFINED, ERROR, SHIFT, REDUCE, ACCEPT_INPUT);
   -- UNDEFINED and ERROR are the same accept you cannot replace
   -- ERROR entries by a default reduction.

   type Action_Table_Entry (Action : Action_Type := UNDEFINED) is record
      case Action is
         when SHIFT =>
            State_Id : Parse_State;
         when REDUCE =>
            Rule_Id : Rule;
         when ACCEPT_INPUT | ERROR | UNDEFINED =>
            null;
      end case;
   end record;

   type Action_Table_Array is
     array (Grammar_Symbol range <>) of Action_Table_Entry;
   type Action_Table_Array_Pointer is access Action_Table_Array;

   Action_Table_Row : Action_Table_Array_Pointer;
   -- Default_Action            : Action_Table_Entry;

   --
   -- The following declarations are for the "goto" table
   --

   type Goto_Table_Array is array (Grammar_Symbol range <>) of Parse_State;
   type Goto_Table_Array_Pointer is access Goto_Table_Array;

   Goto_Table_Row : Goto_Table_Array_Pointer;

   --
   type Goto_Offset_Array is array (Parse_State range <>) of Integer;
   type Goto_Offset_Array_Pointer is access Goto_Offset_Array;
   Goto_Offset : Goto_Offset_Array_Pointer;

   type Action_Offset_Array is array (Parse_State range <>) of Integer;
   type Action_Offset_Array_Pointer is access Action_Offset_Array;
   Action_Offset : Action_Offset_Array_Pointer;
   --

   Error_Code  : constant := -3_000;      -- generated parser must use these
   Accept_Code : constant := -3_001;

   Num_Of_Goto_Entries   : Integer := 0;
   Num_Of_Action_Entries : Integer := 0;

   Num_Shift_Reduce_Conflicts  : Natural := 0;
   Num_Reduce_Reduce_Conflicts : Natural := 0;

   function Shift_Reduce_Conflicts return Natural is
   begin
      return Num_Shift_Reduce_Conflicts;
   end Shift_Reduce_Conflicts;

   function Reduce_Reduce_Conflicts return Natural is
   begin
      return Num_Reduce_Reduce_Conflicts;
   end Reduce_Reduce_Conflicts;

   function Number_Of_States return Natural is
   begin
      return Natural (Lr0_Machine.Last_Parse_State + 1);
   end Number_Of_States;

   function Size_Of_Goto_Table return Natural is
   begin
      return Num_Of_Goto_Entries;
   end Size_Of_Goto_Table;

   function Size_Of_Action_Table return Natural is
   begin
      return Num_Of_Action_Entries;
   end Size_Of_Action_Table;

   procedure Print_Goto_Row_Verbose is
   begin
      for Sym in Goto_Table_Row.all'Range loop
         if Goto_Table_Row (Sym) /= Null_Parse_State then
            Verbose_File.Write (Ascii.Ht);
            Verbose_File.Print_Grammar_Symbol (Sym);
            Verbose_File.Write (" " & Ascii.Ht);
            Verbose_File.Write_Line
              ("goto " & Parse_State'Image (Goto_Table_Row (Sym)));
         end if;
      end loop;
   end Print_Goto_Row_Verbose;

   procedure Print_Goto_Row (State : in Parse_State) is
      S                           : Parse_State;
      Terminate_Line, First_Entry : Boolean;
      Entries_In_Row              : Integer := 0;
   begin

      Goto_Offset (State) := Num_Of_Goto_Entries;
      Terminate_Line      := False;
      First_Entry         := True;

      for I in Goto_Table_Row.all'Range loop

         S := Goto_Table_Row (I);

         if S /= -1 then

            if First_Entry then
               Goto_File.Write_Line
                 ("      --  State " & Parse_State'Image (State));
               First_Entry := False;
            end if;

            Goto_File.Write_Indented (",");

            Goto_File.Write
              (" (" & Grammar_Symbol'Image (I) & "," & Parse_State'Image (S) &
               ")");
            Terminate_Line      := True;
            Num_Of_Goto_Entries := Num_Of_Goto_Entries + 1;
            Entries_In_Row      := Entries_In_Row + 1;

            if Entries_In_Row mod 5 = 0 then
               Goto_File.Write_Line ("");
               Goto_File.Write ("      ");
               Terminate_Line := False;
            end if;

         end if;

      end loop;

      if Terminate_Line then
         Goto_File.Write_Line ("");
      end if;

   end Print_Goto_Row;

-----------------------------------------------------------------------

   procedure Print_Action_Row (State : in Parse_State) is
      Temp           : Action_Table_Entry;
      X              : Integer;
      Default        : Integer;
      First_Entry    : Boolean;
      Entries_In_Row : Integer := 0;

      function Get_Default_Entry return Integer is
      begin
         for I in Action_Table_Row.all'Range loop
            if Action_Table_Row (I).Action = REDUCE then
               return -Integer (Action_Table_Row (I).Rule_Id);
            end if;
         end loop;
         return Error_Code;
      end Get_Default_Entry;

   begin
      Action_Offset (State) := Num_Of_Action_Entries;
      First_Entry           := True;

      Default := Get_Default_Entry;

      for I in Action_Table_Row.all'Range loop
         Temp := Action_Table_Row (I);
         case Temp.Action is
            when UNDEFINED =>
               X := Default;
            when SHIFT =>
               X := Integer (Temp.State_Id);
            when REDUCE =>
               X := -Integer (Temp.Rule_Id);
            when ACCEPT_INPUT =>
               X := Accept_Code;
            when ERROR =>
               X := Error_Code;
         end case;

         if X /= Default then

            if First_Entry then
               Shift_Reduce_File.Write_Line
                 ("      --  State " & Parse_State'Image (State));
               First_Entry := False;
            end if;

            Shift_Reduce_File.Write_Indented (", ");

            Shift_Reduce_File.Write
              ("(" & Trim (Grammar_Symbol'Image (I), Left) & ", ");
            Shift_Reduce_File.Write (Trim (Integer'Image (X), Left) & ")");
            Num_Of_Action_Entries := Num_Of_Action_Entries + 1;

            Entries_In_Row := Entries_In_Row + 1;

            if Entries_In_Row mod 7 = 0 then
               Shift_Reduce_File.Write_Line ("");
               Shift_Reduce_File.Write ("      ");
            end if;

            if Show_Verbose then
               Verbose_File.Write (" " & Ascii.Ht);
               Verbose_File.Print_Grammar_Symbol (I);
               Verbose_File.Write (" " & Ascii.Ht);
               if X = Accept_Code then
                  Verbose_File.Write_Line ("accept");
               elsif X = Error_Code then
                  Verbose_File.Write_Line ("error");
               elsif X > 0 then  -- SHIFT
                  Verbose_File.Write_Line ("shift " & Integer'Image (X));
               else -- REDUCE
                  Verbose_File.Write_Line ("reduce " & Integer'Image (-X));
               end if;
            end if;
         end if;

      end loop;

      if Show_Verbose then
         Verbose_File.Write (" " & Ascii.Ht);
         Verbose_File.Write ("default " & Ascii.Ht);
         if Default = Accept_Code then
            Verbose_File.Write_Line ("accept");
         elsif Default = Error_Code then
            Verbose_File.Write_Line ("error");
         else -- reduce. never shift
            Verbose_File.Write_Line ("reduce " & Integer'Image (-Default));
         end if;
      end if;

      if First_Entry then
         Shift_Reduce_File.Write_Line
           ("      --  State " & Parse_State'Image (State));
         First_Entry := False;
      end if;
      Shift_Reduce_File.Write_Indented (", ");

      Shift_Reduce_File.Write
        ("(" & Trim (Grammar_Symbol'Image (-1), Left) & ", ");
      Shift_Reduce_File.Write (Trim (Integer'Image (Default), Left) & ")");
      Num_Of_Action_Entries := Num_Of_Action_Entries + 1;

      Shift_Reduce_File.Write_Line ("");

   end Print_Action_Row;

-----------------------------------------------------------------------

   procedure Init_Table_Files is
   begin

      Goto_Offset :=
        new Goto_Offset_Array (First_Parse_State .. Last_Parse_State);

      Action_Offset :=
        new Action_Offset_Array (First_Parse_State .. Last_Parse_State);
   end Init_Table_Files;

   procedure Finish_Table_Files is
   begin
      Goto_File.Write_Indented (");");
      Goto_File.Write_Line ("");
      Goto_File.Write_Line ("");
      Goto_File.Write_Line ("   --  The offset vector");
      Goto_File.Write ("   Goto_Offset : constant array (0 ..");
      Goto_File.Write (Parse_State'Image (Goto_Offset.all'Last) & ')');
      Goto_File.Write_Line (" of Row :=");
      Goto_File.Write ("      (");
      for I in Goto_Offset.all'First .. Goto_Offset.all'Last - 1 loop
         Goto_File.Write (Trim (Integer'Image (Goto_Offset (I)), Left) & ",");
         if I mod 10 = 0 then
            Goto_File.Write_Line ("");
            Goto_File.Write ("      ");
         else
            Goto_File.Write (" ");
         end if;
      end loop;
      Goto_File.Write
        (Trim (Integer'Image (Goto_Offset (Goto_Offset.all'Last)), Left));
      Goto_File.Write_Line (");");
      Goto_File.Write_Line ("");
      Goto_File.Close_Write;

      Shift_Reduce_File.Write_Indented (");");
      Shift_Reduce_File.Write_Line ("");
      Shift_Reduce_File.Write_Line ("");
      Shift_Reduce_File.Write_Line ("   --  The offset vector");
      Shift_Reduce_File.Write
        ("   Shift_Reduce_Offset : constant array (0 ..");
      Shift_Reduce_File.Write
        (Parse_State'Image (Action_Offset.all'Last) & ')');

      Shift_Reduce_File.Write_Line (" of Row :=");
      Shift_Reduce_File.Write ("      (");

      for I in Action_Offset.all'First .. Action_Offset.all'Last - 1 loop
         if I = Action_Offset.all'First then
            Shift_Reduce_File.Write
              (Trim (Integer'Image (Action_Offset (I)), Left) & ",");
         else
            Shift_Reduce_File.Write (Integer'Image (Action_Offset (I)) & ",");
         end if;

         if I mod 10 = 0 then
            Shift_Reduce_File.Write_Line ("");
            Shift_Reduce_File.Write ("      ");
         end if;

      end loop;

      Shift_Reduce_File.Write
        (Integer'Image (Action_Offset (Action_Offset.all'Last)));
      Shift_Reduce_File.Write_Line (");");
      Shift_Reduce_File.Write_Line ("");

      Shift_Reduce_File.Close_Write;

   end Finish_Table_Files;

   procedure Compute_Parse_Table is

      use Item_Set_Pack;
      use Grammar_Symbol_Set_Pack;

      Trans        : Transition;
      Nonterm_Iter : Nt_Transition_Iterator;
      Term_Iter    : T_Transition_Iterator;

      Item_Set_1 : Item_Set;
      Item_Iter  : Item_Iterator;
      Temp_Item  : Item;

      Lookahead_Set : Grammar_Symbol_Set;
      Sym_Iter      : Grammar_Symbol_Iterator;
      Sym           : Grammar_Symbol;

      -- these variables are used for resolving conflicts
      Sym_Prec  : Precedence;
      Rule_Prec : Precedence;
      Sym_Assoc : Associativity;

      -- recduce by r or action in action_table_row(sym);
      procedure Report_Conflict (R : Rule; Sym : in Grammar_Symbol) is
      begin
         if Show_Verbose then
            Verbose_File.Write ("*** Conflict on input ");
            Verbose_File.Print_Grammar_Symbol (Sym);
            Verbose_File.Write_Line;
            Verbose_File.Write (Ascii.Ht);
            Verbose_File.Write ("Reduce " & Rule'Image (R));
            Verbose_File.Write (Ascii.Ht);
            Verbose_File.Write ("or");
            Verbose_File.Write (Ascii.Ht);
         end if;
         case Action_Table_Row (Sym).Action is
            when SHIFT =>

               Num_Shift_Reduce_Conflicts := Num_Shift_Reduce_Conflicts + 1;

               if Show_Verbose then
                  Verbose_File.Write ("Shift ");
                  Verbose_File.Write_Line
                    (Parse_State'Image (Action_Table_Row (Sym).State_Id));
               end if;

            when REDUCE =>

               Num_Reduce_Reduce_Conflicts := Num_Reduce_Reduce_Conflicts + 1;

               if Show_Verbose then
                  Verbose_File.Write ("Reduce ");
                  Verbose_File.Write_Line
                    (Rule'Image (Action_Table_Row (Sym).Rule_Id));
               end if;
            when ACCEPT_INPUT =>
               if Show_Verbose then
                  Verbose_File.Write ("Accept???"); -- won't happen
               end if;
               Put_Line ("Ayacc: Internal Error in Report Conflict!");
            when ERROR =>
               if Show_Verbose then
                  Verbose_File.Write_Line ("Error???"); -- won't happen
               end if;
               Put_Line ("Ayacc: Internal Error in Report Conflict!");
            when UNDEFINED =>
               Put_Line ("Ayacc: Internal Error in Report Conflict!");
         end case;
         if Show_Verbose then
            Verbose_File.Write_Line;
         end if;
      end Report_Conflict;

   begin

      Action_Table_Row :=
        new Action_Table_Array
          (First_Symbol (Terminal) .. Last_Symbol (Terminal));
      Goto_Table_Row :=
        new Goto_Table_Array
          (First_Symbol (Nonterminal) .. Last_Symbol (Nonterminal));

      Init_Table_Files;

      for S in First_Parse_State .. Last_Parse_State loop

--& The verdix compiler apparently ALOCATES more memory for the following
--& assignments. We commented them out and replaced these statements by
--& the for loops
--&         action_table_row.all :=
--&             (action_table_row.all'range => (action => undefined));
--&         goto_table_row.all :=
--&             (goto_table_row.all'range => null_parse_state);

         for I in Action_Table_Row.all'Range loop
            Action_Table_Row (I) := (Action => UNDEFINED);
         end loop;

         for I in Goto_Table_Row.all'Range loop
            Goto_Table_Row (I) := Null_Parse_State;
         end loop;

         Make_Null (Item_Set_1);
         Get_Kernel (S, Item_Set_1);

         if Show_Verbose then
            Verbose_File.Write_Line ("------------------");
            Verbose_File.Write_Line ("State " & Parse_State'Image (S));
            Verbose_File.Write_Line;
            Verbose_File.Write_Line ("Kernel");
            Verbose_File.Print_Item_Set (Item_Set_1);
         end if;

         Closure (Item_Set_1);

         if Show_Verbose then
            Verbose_File.Write_Line;
            Verbose_File.Write_Line ("Closure");
            Verbose_File.Print_Item_Set (Item_Set_1);
            Verbose_File.Write_Line;
            Verbose_File.Write_Line;
         end if;

         --    Make Shift Entries    --

         Initialize (Term_Iter, S);
         while More (Term_Iter) loop
            Next (Term_Iter, Trans);
            if Trans.Symbol = End_Symbol then
               Action_Table_Row (Trans.Symbol) := (Action => Accept_Input);
            else
               Action_Table_Row (Trans.Symbol) :=
                 (Action => Shift, State_Id => Trans.State_Id);
            end if;
         end loop;

         --    Make Goto Entries    --

         Initialize (Nonterm_Iter, S);
         while More (Nonterm_Iter) loop
            Next (Nonterm_Iter, Trans);
            Goto_Table_Row (Trans.Symbol) := Trans.State_Id;
         end loop;

         --    Make Reduce Entries    ----

         Initialize (Item_Iter, Item_Set_1);

         -- check for degenerate reduce --

         if Size_Of (Item_Set_1) = 1 then
            Next (Item_Iter, Temp_Item);
            if Temp_Item.Dot_Position = Length_Of (Temp_Item.Rule_Id)
              and then Temp_Item.Rule_Id /= First_Rule
            then
               Action_Table_Row (First_Symbol (Terminal)) :=
                 (Action => Reduce, Rule_Id => Temp_Item.Rule_Id);
            end if;
            goto Continue_Loop;
         end if;

         -- The following is really messy. It used to be ok before
         -- we added precedence. Some day we should rewrite it.
         while More (Item_Iter) loop
            Next (Item_Iter, Temp_Item);
            if Temp_Item.Dot_Position = Length_Of (Temp_Item.Rule_Id)
              and then Temp_Item.Rule_Id /= First_Rule
            then
               Make_Null (Lookahead_Set);
               Get_La (S, Temp_Item, Lookahead_Set);
               Initialize (Sym_Iter, Lookahead_Set);
               while More (Sym_Iter) loop
                  Next (Sym_Iter, Sym);

                  case Action_Table_Row (Sym).Action is

                     when UNDEFINED =>
                        Action_Table_Row (Sym) :=
                          (Action => REDUCE, Rule_Id => Temp_Item.Rule_Id);

                     when SHIFT =>
                        Sym_Prec  := Get_Precedence (Sym);
                        Rule_Prec := Get_Rule_Precedence (Temp_Item.Rule_Id);

                        if Sym_Prec = 0 or else Rule_Prec = 0 then
                           Report_Conflict (Temp_Item.Rule_Id, Sym);
                        elsif Rule_Prec > Sym_Prec then
                           Action_Table_Row (Sym) :=
                             (Action => REDUCE, Rule_Id => Temp_Item.Rule_Id);
                        elsif Sym_Prec > Rule_Prec then
                           null; -- already ok
                        else
                           Sym_Assoc := Get_Associativity (Sym);
                           if Sym_Assoc = Left_Associative then
                              Action_Table_Row (Sym) :=
                                (Action  => REDUCE,
                                 Rule_Id => Temp_Item.Rule_Id);
                           elsif Sym_Assoc = Right_Associative then
                              null;
                           elsif Sym_Assoc = Nonassociative then
                              Action_Table_Row (Sym) := (Action => ERROR);
                           else
                              Put_Line
                                ("Ayacc: Possible Error in " &
                                 "Conflict Resolution.");
                           end if;
                        end if;

                     when REDUCE =>
                        Report_Conflict (Temp_Item.Rule_Id, Sym);

                     when ERROR =>
                        Put_Line ("Ayacc: Internal Error in Conflict!!!");
                        Put_Line ("Ayacc: Use Verbose Option!");
                        Report_Conflict (Temp_Item.Rule_Id, Sym);

                     when ACCEPT_INPUT =>
                        Put_Line ("Ayacc: Internal Error in Conflict!!!");
                        Put_Line ("Ayacc: Use Verbose Option!");
                        Report_Conflict (Temp_Item.Rule_Id, Sym);

                  end case;
               end loop;
            end if;
         end loop;

         <<Continue_Loop>>

         Goto_File.Open_Write;
         Shift_Reduce_File.Open_Write;
         if Show_Verbose then
            Print_Goto_Row_Verbose;
         end if;

         Print_Goto_Row (S);
         Print_Action_Row (S);

      end loop;

      Finish_Table_Files;
   end Compute_Parse_Table;

   procedure Make_Parse_Table is
   begin

      Show_Verbose := Options.Verbose;

      if Show_Verbose then
         Verbose_File.Open;
      end if;

      Symbol_Info.Initialize;

      if Options.Loud then
         Put_Line ("Ayacc: Making LR(0) Machine.");
      end if;

      Lr0_Machine.Lr0_Initialize;

      if Options.Loud then
         Put_Line ("Ayacc: Making Follow Sets.");
      end if;

      Make_Lalr_Sets;

      if Options.Loud then
         Put_Line ("Ayacc: Making Parse Table.");
      end if;

      Compute_Parse_Table;

      if Show_Verbose then
         Verbose_File.Close;
      end if;

   end Make_Parse_Table;

end Parse_Table;
