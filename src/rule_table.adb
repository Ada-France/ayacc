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

-- Module       : rule_table_body.ada
-- Component of : ayacc
-- Version      : 1.2
-- Date         : 11/21/86  12:34:28
-- SCCS File    : disk21~/rschm/hasee/sccs/ayacc/sccs/sxrule_table_body.ada

-- $Header: rule_table_body.a,v 0.1 86/04/01 15:11:44 ada Exp $
-- $Log:        rule_table_body.a,v $
-- Revision 0.1  86/04/01  15:11:44  ada
--  This version fixes some minor bugs with empty grammars
--  and $$ expansion. It also uses vads5.1b enhancements
--  such as pragma inline.
--
--
-- Revision 0.0  86/02/19  18:41:08  ada
--
-- These files comprise the initial version of Ayacc
-- designed and implemented by David Taback and Deepak Tolani.
-- Ayacc has been compiled and tested under the Verdix Ada compiler
-- version 4.06 on a vax 11/750 running Unix 4.2BSD.
--

package body Rule_Table is

   -- SCCS_ID : constant String := "@(#) rule_table_body.ada, Version 1.2";
   -- Rcs_ID : constant String := "$Header: rule_table_body.a,v 0.1 86/04/01 15:11:44 ada Exp $";

   -- Rules are implemented as an array of linked lists

   Number_Of_Nested_Rules : Integer := 0;

   type Rhs_Element;
   type Rhs_Pointer is access Rhs_Element;

   type Rhs_Element is record
      Rhs_Symbol : Grammar_Symbol;
      Next       : Rhs_Pointer;
   end record;

   type Rule_Entry is record
      Lhs_Symbol : Grammar_Symbol;
      Rhs        : Rhs_Pointer;
      Length     : Natural;
      Null_Pos   : Natural;
      Prec       : Precedence;
   end record;

   Rule_List : array (Rule) of Rule_Entry;

   Next_Free_Rule : Rule := 0;

   function Get_Rule_Precedence (R : Rule) return Precedence is
   begin
      return Rule_List (R).Prec;
   end Get_Rule_Precedence;

   function Make_Rule (Lhs : Grammar_Symbol) return Rule is
      R : constant Rule := Next_Free_Rule;
   begin
      Rule_List (R) :=
        (Lhs, Rhs => null, Length => 0, Null_Pos => 0, Prec => 0);
      Next_Free_Rule := Next_Free_Rule + 1;
      return R;
   end Make_Rule;

   procedure Append_Rhs (R : in Rule; Rhs : in Grammar_Symbol) is
      Temp_Pointer : Rhs_Pointer;
   begin
      if Is_Terminal (Rhs) then
         Rule_List (R).Prec := Get_Precedence (Rhs);
      end if;
      if Rule_List (R).Rhs = null then
         Rule_List (R).Rhs := new Rhs_Element'(Rhs, null);
      else
         Temp_Pointer := Rule_List (R).Rhs;
         while Temp_Pointer.Next /= null loop
            Temp_Pointer := Temp_Pointer.Next;
         end loop;
         Temp_Pointer.Next := new Rhs_Element'(Rhs, null);
      end if;
      Rule_List (R).Length := Rule_List (R).Length + 1;
   end Append_Rhs;

   function Get_Lhs (R : Rule) return Grammar_Symbol is
   begin
      return Rule_List (R).Lhs_Symbol;
   end Get_Lhs;

   function Get_Null_Pos (R : Rule) return Natural is
   begin
      return Rule_List (R).Null_Pos;
   end Get_Null_Pos;

   procedure Set_Null_Pos (R : in Rule; Position : in Natural) is
   begin
      Rule_List (R).Null_Pos := Position;
   end Set_Null_Pos;

   function Get_Rhs (R : Rule; Position : Positive) return Grammar_Symbol is
      Temp_Pointer : Rhs_Pointer;
   begin
      Temp_Pointer := Rule_List (R).Rhs;
      for I in 2 .. Position loop
         Temp_Pointer := Temp_Pointer.Next;
      end loop;
      return Temp_Pointer.Rhs_Symbol;
   end Get_Rhs;

   function Length_Of (R : Rule) return Natural is
   begin
      return Rule_List (R).Length;
   end Length_Of;

   function First_Rule return Rule is
   begin
      return 0;
   end First_Rule;

   function Last_Rule return Rule is
   begin
      return Next_Free_Rule - 1;
   end Last_Rule;

   function Number_Of_Rules return Natural is
   begin
      return Natural (Next_Free_Rule) - 1;
   end Number_Of_Rules;

   procedure Handle_Nested_Rule (Current_Rule : in out Rule) is
      Temp     : Rule_Entry;
      Lhs      : Grammar_Symbol;
      New_Rule : Rule;
   begin
      -- Make a new rule prefixed by $$N
      Number_Of_Nested_Rules := Number_Of_Nested_Rules + 1;
      Lhs := Insert_Identifier ("$$" & Integer'Image (Number_Of_Nested_Rules));
      New_Rule               := Make_Rule (Lhs);
      Append_Rhs (Current_Rule, Lhs);

      -- Exchange the rule positions of the new rule and the current rule
      -- by swapping contents and exchanging the rule positions
      Temp                     := Rule_List (Current_Rule);
      Rule_List (Current_Rule) := Rule_List (New_Rule);
      Rule_List (New_Rule)     := Temp;
      Current_Rule             := New_Rule;
   end Handle_Nested_Rule;

   procedure Set_Rule_Precedence (R : in Rule; Prec : in Precedence) is
   begin
      Rule_List (R).Prec := Prec;
   end Set_Rule_Precedence;

end Rule_Table;
