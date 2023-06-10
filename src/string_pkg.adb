-- Module       : string_pkg.ada
-- Component of : common_library
-- Version      : 1.2
-- Date         : 11/21/86  16:35:20
-- SCCS File    : disk21~/rschm/hasee/sccs/common_library/sccs/sxstring_pkg.ada

-- $Source: /nosc/work/abstractions/string/RCS/string.bdy,v $
-- $Revision: 1.3 $ -- $Date: 85/02/01 10:58:51 $ -- $Author: ron $

-- $Source: /nosc/work/abstractions/string/RCS/string.bdy,v $
-- $Revision: 1.3 $ -- $Date: 85/02/01 10:58:51 $ -- $Author: ron $

with Unchecked_Deallocation;
with Lists, Stack_Pkg;
pragma Elaborate_All (Lists);
pragma Elaborate_All (Stack_Pkg);

package body String_Pkg is

   -- SCCS_ID : constant String := "@(#) string_pkg.ada, Version 1.2";

--| Overview:
--| The implementation for most operations is fairly straightforward.
--| The interesting aspects involve the allocation and deallocation of
--| heap space.  This is done as follows:
--|
--|     1. A stack of accesses to lists of string_type values is set up
--|        so that the top of the stack always refers to a list of values
--|        that were allocated since the last invocation of mark.
--|        The stack is called scopes, referring to the dynamic scopes
--|        defined by the invocations of mark and release.
--|        There is an implicit invocation of mark when the
--|        package body is elaborated; this is implemented with an explicit
--|        invocation in the package initialization code.
--|
--|     2. At each invocation of mark, a pointer to an empty list
--|        is pushed onto the stack.
--|
--|     3. At each invocation of release, all of the values in the
--|        list referred to by the pointer at the top of the stack are
--|        returned to the heap.  Then the list, and the pointer to it,
--|        are returned to the heap.  Finally, the stack is popped.

   package String_List_Pkg is new Lists (String_Type);
   subtype String_List is String_List_Pkg.List;

   type String_List_Ptr is access String_List;

   package Scope_Stack_Pkg is new Stack_Pkg (String_List_Ptr);
   subtype Scope_Stack is Scope_Stack_Pkg.Stack;

   use String_List_Pkg;
   use Scope_Stack_Pkg;

   Scopes : Scope_Stack;     -- See package body overview.

   -- Utility functions/procedures:

   function Enter (S : String_Type) return String_Type;

   --| Raises: illegal_alloc
   --| Effects:
   --| Stores s, the address of s.all, in current scope list (top(scopes)),
   --| and returns s.  Useful for functions that create and return new
   --| string_type values.
   --| Raises illegal_alloc if the scopes stack is empty.

   function Match_String
     (S1, S2 : String; Start : Positive := 1) return Natural;

   --| Raises: no_match
   --| Effects:
   --| Returns the minimum index, i, in s1'range such that
   --| s1(i..i + s2'length - 1) = s2.  Returns 0 if no such index.
   --| Requires:
   --| s1'first = 1.

-- Constructors:

   function Empty_String return String_Type is
   begin
      return Create ("");
   end Empty_String;

   function Create (S : String) return String_Type is
      subtype Constr_Str is String (1 .. S'Length);
      Dec_S : constant Constr_Str := S;
   begin
      return Enter (new Constr_Str'(Dec_S));
-- DECada bug; above code (and decl of dec_s) replaces the following:
--        return enter(new constr_str'(s));
   end Create;

   function "&" (S1, S2 : String_Type) return String_Type is
   begin
      if Is_Empty (S1) then
         return Enter (Make_Persistent (S2));
      end if;
      if Is_Empty (S2) then
         return Enter (Make_Persistent (S1));
      end if;
      return Create (S1.all & S2.all);
   end "&";

   function "&" (S1 : String_Type; S2 : String) return String_Type is
   begin
      if S1 = null then
         return Create (S2);
      end if;
      return Create (S1.all & S2);
   end "&";

   function "&" (S1 : String; S2 : String_Type) return String_Type is
   begin
      if S2 = null then
         return Create (S1);
      end if;
      return Create (S1 & S2.all);
   end "&";

   function Substr
     (S : String_Type; I : Positive; Len : Natural) return String_Type
   is
   begin
      if Len = 0 then
         return null;
      end if;
      return Create (S (I .. (I + Len - 1)));
   exception
      when Constraint_Error =>      -- on array fetch or null deref
         raise Bounds;
   end Substr;

   function Splice
     (S : String_Type; I : Positive; Len : Natural) return String_Type
   is
   begin
      if Len = 0 then
         return Enter (Make_Persistent (S));
      end if;
      if I + Len - 1 > Length (S) then
         raise Bounds;
      end if;

      return Create (S (1 .. (I - 1)) & S ((I + Len) .. Length (S)));
   end Splice;

   function Insert (S1, S2 : String_Type; I : Positive) return String_Type is
   begin
      if I > Length (S1) then
         raise Bounds;
      end if;
      if Is_Empty (S2) then
         return Create (S1.all);
      end if;

      return Create (S1 (1 .. (I - 1)) & S2.all & S1 (I .. S1'Last));
   end Insert;

   function Insert
     (S1 : String_Type; S2 : String; I : Positive) return String_Type
   is
   begin
      if I > Length (S1) then
         raise Bounds;
      end if;

      return Create (S1 (1 .. (I - 1)) & S2 & S1 (I .. S1'Last));
   end Insert;

   function Insert
     (S1 : String; S2 : String_Type; I : Positive) return String_Type
   is
   begin
      if not (I in S1'Range) then
         raise Bounds;
      end if;
      if S2 = null then
         return Create (S1);
      end if;

      return Create (S1 (S1'First .. (I - 1)) & S2.all & S1 (I .. S1'Last));
   end Insert;

   procedure Lc (C : in out Character) is
   begin
      if ('A' <= C) and then (C <= 'Z') then
         C :=
           Character'Val
             (Character'Pos (C) - Character'Pos ('A') + Character'Pos ('a'));
      end if;
   end Lc;

   procedure Uc (C : in out Character) is
   begin
      if ('a' <= C) and then (C <= 'z') then
         C :=
           Character'Val
             (Character'Pos (C) - Character'Pos ('a') + Character'Pos ('A'));
      end if;
   end Uc;

   function Lower (S : String) return String_Type is
      S2 : constant String_Type := Create (S);

   begin
      for I in S2'Range loop
         Lc (S2 (I));
      end loop;
      return S2;
   end Lower;

   function Lower (S : String_Type) return String_Type is
   begin
      if S = null then
         return null;
      end if;
      return Lower (S.all);
   end Lower;

   function To_Package_Name (S : String) return String_Type is
      Mixed_String : constant String_Type := Create (S);
   begin
      if Mixed_String'Length /= 0 then
         Uc (Mixed_String (Mixed_String'First));
         for I in Mixed_String'First + 1 .. Mixed_String'Last loop
            if Mixed_String (I - 1) = '_' or Mixed_String (I - 1) = '.' then
               Uc (Mixed_String (I));
            elsif Mixed_String (I) = '-' then
               Mixed_String (I) := '.';
            else
               Lc (Mixed_String (I));
            end if;
         end loop;
         return Mixed_String;
      else
         return Empty_String;
      end if;
   end To_Package_Name;

   function Mixed (S : String) return String_Type is
      Mixed_String : constant String_Type := Create (S);
   begin
      if Mixed_String'Length /= 0 then
         Uc (Mixed_String (Mixed_String'First));
         for I in Mixed_String'First + 1 .. Mixed_String'Last loop
            if Mixed_String (I - 1) = '_' then
               Uc (Mixed_String (I));
            else
               Lc (Mixed_String (I));
            end if;
         end loop;
         return Mixed_String;
      else
         return Empty_String;
      end if;
   end Mixed;

   function Mixed (S : String_Type) return String_Type is
   begin
      if S = null then
         return Empty_String;
      else
         return Mixed (S.all);
      end if;
   end Mixed;

   function Upper (S : String) return String_Type is
      S2 : constant String_Type := Create (S);

   begin
      for I in S2'Range loop
         Uc (S2 (I));
      end loop;
      return S2;
   end Upper;

   function Upper (S : String_Type) return String_Type is
   begin
      if S = null then
         return null;
      end if;
      return Upper (S.all);
   end Upper;

-- Heap Management:

   function Make_Persistent (S : String_Type) return String_Type is
      subtype Constr_Str is String (1 .. Length (S));
   begin
      if S = null or else S.all = "" then
         return null;
      else
         return new Constr_Str'(S.all);
      end if;
   end Make_Persistent;

   function Make_Persistent (S : String) return String_Type is
      subtype Constr_Str is String (1 .. S'Length);
   begin
      if S = "" then
         return null;
      else
         return new Constr_Str'(S);
      end if;
   end Make_Persistent;

   procedure Real_Flush is new Unchecked_Deallocation (String, String_Type);
   --| Effect:
   --| Return space used by argument to heap.  Does nothing if null.
   --| Notes:
   --| This procedure is actually the body for the flush procedure,
   --| but a generic instantiation cannot be used as a body for another
   --| procedure.  You tell me why.

   procedure Flush (S : in out String_Type) is
   begin
      if S /= null then
         Real_Flush (S);
      end if;
      -- Actually, the if isn't needed; however, DECada compiler chokes
      -- on deallocation of null.
   end Flush;

   procedure Mark is
   begin
      Push (Scopes, new String_List'(Create));
   end Mark;

   procedure Release is
      procedure Flush_List_Ptr is new Unchecked_Deallocation
        (String_List, String_List_Ptr);
      Iter     : String_List_Pkg.Listiter;
      Top_List : String_List_Ptr;
      S        : String_Type;
   begin
      Pop (Scopes, Top_List);
      Iter := Makelistiter (Top_List.all);
      while More (Iter) loop
         Next (Iter, S);
         Flush (S);             -- real_flush is bad, DECada bug
--          real_flush(s);
      end loop;
      Destroy (Top_List.all);
      Flush_List_Ptr (Top_List);
   exception
      when Empty_Stack =>
         raise Illegal_Dealloc;
   end Release;

-- Queries:

   function Is_Empty (S : String_Type) return Boolean is
   begin
      return (S = null) or else (S.all = "");
   end Is_Empty;

   function Length (S : String_Type) return Natural is
   begin
      if S = null then
         return 0;
      end if;
      return (S.all'Length);
   end Length;

   function Value (S : String_Type) return String is
   begin
      if S = null then
         return "";
      end if;
      return S.all;
   end Value;

   function Fetch (S : String_Type; I : Positive) return Character is
   begin
      if Is_Empty (S) or else (not (I in S'Range)) then
         raise Bounds;
      end if;
      return S (I);
   end Fetch;

   function Equal (S1, S2 : String_Type) return Boolean is
   begin
      if Is_Empty (S1) then
         return Is_Empty (S2);
      end if;
      return (S2 /= null) and then (S1.all = S2.all);
-- The above code replaces the following.  (DECada buggy)
--        return s1.all = s2.all;
--    exception
--  when constraint_error =>     -- s is null
--      return is_empty(s1) and is_empty(s2);
   end Equal;

   function Equal (S1 : String_Type; S2 : String) return Boolean is
   begin
      if S1 = null then
         return S2 = "";
      end if;
      return S1.all = S2;
   end Equal;

   function Equal (S1 : String; S2 : String_Type) return Boolean is
   begin
      if S2 = null then
         return S1 = "";
      end if;
      return S1 = S2.all;
   end Equal;

--|========================================================================

   function Equivalent (Left, Right : in String_Type) return Boolean is
   begin
      return Equal (Upper (Left), Upper (Right));
   end Equivalent;

   function Equivalent
     (Left : in String; Right : in String_Type) return Boolean
   is
   begin
      return Equivalent (Create (Left), Right);
   end Equivalent;

   function Equivalent
     (Left : in String_Type; Right : in String) return Boolean
   is
   begin
      return Equivalent (Left, Create (Right));
   end Equivalent;

--|========================================================================

   function "<" (S1 : String_Type; S2 : String_Type) return Boolean is
   begin
      if Is_Empty (S1) then
         return (not Is_Empty (S2));
      else
         return (S1.all < S2);
      end if;
-- Got rid of the following code:  (Think that DECada is buggy)
      --return s1.all < s2.all;
      --exception
      --when constraint_error =>   -- on null deref
      --return (not is_empty(s2));
      -- one of them must be empty
   end "<";

   function "<" (S1 : String_Type; S2 : String) return Boolean is
   begin
      if S1 = null then
         return S2 /= "";
      end if;
      return S1.all < S2;
   end "<";

   function "<" (S1 : String; S2 : String_Type) return Boolean is
   begin
      if S2 = null then
         return False;
      end if;
      return S1 < S2.all;
   end "<";

   function "<=" (S1 : String_Type; S2 : String_Type) return Boolean is
   begin
      if Is_Empty (S1) then
         return True;
      end if;
      return (S1.all <= S2);

      -- Replaces the following:  (I think DECada is buggy)
      --return s1.all <= s2.all;
      --exception
      --when constraint_error =>   -- on null deref
      --return is_empty(s1);   -- one must be empty, so s1<=s2 iff s1 = ""
   end "<=";

   function "<=" (S1 : String_Type; S2 : String) return Boolean is
   begin
      if S1 = null then
         return True;
      end if;
      return S1.all <= S2;
   end "<=";

   function "<=" (S1 : String; S2 : String_Type) return Boolean is
   begin
      if S2 = null then
         return S1 = "";
      end if;
      return S1 <= S2.all;
   end "<=";

   function Match_C
     (S : String_Type; C : Character; Start : Positive := 1) return Natural
   is
   begin
      if S = null then
         return 0;
      end if;
      for I in Start .. S.all'Last loop
         if S (I) = C then
            return I;
         end if;
      end loop;
      return 0;
   end Match_C;

   function Match_Not_C
     (S : String_Type; C : Character; Start : Positive := 1) return Natural
   is
   begin
      if S = null then
         return 0;
      end if;
      for I in Start .. S.all'Last loop
         if S (I) /= C then
            return I;
         end if;
      end loop;
      return 0;
   end Match_Not_C;

   function Match_S
     (S1, S2 : String_Type; Start : Positive := 1) return Natural
   is
   begin
      if (S1 = null) or else (S2 = null) then
         return 0;
      end if;
      return Match_String (S1.all, S2.all, Start);
   end Match_S;

   function Match_S
     (S1 : String_Type; S2 : String; Start : Positive := 1) return Natural
   is
   begin
      if S1 = null then
         return 0;
      end if;
      return Match_String (S1.all, S2, Start);
   end Match_S;

   function Match_Any
     (S, Any : String_Type; Start : Positive := 1) return Natural
   is
   begin
      if Any = null then
         raise Any_Empty;
      end if;
      return Match_Any (S, Any.all, Start);
   end Match_Any;

   function Match_Any
     (S : String_Type; Any : String; Start : Positive := 1) return Natural
   is
   begin
      if Any = "" then
         raise Any_Empty;
      end if;
      if S = null then
         return 0;
      end if;

      for I in Start .. S.all'Last loop
         for J in Any'Range loop
            if S (I) = Any (J) then
               return I;
            end if;
         end loop;
      end loop;
      return 0;
   end Match_Any;

   function Match_None
     (S, None : String_Type; Start : Positive := 1) return Natural
   is
   begin
      if Is_Empty (S) then
         return 0;
      end if;
      if Is_Empty (None) then
         return 1;
      end if;

      return Match_None (S, None.all, Start);
   end Match_None;

   function Match_None
     (S : String_Type; None : String; Start : Positive := 1) return Natural
   is
      Found : Boolean;
   begin
      if Is_Empty (S) then
         return 0;
      end if;

      for I in Start .. S.all'Last loop
         Found := True;
         for J in None'Range loop
            if S (I) = None (J) then
               Found := False;
               exit;
            end if;
         end loop;
         if Found then
            return I;
         end if;
      end loop;
      return 0;
   end Match_None;

   -- Utilities:

   function Enter (S : String_Type) return String_Type is
   begin
-- ATTACHING TO THE END OF THE LIST IS ENTIRELY TOO SLOW AND UNNECESSARY
--        top(scopes).all := attach(top(scopes).all, s);
      Top (Scopes).all := Attach (S, Top (Scopes).all);
      return S;
   exception
      when Empty_Stack =>
         raise Illegal_Alloc;
   end Enter;

   function Match_String
     (S1, S2 : String; Start : Positive := 1) return Natural
   is
      Offset : Natural;
   begin
      Offset := S2'Length - 1;
      for I in Start .. (S1'Last - Offset) loop
         if S1 (I .. (I + Offset)) = S2 then
            return I;
         end if;
      end loop;
      return 0;
   exception
      when Constraint_Error =>    -- on offset := s2'length (= 0)
         return 0;
   end Match_String;

begin    -- Initialize the scopes stack with an implicit mark.
   Scopes := Create;
   Mark;
end String_Pkg;
