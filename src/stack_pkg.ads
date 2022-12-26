-- Module       : stack_pkg_.ada
-- Component of : common_library
-- Version      : 1.2
-- Date         : 11/21/86  16:33:02
-- SCCS File    : disk21~/rschm/hasee/sccs/common_library/sccs/sxstack_pkg_.ada

-- $Source: /nosc/work/abstractions/stack/RCS/stack.spc,v $
-- $Revision: 1.5 $ -- $Date: 85/02/01 09:57:17 $ -- $Author: ron $

-- $Source: /nosc/work/abstractions/stack/RCS/stack.spc,v $
-- $Revision: 1.5 $ -- $Date: 85/02/01 09:57:17 $ -- $Author: ron $

with Lists;     --| Implementation uses lists.  (private)

generic
   type Elem_Type is private;   --| Component element type.

package Stack_Pkg is

--| Overview:
--| This package provides the stack abstract data type.  Element type is
--| a generic formal parameter to the package.  There are no explicit
--| bounds on the number of objects that can be pushed onto a given stack.
--| All standard stack operations are provided.
--|
--| The following is a complete list of operations, written in the order
--| in which they appear in the spec.  Overloaded subprograms are followed
--| by (n), where n is the number of subprograms of that name.
--|
--| Constructors:
--|        create
--|        push
--|        pop (2)
--|        copy
--| Query Operations:
--|        top
--|        size
--|        is_empty
--| Heap Management:
--|        destroy

--| Notes:
--| Programmer: Ron Kownacki

   type Stack is private;       --| The stack abstract data type.

   -- Exceptions:

   Uninitialized_Stack : exception;
   --| Raised on attempt to manipulate an uninitialized stack object.
   --| The initialization operations are create and copy.

   Empty_Stack : exception;
   --| Raised by some operations when empty.

   -- Constructors:

   function Create return Stack;

   --| Effects:
   --| Return the empty stack.

   procedure Push (S : in out Stack; E : Elem_Type);

   --| Raises: uninitialized_stack
   --| Effects:
   --| Push e onto the top of s.
   --| Raises uninitialized_stack iff s has not been initialized.

   procedure Pop (S : in out Stack);

   --| Raises: empty_stack, uninitialized_stack
   --| Effects:
   --| Pops the top element from s, and throws it away.
   --| Raises empty_stack iff s is empty.
   --| Raises uninitialized_stack iff s has not been initialized.

   procedure Pop (S : in out Stack; E : out Elem_Type);

   --| Raises: empty_stack, uninitialized_stack
   --| Effects:
   --| Pops the top element from s, returns it as the e parameter.
   --| Raises empty_stack iff s is empty.
   --| Raises uninitialized_stack iff s has not been initialized.

   function Copy (S : Stack) return Stack;

   --| Raises: uninitialized_stack
   --| Return a copy of s.
   --| Stack assignment and passing stacks as subprogram parameters
   --| result in the sharing of a single stack value by two stack
   --| objects; changes to one will be visible through the others.
   --| copy can be used to prevent this sharing.
   --| Raises uninitialized_stack iff s has not been initialized.

   -- Queries:

   function Top (S : Stack) return Elem_Type;

   --| Raises: empty_stack, uninitialized_stack
   --| Effects:
   --| Return the element on the top of s.  Raises empty_stack iff s is
   --| empty.
   --| Raises uninitialized_stack iff s has not been initialized.

   function Size (S : Stack) return Natural;

   --| Raises: uninitialized_stack
   --| Effects:
   --| Return the current number of elements in s.
   --| Raises uninitialized_stack iff s has not been initialized.

   function Is_Empty (S : Stack) return Boolean;

   --| Raises: uninitialized_stack
   --| Effects:
   --| Return true iff s is empty.
   --| Raises uninitialized_stack iff s has not been initialized.

   -- Heap Management:

   procedure Destroy (S : in out Stack);

   --| Effects:
   --| Return the space consumed by s to the heap.  No effect if s is
   --| uninitialized.  In any case, leaves s in uninitialized state.

private

   package Elem_List_Pkg is new Lists (Elem_Type);
   subtype Elem_List is Elem_List_Pkg.List;

   type Stack_Rec is record
      Size : Natural   := 0;
      Elts : Elem_List := Elem_List_Pkg.Create;
   end record;

   type Stack is access Stack_Rec;

   --| Let an instance of the representation type, r, be denoted by the
   --| pair, <size, elts>.  Dot selection is used to refer to these
   --| components.
   --|
   --| Representation Invariants:
   --|     r /= null
   --|     elem_list_pkg.length(r.elts) = r.size.
   --|
   --| Abstraction Function:
   --|     A(<size, elem_list_pkg.create>) = stack_pkg.create.
   --|     A(<size, elem_list_pkg.attach(e, l)>) = push(A(<size, l>), e).

end Stack_Pkg;
