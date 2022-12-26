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

-- Module       : lalr_symbol_info_body.ada
-- Component of : ayacc
-- Version      : 1.2
-- Date         : 11/21/86  12:30:08
-- SCCS File    : disk21~/rschm/hasee/sccs/ayacc/sccs/sxlalr_symbol_info_body.ada

-- $Header: /dc/uc/self/arcadia/ayacc/src/RCS/lalr_symbol_info_body.a,v 1.1 1993/05/24 19:42:25 self Exp self $
-- $Log: lalr_symbol_info_body.a,v $
-- Revision 1.1  1993/05/24  19:42:25  self
-- Initial revision
--
-- Revision 0.1  86/04/01  15:04:40  ada
--  This version fixes some minor bugs with empty grammars
--  and $$ expansion. It also uses vads5.1b enhancements
--  such as pragma inline.
--
--
-- Revision 0.0  86/02/19  18:36:47  ada
--
-- These files comprise the initial version of Ayacc
-- designed and implemented by David Taback and Deepak Tolani.
-- Ayacc has been compiled and tested under the Verdix Ada compiler
-- version 4.06 on a vax 11/750 running Unix 4.2BSD.
--

with Stack_Pack, Ragged;
pragma Elaborate_All (Ragged);

with Symbol_Table, Symbol_Info, Rule_Table;
use Symbol_Table, Symbol_Info, Rule_Table;

with Text_Io; use Text_Io;

package body Lalr_Symbol_Info is

   -- SCCS_ID : constant String := "@(#) lalr_symbol_info_body.adadisk21~/rschm/hasee/sccs/ayacc, Version 1.2";

   package Relation is

      procedure Make_Reads_Relation;

      procedure Make_Includes_Relation;

      procedure Reads (Lhs : Transition; Rhs : in out Transition_Set);

      procedure Includes (Lhs : Transition; Rhs : in out Transition_Set);

      procedure Free_Includes;

   end Relation;

   package body Relation is

      -- SCCS_ID : constant String := "@(#) lalr_symbol_info_body.adadisk21~/rschm/hasee/sccs/ayacc, Version 1.2";

      package Includes_Relation is new Ragged
        (Parse_State, Grammar_Symbol, Transition_Set,
         Transition_Set_Pack.Make_Null);

      procedure Make_Reads_Relation is
      begin
         -- Don't need to do anything. Get READS from the LR0 machine
         null;
      end Make_Reads_Relation;

      --     Implements Algorithm D1 in Park's paper
      --         "A New Analysis of LALR Formalisms" Park et al.
      --         ACM Transactions on Programming Languages and Systems,
      --         Vol 7,January 85.

      use Includes_Relation, Item_Set_Pack, Parse_State_Set_Pack,
        Transition_Set_Pack;

      procedure Make_Includes_Relation is
         Preds     : Parse_State_Set;
         Pred_Loop : Parse_State_Iterator;
         Temp      : Transition;

         A, B : Grammar_Symbol;
         R    : Parse_State;

         I          : Item;
         Items      : Item_Set;
         Item_Index : Item_Iterator;

      begin
         Make_Array (First_Parse_State, Last_Parse_State);

         for Q in First_Parse_State .. Last_Parse_State loop

            -- Loop over all items [B ->B1 . A B2] in state Q
            -- Where A is a nonterminal and the string B2 is nullable.

            Get_Kernel (Q, Items);
            Closure (Items);
            Initialize (Item_Index, Items);
            while More (Item_Index) loop
               Next (Item_Index, I);

               -- Is the item of the form [B ->B1 . A B2] ?

               if I.Dot_Position = Length_Of (I.Rule_Id) then
                  goto Continue;     -- Nothing to the right of dot
               elsif I.Dot_Position + 1 < Get_Null_Pos (I.Rule_Id) then
                  goto Continue;     -- B2 is not nullable
               end if;
               A := Get_Rhs (I.Rule_Id, I.Dot_Position + 1);
               B := Get_Lhs (I.Rule_Id);
               if Is_Terminal (A) then
                  goto Continue;     -- A is not a nonterminal
               end if;

               -- for all states R in PRED(Q,B1) (Q,A) INCLUDES (R,B)

               Make_Null (Preds);
               Get_Pred_Set (Q, I, Preds);
               Initialize (Pred_Loop, Preds);
               while More (Pred_Loop) loop
                  Next (Pred_Loop, R);
                  Temp.State_Id := R;
                  Temp.Symbol   := B;
                  Insert (Temp, Into => Includes_Relation.Lval (Q, A).Value);
               end loop;

               <<Continue>>
               null;
            end loop;
         end loop;
         -- Free
         Make_Null (Preds);
         Make_Null (Items);
      end Make_Includes_Relation;

      procedure Free_Includes is
      begin
         Includes_Relation.Free_Array;
      end Free_Includes;

      use Grammar_Symbol_Set_Pack;
      procedure Reads (Lhs : Transition; Rhs : in out Transition_Set) is
         Temp  : Transition;
         Gotos : Grammar_Symbol_Set;
         Index : Grammar_Symbol_Iterator;
      begin
         Make_Null (Rhs);
         Temp.State_Id := Get_Goto (Lhs.State_Id, Lhs.Symbol);

         Get_Transition_Symbols (Temp.State_Id, Nonterminals, Gotos);
         Initialize (Index, Gotos);
         while More (Index) loop
            Next (Index, Temp.Symbol);
            if Is_Nullable (Temp.Symbol) then
               Insert (Temp, Into => Rhs);
            end if;
         end loop;

         -- Free
         Make_Null (Gotos);
      end Reads;

      procedure Includes (Lhs : Transition; Rhs : in out Transition_Set) is
      begin
         -- Free
         Make_Null (Rhs);
         -- Could use fassign but dangerous
         Assign (Rhs, Includes_Relation.Lval (Lhs.State_Id, Lhs.Symbol).Value);
      end Includes;

   end Relation;
--------------------------------------------------------------------------
   use Relation;
   package Lalr_Sets_Pack is
      procedure Make_Dr_Sets;
      procedure Make_Read_Sets;
      procedure Make_Follow_Sets;
      --  procedure Follow(
      --      Trans     : Transition;
      --      Follow_Set: in out Grammar_Symbol_Set);

      procedure Union_Follow_Sets
        (Trans : Transition; Follow_Set : in out Grammar_Symbol_Set);

   end Lalr_Sets_Pack;

   package body Lalr_Sets_Pack is

      -- SCCS_ID : constant String := "@(#) lalr_symbol_info_body.adadisk21~/rschm/hasee/sccs/ayacc, Version 1.2";

      -- The DR, Read, and Follow sets are all stored in the same data
      -- structure in package lalr_sets.

      type Relation_Type is (USE_READS, USE_INCLUDES);

      package Lalr_Sets is new Ragged
        (Parse_State, Grammar_Symbol, Grammar_Symbol_Set,
         Grammar_Symbol_Set_Pack.Make_Null);

      use Lalr_Sets, Grammar_Symbol_Set_Pack, Transition_Set_Pack;
      procedure Make_Dr_Sets is
         Trans : Transition;
         -- gotos      : transition_set;
         Goto_Index : Nt_Transition_Iterator;
         Term_Sym   : Grammar_Symbol;
         Terms      : Grammar_Symbol_Set;
         Term_Index : Grammar_Symbol_Iterator;

      begin
         -- Make storage to hold the DR sets.
         Lalr_Sets.Make_Array (First_Parse_State, Last_Parse_State);

         -- DR(P,Symbol) = { x is a terminal|P -Symbol-> Next_State -x->}
         for P in First_Parse_State .. Last_Parse_State loop

            -- Get all transitions (Symbol,Next_State) out of state P
            -- get_transitions(P, nonterminals, gotos);

            Initialize (Goto_Index, P);
            while More (Goto_Index) loop
               Next (Goto_Index, Trans);
               Get_Transition_Symbols (Trans.State_Id, Terminals, Terms);
               Initialize (Term_Index, Terms);

               while More (Term_Index) loop
                  Next (Term_Index, Term_Sym);
                  Insert
                    (Term_Sym, Into => Lalr_Sets.Lval (P, Trans.Symbol).Value);
               end loop;

            end loop;
         end loop;
         -- make_null(gotos);
         Make_Null (Terms);
      end Make_Dr_Sets;

      procedure Initialize_N (X : in out Integer) is
      begin
         X := 0;
      end Initialize_N;

      procedure Digraph (R : Relation_Type) is

         package N is new Ragged
           (Parse_State, Grammar_Symbol, Integer, Initialize_N);

         package Transition_Stack is new Stack_Pack (Transition);
         use Transition_Stack;

         Trans_Stack : Stack;
         Symbol      : Grammar_Symbol;
         Gotos       : Grammar_Symbol_Set;
         Goto_Index  : Grammar_Symbol_Iterator;
         Trans       : Transition;

         procedure Traverse (X : Transition) is
            Infinity             : constant Integer := Integer'Last;
            Depth                : Integer;
            Lalr_Sets_Lval_Index : Lalr_Sets.Index;
            Minimum              : Integer;
            Y, Top               : Transition;
            Rhs_Set              : Transition_Iterator;
            Related              : Transition_Set;

         begin
            Push (Trans_Stack, X);
            Depth := Depth_Of_Stack (Trans_Stack);
            N.Lval (X.State_Id, X.Symbol).Value := Depth;

            -- Should take a procedure parameter instead of a key
            if R = Use_Reads then
               Reads (X, Related);
            else
               Includes (X, Related);
            end if;

            Initialize (Rhs_Set, Related);
            while More (Rhs_Set) loop
               Next (Rhs_Set, Y);
               if N.Lval (Y.State_Id, Y.Symbol).Value = 0 then
                  Traverse (Y);
               end if;

               Minimum := N.Rval (Y.State_Id, Y.Symbol).Value;
               if Minimum < N.Rval (X.State_Id, X.Symbol).Value then
                  N.Lval (X.State_Id, X.Symbol).Value := Minimum;
               end if;
               Insert
                 (Lalr_Sets.Lval (Y.State_Id, Y.Symbol).Value,
                  Into => Lalr_Sets.Lval (X.State_Id, X.Symbol).Value);
            end loop;

            if N.Rval (X.State_Id, X.Symbol).Value = Depth then
               loop
                  Top := Top_Value (Trans_Stack);
                  N.Lval (Top.State_Id, Top.Symbol).Value := Infinity;

                  Lalr_Sets_Lval_Index :=
                    Lalr_Sets.Lval (Top.State_Id, Top.Symbol);
                  Assign
                    (Lalr_Sets_Lval_Index.Value,
                     Lalr_Sets.Rval (X.State_Id, X.Symbol).Value);
                  Pop (Trans_Stack, Top);
                  exit when Top = X;
               end loop;
            end if;

            -- Free
            Make_Null (Related);

         exception
            when Value_Range_Error =>
               Put_Line ("Ayacc: Value Range Error in Traverse");
               raise;
            when Stack_Underflow =>
               Put_Line ("Ayacc: Stack Underflow in Traverse");
               raise;
            when others =>
               Put_Line ("Ayacc: Unexpected Error in Traverse");
               raise;
         end Traverse;

      begin -- digraph
         Make_Stack (Trans_Stack);
         N.Make_Array (First_Parse_State, Last_Parse_State);

         -- Call traverse(X) for all unexamined nonterminal transitions X

         for State in First_Parse_State .. Last_Parse_State loop
            Get_Transition_Symbols (State, Nonterminals, Gotos);
            Initialize (Goto_Index, Gotos);

            while More (Goto_Index) loop
               Next (Goto_Index, Symbol);
               if N.Lval (State, Symbol).Value = 0 then
                  Trans.State_Id := State;
                  Trans.Symbol   := Symbol;
                  Traverse (Trans);
               end if;
            end loop;
         end loop;

         Free_Stack (Trans_Stack);
         N.Free_Array;
         -- Free
         Make_Null (Gotos);

      exception
         when Value_Range_Error =>
            Put_Line ("Ayacc: Value Range Error in Digraph");
            raise;
         when Stack_Underflow =>
            Put_Line ("Ayacc: Stack Underflow in Digraph");
            raise;
         when others =>
            Put_Line ("Ayacc: Unexpected Error in Digraph");
            raise;
      end Digraph;

      procedure Make_Read_Sets is
      begin
         Digraph (Use_Reads);
      end Make_Read_Sets;

      procedure Make_Follow_Sets is
      begin
         Digraph (Use_Includes);
         Free_Includes;
      end Make_Follow_Sets;

      --  procedure Follow(
      --      Trans      : Transition;
      --      Follow_Set : in out Grammar_Symbol_Set)  is
      --  begin
      --      Make_Null(Follow_Set);
      --      Assign(Follow_Set,
      --             LALR_Sets.Lval(Trans.State_ID,Trans.Symbol).Value);
      --      -- used to rval
      --  end Follow;

      procedure Union_Follow_Sets
        (Trans : Transition; Follow_Set : in out Grammar_Symbol_Set)
      is
      begin
         Insert
           (Lalr_Sets.Rval (Trans.State_Id, Trans.Symbol).Value,
            Into => Follow_Set);
      end Union_Follow_Sets;

   end Lalr_Sets_Pack;
--------------------------------------------------------------------------

   use Lalr_Sets_Pack;
   procedure Make_Lalr_Sets is
   begin
      Make_Dr_Sets;
      Make_Reads_Relation;
      Make_Read_Sets;
      Make_Includes_Relation;
      Make_Follow_Sets;
   end Make_Lalr_Sets;

--------------------------------------------------------------------------
   use Grammar_Symbol_Set_Pack, Parse_State_Set_Pack;

   procedure Get_La
     (State_Id    :        Parse_State; Item_Id : Item;
      Look_Aheads : in out Grammar_Symbol_Set)
   is

      Predecessors : Parse_State_Set;
      Pred_Loop    : Parse_State_Iterator;
      Temp         : Transition;
   begin
      Make_Null (Look_Aheads);
      Temp.Symbol := Get_Lhs (Item_Id.Rule_Id);

      Make_Null (Predecessors);
      Get_Pred_Set (State_Id, Item_Id, Predecessors);
      Initialize (Pred_Loop, Predecessors);

      while More (Pred_Loop) loop
         Next (Pred_Loop, Temp.State_Id);
         Union_Follow_Sets (Temp, Look_Aheads);
      end loop;

      -- Free
      Make_Null (Predecessors);
   end Get_La;

end Lalr_Symbol_Info;
