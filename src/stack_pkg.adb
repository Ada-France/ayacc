-- Module       : stack_pkg.ada
-- Component of : common_library
-- Version      : 1.2
-- Date         : 11/21/86  16:32:31
-- SCCS File    : disk21~/rschm/hasee/sccs/common_library/sccs/sxstack_pkg.ada

-- $Source: /nosc/work/abstractions/stack/RCS/stack.bdy,v $
-- $Revision: 1.3 $ -- $Date: 85/02/01 10:19:36 $ -- $Author: ron $

-- $Source: /nosc/work/abstractions/stack/RCS/stack.bdy,v $
-- $Revision: 1.3 $ -- $Date: 85/02/01 10:19:36 $ -- $Author: ron $

with Unchecked_Deallocation;

package body Stack_Pkg is

   -- SCCS_ID : constant String := "@(#) stack_pkg.ada, Version 1.2";

--| Overview:
--| Implementation scheme is totally described by the statements of the
--| representation invariants and abstraction function that appears in
--| the package specification.  The implementation is so trivial that
--| further documentation is unnecessary.

   use Elem_List_Pkg;

   -- Constructors:

   function Create return Stack is
   begin
      return new Stack_Rec'(Size => 0, Elts => Create);
   end Create;

   procedure Push (S : in out Stack; E : Elem_Type) is
   begin
      S.Size := S.Size + 1;
      S.Elts := Attach (E, S.Elts);
   exception
      when Constraint_Error =>
         raise Uninitialized_Stack;
   end Push;

   procedure Pop (S : in out Stack) is
   begin
      Deletehead (S.Elts);
      S.Size := S.Size - 1;
   exception
      when Emptylist =>
         raise Empty_Stack;
      when Constraint_Error =>
         raise Uninitialized_Stack;
   end Pop;

   procedure Pop (S : in out Stack; E : out Elem_Type) is
   begin
      E := Firstvalue (S.Elts);
      Deletehead (S.Elts);
      S.Size := S.Size - 1;
   exception
      when Emptylist =>
         raise Empty_Stack;
      when Constraint_Error =>
         raise Uninitialized_Stack;
   end Pop;

   function Copy (S : Stack) return Stack is
   begin
      if S = null then
         raise Uninitialized_Stack;
      end if;

      return new Stack_Rec'(Size => S.Size, Elts => Copy (S.Elts));
   end Copy;

   -- Queries:

   function Top (S : Stack) return Elem_Type is
   begin
      return Firstvalue (S.Elts);
   exception
      when Emptylist =>
         raise Empty_Stack;
      when Constraint_Error =>
         raise Uninitialized_Stack;
   end Top;

   function Size (S : Stack) return Natural is
   begin
      return S.Size;
   exception
      when Constraint_Error =>
         raise Uninitialized_Stack;
   end Size;

   function Is_Empty (S : Stack) return Boolean is
   begin
      return S.Size = 0;
   exception
      when Constraint_Error =>
         raise Uninitialized_Stack;
   end Is_Empty;

   -- Heap Management:

   procedure Destroy (S : in out Stack) is
      procedure Free_Stack is new Unchecked_Deallocation (Stack_Rec, Stack);
   begin
      Destroy (S.Elts);
      Free_Stack (S);
   exception
      when Constraint_Error =>    -- stack is null
         return;
   end Destroy;

end Stack_Pkg;
