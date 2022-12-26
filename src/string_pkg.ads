-- Module       : string_pkg_.ada
-- Component of : common_library
-- Version      : 1.2
-- Date         : 11/21/86  16:35:52
-- SCCS File    : disk21~/rschm/hasee/sccs/common_library/sccs/sxstring_pkg_.ada

-- $Source: /nosc/work/abstractions/string/RCS/string.spc,v $
-- $Revision: 1.1 $ -- $Date: 85/01/10 17:51:46 $ -- $Author: ron $

-- $Source: /nosc/work/abstractions/string/RCS/string.spc,v $
-- $Revision: 1.1 $ -- $Date: 85/01/10 17:51:46 $ -- $Author: ron $

package String_Pkg is

--| Overview:
--| Package string_pkg exports an abstract data type, string_type.  A
--| string_type value is a sequence of characters.  The values have arbitrary
--| length.  For a value, s, with length, l, the individual characters are
--| numbered from 1 to l.  These values are immutable; characters cannot be
--| replaced or appended in a destructive fashion.
--|
--| In the documentation for this package, we are careful to distinguish
--| between string_type objects, which are Ada objects in the usual sense,
--| and string_type values, the members of this data abstraction as described
--| above.  A string_type value is said to be associated with, or bound to,
--| a string_type object after an assignment (:=) operation.
--|
--| The operations provided in this package fall into three categories:
--|
--| 1. Constructors:  These functions typically take one or more string_type
--|      objects as arguments.  They work with the values associated with
--|      these objects, and return new string_type values according to
--|      specification.  By a slight abuse of language, we will sometimes
--|      coerce from string_type objects to values for ease in description.
--|
--| 2. Heap Management:
--|      These operations (make_persistent, flush, mark, release) control the
--|      management of heap space.  Because string_type values are
--|      allocated on the heap, and the type is not limited, it is necessary
--|      for a user to assume some responsibility for garbage collection.
--|      String_type is not limited because of the convenience of
--|      the assignment operation, and the usefulness of being able to
--|      instantiate generic units that contain private type formals.
--|      ** Important: To use this package properly, it is necessary to read
--|      the descriptions of the operations in this section.
--|
--| 3. Queries:  These functions return information about the values
--|      that are associated with the argument objects.  The same conventions
--|      for description of operations used in (1) is adopted.
--|
--| A note about design decisions...  The decision to not make the type
--| limited causes two operations to be carried over from the representation.
--| These are the assignment operation, :=, and the "equality" operator, "=".
--| See the discussion at the beginning of the Heap Management section for a
--| discussion of :=.
--| See the spec for the first of the equal functions for a discussion of "=".
--|
--| The following is a complete list of operations, written in the order
--| in which they appear in the spec.  Overloaded subprograms are followed
--| by (n), where n is the number of subprograms of that name.
--|
--| 1. Constructors:
--|        Empty_String
--|        create
--|        "&" (3)
--|        substr
--|        splice
--|        insert (3)
--|        lower (2)
--|        upper (2)
--|        mixed (2)
--| 2. Heap Management:
--|        make_persistent (2)
--|        flush
--|        mark, release
--| 3. Queries:
--|        is_empty
--|        length
--|        value
--|        fetch
--|        equal (3)
--|        equivalent (3)
--|        "<" (3),
--|    "<=" (3)
--|        match_c
--|        match_not_c
--|        match_s (2)
--|        match_any (2)
--|        match_none (2)

--| Notes:
--| Programmer: Ron Kownacki

   type String_Type is private;

   Bounds          : exception;  --| Raised on index out of bounds.
   Any_Empty       : exception;  --| Raised on incorrect use of match_any.
   Illegal_Alloc   : exception;  --| Raised by value creating operations.
   Illegal_Dealloc : exception;  --| Raised by release.

-- Constructors:

   function Empty_String return String_Type;
   --| Raises: Illegal_Alloc
   --| Effects:    returns  String_Pkg.Create ("");
   pragma Inline (Empty_String);

   function Create (S : String) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return a value consisting of the sequence of characters in s.
   --| Sometimes useful for array or record aggregates.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function "&" (S1, S2 : String_Type) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return the concatenation of s1 and s2.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function "&" (S1 : String_Type; S2 : String) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return the concatenation of s1 and create(s2).
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function "&" (S1 : String; S2 : String_Type) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return the concatenation of create(s1) and s2.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Substr
     (S : String_Type; I : Positive; Len : Natural) return String_Type;

   --| Raises: bounds, illegal_alloc
   --| Effects:
   --| Return the substring, of specified length, that occurs in s at
   --| position i.  If len = 0, then returns the empty value.
   --| Otherwise, raises bounds if either i or (i + len - 1)
   --| is not in 1..length(s).
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Splice
     (S : String_Type; I : Positive; Len : Natural) return String_Type;

   --| Raises: bounds, illegal_alloc
   --| Effects:
   --| Let s be the string, abc, where a, b and c are substrings.  If
   --| substr(s, i, length(b)) = b, for some i in 1..length(s), then
   --| splice(s, i, length(b)) = ac.
   --| Returns a value equal to s if len = 0.  Otherwise, raises bounds if
   --| either i or (i + len - 1) is not in 1..length(s).
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Insert (S1, S2 : String_Type; I : Positive) return String_Type;

   --| Raises: bounds, illegal_alloc
   --| Effects:
   --| Return substr(s1, 1, i - 1) & s2 &
   --|        substr(s1, i, length(s1) - i + 1).
   --| equal(splice(insert(s1, s2, i), i, length(s2)), s1) holds if no
   --| exception is raised by insert.
   --| Raises bounds if is_empty(s1) or else i is not in 1..length(s1).
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Insert
     (S1 : String_Type; S2 : String; I : Positive) return String_Type;

   --| Raises: bounds, illegal_alloc
   --| Effects:
   --| Return substr(s1, 1, i - 1) & s2 &
   --|        substr(s1, i, length(s1) - i + 1).
   --| equal(splice(insert(s1, s2, i), i, length(s2)), s1) holds if no
   --| exception is raised by insert.
   --| Raises bounds if is_empty(s1) or else i is not in 1..length(s1).
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Insert
     (S1 : String; S2 : String_Type; I : Positive) return String_Type;

   --| Raises: bounds, illegal_alloc
   --| Effects:
   --| Return s1(s1'first..i - 1) & s2 &
   --|        s1(i..length(s1) - i + 1).
   --| equal(splice(insert(s1, s2, i), i, length(s2)), s1) holds if no
   --| exception is raised by insert.
   --| Raises bounds if i is not in s'range.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Lower (S : String) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return a value that contains exactly those characters in s with
   --| the exception that all upper case characters are replaced by their
   --| lower case counterparts.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Lower (S : String_Type) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return a value that is a copy of s with the exception that all
   --| upper case characters are replaced by their lower case counterparts.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Upper (S : String) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return a value that contains exactly those characters in s with
   --| the exception that all lower case characters are replaced by their
   --| upper case counterparts.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Upper (S : String_Type) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Return a value that is a copy of s with the exception that all
   --| lower case characters are replaced by their upper case counterparts.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function Mixed (S : String) return String_Type;

   --| Raises: Illegal_Alloc
   --| Effects:
   --| Return a value that contains exactly those characters in s with
   --| the exception that all upper case characters are replaced by their
   --| lower case counterparts with the exception of the first character and
   --| each character following an underscore which are forced to upper case.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

   function To_Package_Name (S : String) return String_Type;

   function Mixed (S : String_Type) return String_Type;

   --| Raises: Illegal_Alloc
   --| Effects:
   --| Return a value that contains exactly those characters in s with
   --| the exception that all upper case characters are replaced by their
   --| lower case counterparts with the exception of the first character and
   --| each character following an underscore which are forced to upper case.
   --| Raises illegal_alloc if string space has been improperly
   --| released.  (See procedures mark/release.)

-- Heap Management (including object/value binding):
--
-- Two forms of heap management are provided.  The general scheme is to "mark"
-- the current state of heap usage, and to "release" in order to reclaim all
-- space that has been used since the last mark.  However, this alone is
-- insufficient because it is frequently desirable for objects to remain
-- associated with values for longer periods of time, and this may come into
-- conflict with the need to clean up after a period of "string hacking."
-- To deal with this problem, we introduce the notions of "persistent" and
-- "nonpersistent" values.
--
-- The nonpersistent values are those that are generated by the constructors
-- in the previous section.  These are claimed by the release procedure.
-- Persistent values are generated by the two make_persistent functions
-- described below.  These values must be disposed of individually by means of
-- the flush procedure.
--
-- This allows a description of the meaning of the ":=" operation.  For a
-- statement of the form, s := expr, where expr is a string_type expression,
-- the result is that the value denoted/created by expr becomes bound to the
-- the object, s.  Assignment in no way affects the persistence of the value.
-- If expr happens to be an object, then the value associated  with it will be
-- shared.  Ideally, this sharing would not be visible, since values are
-- immutable.  However, the sharing may be visible because of the memory
-- management, as described below.  Programs which depend on such sharing are
-- erroneous.

   function Make_Persistent (S : String_Type) return String_Type;

   --| Effects:
   --| Returns a persistent value, v, containing exactly those characters in
   --| value(s).  The value v will not be claimed by any subsequent release.
   --| Only an invocation of flush will claim v.  After such a claiming
   --| invocation of flush, the use (other than :=) of any other object to
   --| which v was bound is erroneous, and program_error may be raised for
   --| such a use.

   function Make_Persistent (S : String) return String_Type;

   --| Effects:
   --| Returns a persistent value, v, containing exactly those chars in s.
   --| The value v will not be claimed by any subsequent release.
   --| Only an invocation of flush will reclaim v.  After such a claiming
   --| invocation of flush, the use (other than :=) of any other object to
   --| which v was bound is erroneous, and program_error may be raised for
   --| such a use.

   procedure Flush (S : in out String_Type);

   --| Effects:
   --| Return heap space used by the value associated with s, if any, to
   --| the heap.  s becomes associated with the empty value.  After an
   --| invocation of flush claims the value, v, then any use (other than :=)
   --| of an object to which v was bound is erroneous, and program_error
   --| may be raised for such a use.
   --|
   --| This operation should be used only for persistent values.  The mark
   --| and release operations are used to deallocate space consumed by other
   --| values.  For example, flushing a nonpersistent value implies that a
   --| release that tries to claim this value will be erroneous, and
   --| program_error may be raised for such a use.

   procedure Mark;

   --| Effects:
   --| Marks the current state of heap usage for use by release.
   --| An implicit mark is performed at the beginning of program execution.

   procedure Release;

   --| Raises: illegal_dealloc
   --| Effects:
   --| Releases all heap space used by nonpersistent values that have been
   --| allocated since the last mark.  The values that are claimed include
   --| those bound to objects as well as those produced and discarded during
   --| the course of general "string hacking."  If an invocation of release
   --| claims a value, v, then any subsequent use (other than :=) of any
   --| other object to which v is bound is erroneous, and program_error may
   --| be raised for such a use.
   --|
   --| Raises illegal_dealloc if the invocation of release does not balance
   --| an invocation of mark.  It is permissible to match the implicit
   --| initial invocation of mark.  However, subsequent invocations of
   --| constructors will raise the illegal_alloc exception until an
   --| additional mark is performed.  (Anyway, there is no good reason to
   --| do this.)  In any case, a number of releases matching the number of
   --| currently active marks is implicitly performed at the end of program
   --| execution.
   --|
   --| Good citizens generally perform their own marks and releases
   --| explicitly.  Extensive string hacking without cleaning up will
   --| cause your program to run very slowly, since the heap manager will
   --| be forced to look hard for chunks of space to allocate.

-- Queries:

   function Is_Empty (S : String_Type) return Boolean;

   --| Effects:
   --| Return true iff s is the empty sequence of characters.

   function Length (S : String_Type) return Natural;

   --| Effects:
   --| Return number of characters in s.

   function Value (S : String_Type) return String;

   --| Effects:
   --| Return a string, s2, that contains the same characters that s
   --| contains.  The properties, s2'first = 1 and s2'last = length(s),
   --| are satisfied.  This implies that, for a given string, s3,
   --| value(create(s3))'first may not equal s3'first, even though
   --| value(create(s3)) = s3 holds.  Thus, "content equality" applies
   --| although the string objects may be distinguished by the use of
   --| the array attributes.

   function Fetch (S : String_Type; I : Positive) return Character;

   --| Raises: bounds
   --| Effects:
   --| Return the ith character in s.  Characters are numbered from
   --| 1 to length(s).  Raises bounds if i not in 1..length(s).

   function Equal (S1, S2 : String_Type) return Boolean;

   --| Effects:
   --| Value equality relation; return true iff length(s1) = length(s2)
   --| and, for all i in 1..length(s1), fetch(s1, i) = fetch(s2, i).
   --| The "=" operation is carried over from the representation.
   --| It allows one to distinguish among the heap addresses of
   --| string_type values.  Even "equal" values may not be "=", although
   --| s1 = s2 implies equal(s1, s2).
   --| There is no reason to use "=".

   function Equal (S1 : String_Type; S2 : String) return Boolean;

   --| Effects:
   --| Return equal(s1, create(s2)).

   function Equal (S1 : String; S2 : String_Type) return Boolean;

   --| Effects:
   --| Return equal(create(s1), s2).

--|===========================================================================

   --| Overview: Equivalent is the Case Insensitive version of Equal

   function Equivalent (Left, Right : in String_Type) return Boolean;

   function Equivalent
     (Left : in String; Right : in String_Type) return Boolean;

   function Equivalent
     (Left : in String_Type; Right : in String) return Boolean;

--|===========================================================================

   function "<" (S1 : String_Type; S2 : String_Type) return Boolean;

   --| Effects:
   --| Lexicographic comparison; return value(s1) < value(s2).

   function "<" (S1 : String_Type; S2 : String) return Boolean;

   --| Effects:
   --| Lexicographic comparison; return value(s1) < s2.

   function "<" (S1 : String; S2 : String_Type) return Boolean;

   --| Effects:
   --| Lexicographic comparison; return s1 < value(s2).

   function "<=" (S1 : String_Type; S2 : String_Type) return Boolean;

   --| Effects:
   --| Lexicographic comparison; return value(s1) <= value(s2).

   function "<=" (S1 : String_Type; S2 : String) return Boolean;

   --| Effects:
   --| Lexicographic comparison; return value(s1) <= s2.

   function "<=" (S1 : String; S2 : String_Type) return Boolean;

   --| Effects:
   --| Lexicographic comparison; return s1 <= value(s2).

   function Match_C
     (S : String_Type; C : Character; Start : Positive := 1) return Natural;

   --| Raises: no_match
   --| Effects:
   --| Return the minimum index, i in start..length(s), such that
   --| fetch(s, i) = c.  Returns 0 if no such i exists,
   --| including the case where is_empty(s).

   function Match_Not_C
     (S : String_Type; C : Character; Start : Positive := 1) return Natural;

   --| Raises: no_match
   --| Effects:
   --| Return the minimum index, i in start..length(s), such that
   --| fetch(s, i) /= c.  Returns 0 if no such i exists,
   --| including the case where is_empty(s).

   function Match_S
     (S1, S2 : String_Type; Start : Positive := 1) return Natural;

   --| Raises: no_match.
   --| Effects:
   --| Return the minimum index, i, in start..length(s1), such that,
   --| for all j in 1..length(s2), fetch(s2, j) = fetch(s1, i + j - 1).
   --| This is the position of the substring, s2, in s1.
   --| Returns 0 if no such i exists, including the cases
   --| where is_empty(s1) or is_empty(s2).
   --| Note that equal(substr(s1, match_s(s1, s2, i), length(s2)), s2)
   --| holds, providing that match_s does not raise an exception.

   function Match_S
     (S1 : String_Type; S2 : String; Start : Positive := 1) return Natural;

   --| Raises: no_match.
   --| Effects:
   --| Return the minimum index, i, in start..length(s1), such that,
   --| for all j in s2'range, s2(j) = fetch(s1, i + j - 1).
   --| This is the position of the substring, s2, in s1.
   --| Returns 0 if no such i exists, including the cases
   --| where is_empty(s1) or s2 = "".
   --| Note that equal(substr(s1, match_s(s1, s2, i), s2'length), s2)
   --| holds, providing that match_s does not raise an exception.

   function Match_Any
     (S, Any : String_Type; Start : Positive := 1) return Natural;

   --| Raises: no_match, any_empty
   --| Effects:
   --| Return the minimum index, i in start..length(s), such that
   --| fetch(s, i) = fetch(any, j), for some j in 1..length(any).
   --| Raises any_empty if is_empty(any).
   --| Otherwise, returns 0 if no such i exists, including the case
   --| where is_empty(s).

   function Match_Any
     (S : String_Type; Any : String; Start : Positive := 1) return Natural;

   --| Raises: no_match, any_empty
   --| Effects:
   --| Return the minimum index, i, in start..length(s), such that
   --| fetch(s, i) = any(j), for some j in any'range.
   --| Raises any_empty if any = "".
   --| Otherwise, returns 0 if no such i exists, including the case
   --| where is_empty(s).

   function Match_None
     (S, None : String_Type; Start : Positive := 1) return Natural;

   --| Raises: no_match
   --| Effects:
   --| Return the minimum index, i in start..length(s), such that
   --| fetch(s, i) /= fetch(none, j) for each j in 1..length(none).
   --| If (not is_empty(s)) and is_empty(none), then i is 1.
   --| Returns 0 if no such i exists, including the case
   --| where is_empty(s).

   function Match_None
     (S : String_Type; None : String; Start : Positive := 1) return Natural;

   --| Raises: no_match.
   --| Effects:
   --| Return the minimum index, i in start..length(s), such that
   --| fetch(s, i) /= none(j) for each j in none'range.
   --| If not is_empty(s) and none = "", then i is 1.
   --| Returns 0 if no such i exists, including the case
   --| where is_empty(s).

private

   type String_Type is access String;

   --| Abstract data type, string_type, is a constant sequence of chars
   --| of arbitrary length.  Representation type is access string.
   --| It is important to distinguish between an object of the rep type
   --| and its value; for an object, r, val(r) denotes the value.
   --|
   --| Representation Invariant:  I: rep --> boolean
   --| I(r: rep) = (val(r) = null) or else
   --|             (val(r).all'first = 1 &
   --|              val(r).all'last >= 0 &
   --|              (for all r2, val(r) = val(r2) /= null => r is r2))
   --|
   --| Abstraction Function:  A: rep --> string_type
   --| A(r: rep) = if r = null then
   --|                 the empty sequence
   --|             elsif r'last = 0 then
   --|                 the empty sequence
   --|             else
   --|                 the sequence consisting of r(1),...,r(r'last).

end String_Pkg;
