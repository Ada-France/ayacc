with Ayacc_File_Names, Text_Io, Source_File, Str_Pack;
use Ayacc_File_Names, Text_Io;

package body Error_Report_File is
--
-- TITLE:       package body Error_Report_File
--    Output the code which allows users to see what the error token was.
--    This is for non-correctable errors.
--    Also in this package: The declaration of user actions for correctable
--    (continuable) errors.
--
-- LANGUAGE:
--    Ada
--
-- PERSONNEL:
--    AUTHOR: Benjamin Hurwitz
--    DATE: Jul 27 1990
--
-- OVERVIEW:
--    Parse the last section of the .y file, looking for
--    %report_continuable_error and the related procedures.  From these,
--    generate procedure bodies which will be called from yyparse when
--    there is an error which has been corrected.  Since the errors get
--    corrected, yyerror does not get called.
--

   Max_Line_Length : constant Integer := 370;

   The_File : File_Type;                   -- Where the error report goes

   Text   : String (1 .. Max_Line_Length);    -- Current line from source file
   Length : Natural := 1;                  -- and its length

   -- types of lines found in the continuable error report section
   type User_Defined_Thing is
     (WITH_THING, USE_THING, INIT_THING, REPORT_THING, FINISH_THING,
      LINE_THING, EOF_THING);

--
-- TITLE:
--    Get Next Thing : Classify a line of text from the user defined error
--    report section of the .y file
--
-- OVERVIEW:
--    Read one line of the .y file, classifying it.
--    In the case of a %use or %with line, set the global variables Text and
--    Length to the tail of the line after the %use or %with.
-- ...................................................
   procedure Get_Next_Thing (Thing : in out User_Defined_Thing) is
      use Str_Pack;
      With_String   : constant String := "%WITH";
      Use_String    : constant String := "%USE";
      Init_String   : constant String := "%INITIALIZE_ERROR_REPORT";
      Finish_String : constant String := "%TERMINATE_ERROR_REPORT";
      Report_String : constant String := "%REPORT_ERROR";
      Temp          : Str (Max_Line_Length);
   begin
      if Thing = Eof_Thing or else Source_File.Is_End_Of_File then
         Thing := EOF_THING;
         return;
      end if;

      Source_File.Read_Line (Text, Length);
      if Length >= Use_String'Length then
         Assign (Text (1 .. Use_String'Length), Temp);
         if Value_Of (Upper_Case (Temp)) = Use_String then
            Thing              := USE_THING;
            Length             := Length - Use_String'Length;
            Text (1 .. Length) :=
              Text ((Use_String'Length + 1) .. Length + Use_String'Length);
            return;
         end if;
      end if;
      if Length >= With_String'Length then
         Assign (Text (1 .. With_String'Length), Temp);
         if Value_Of (Upper_Case (Temp)) = With_String then
            Thing              := WITH_THING;
            Length             := Length - With_String'Length;
            Text (1 .. Length) :=
              Text ((With_String'Length + 1) .. Length + With_String'Length);
            return;
         end if;
      end if;
      if Length >= Init_String'Length then
         Assign (Text (1 .. Init_String'Length), Temp);
         if Value_Of (Str_Pack.Upper_Case (Temp)) = Init_String then
            Thing := INIT_THING;
            return;
         end if;
      end if;
      if Length >= Finish_String'Length then
         Assign (Text (1 .. Finish_String'Length), Temp);
         if Value_Of (Str_Pack.Upper_Case (Temp)) = Finish_String then
            Thing := FINISH_THING;
            return;
         end if;
      end if;
      if Length >= Report_String'Length then
         Assign (Text (1 .. Report_String'Length), Temp);
         if Value_Of (Str_Pack.Upper_Case (Temp)) = Report_String then
            Thing := REPORT_THING;
            return;
         end if;
      end if;
      Thing := LINE_THING;
   end Get_Next_Thing;

--
-- TITLE:       procedure Write_Line
--    Write out a line to the Error Report generated ada file.
--
-- OVERVIEW:
--
-- ...................................................
   procedure Write_Line (S : in String) is
   begin
      Put_Line (The_File, S);
   end Write_Line;

--
-- TITLE:
--    Write the body of one of the user-defined procedures
--
-- OVERVIEW:
--    If User is True it means the user is defining the procedure body.  So
--    copy it from the source file.  Otherwise provide a null body.
-- ...................................................
   procedure Write_Thing (User : in Boolean; Thing : in out User_Defined_Thing)
   is
   begin
      if User then
         loop
            Get_Next_Thing (Thing);
            exit when Thing /= LINE_THING;
            Write_Line (Text (1 .. Length));
         end loop;
      else
         Write_Line ("begin");
         Write_Line ("  null;");
         Write_Line ("end;");
      end if;
      Write_Line ("");
   end Write_Thing;

--
-- TITLE:
--    Write the error report initialization function
--
-- OVERVIEW:
--    Write the header & then then body
-- ...................................................
   procedure Write_Init (User : in Boolean; Thing : in out User_Defined_Thing)
   is
   begin
      Write_Line ("procedure Initialize_User_Error_Report is");
      Write_Thing (User, Thing);
   end Write_Init;

--
-- TITLE:
--    Write the error report completion function
--
-- OVERVIEW:
--    Write the header & then then body
-- ...................................................

   procedure Write_Finish
     (User : in Boolean; Thing : in out User_Defined_Thing)
   is
   begin
      Write_Line ("procedure Terminate_User_Error_Report is");
      Write_Thing (User, Thing);
   end Write_Finish;

--
-- TITLE:
--    Write the error report function
--
-- OVERVIEW:
--    Write out the header with signature and then the body.
-- ...................................................
   procedure Write_Report
     (User : in Boolean; Thing : in out User_Defined_Thing)
   is
   begin
      Write_Line ("procedure Report_Continuable_Error ");
      Write_Line ("    (Line_Number : in Natural;");
      Write_Line ("    Offset      : in Natural;");
      Write_Line ("    Finish      : in Natural;");
      Write_Line ("    Message     : in String;");
      Write_Line ("    Error       : in Boolean)  is");
      Write_Thing (User, Thing);
   end Write_Report;

--
-- TITLE:       procedure Write_File
--    Create & open the Error_Report file, dump its contents.
--
-- PERSONNEL:
--    AUTHOR: Benjamin Hurwitz
--    DATE: Mar 11 1990
--
-- OVERVIEW:
--    The file being created will be used to report errors which yyparse
--    encounters.  Some of them it can correct, and some it cannot.
--    There are different mechanisms for reporting each of these.  There
--    is default reporting of corrected errors; messages are written
--    into the .lis file (Put, Put_Line).  Also,
--    the user can define his/her own error reporting of correctable errors
--    in the last section of the .y file.  If so, we here construct the
--    error report file so as to use these procedures.
--    Also in this package are variables and routines to
--    manipulate error information which the user can call from yyerror,
--    the procedure called when a non-correctable error is encountered.

--    The things generated which vary with runs of Ayacc is the names
--    of the Ada units, the packages With'ed and Used by the generated
--    error report package body and the bodies of the user-defined error report
--    routines for continuable errors.
--
-- NOTES:
--    This procedure is exported from the package.
--
-- SUBPROGRAM BODY:
--
   procedure Write_File is
      Current_Thing : User_Defined_Thing := LINE_THING;
      Wrote_Init    : Boolean            := False;
      Wrote_Finish  : Boolean            := False;
      Wrote_Report  : Boolean            := False;
   begin
      Create (The_File, Out_File, Get_Error_Report_File_Name);
      Write_Line ("package " & Error_Report_Unit_Name & " is");
      Write_Line ("");
      Write_Line ("    Syntax_Error : Exception;");
      Write_Line ("    Syntax_Warning : Exception;");
      Write_Line
        ("    Total_Errors : Natural := 0;   -- number of syntax errors found.");
      Write_Line
        ("    Total_Warnings : Natural := 0; -- number of syntax warnings found.");
      Write_Line ("        ");
      Write_Line
        ("    procedure Report_Continuable_Error(Line_Number : in Natural;");
      Write_Line
        ("                                       Offset      : in Natural;");
      Write_Line
        ("                                       Finish      : in Natural;");
      Write_Line
        ("                                       Message     : in String;");
      Write_Line
        ("                                       Error       : in Boolean);");
      Write_Line ("");
      Write_Line ("    procedure Initialize_Output;");
      Write_Line ("");
      Write_Line ("    procedure Finish_Output;");
      Write_Line ("");
      Write_Line ("    procedure Put(S: in String);");
      Write_Line ("");
      Write_Line ("    procedure Put(C: in Character);");
      Write_Line ("");
      Write_Line ("    procedure Put_Line(S: in String);");
      Write_Line ("");
      Write_Line ("end " & Error_Report_Unit_Name & ";");
      Write_Line ("");
      Write_Line ("");
      Write_Line ("with Text_IO;");
      -- Get %with's & %use's from source file
      loop
         Get_Next_Thing (Current_Thing);
         if Current_Thing = WITH_THING then
            Write_Line ("With " & Text (1 .. Length));
         elsif Current_Thing = USE_THING then
            Write_Line ("Use " & Text (1 .. Length));
         elsif Current_Thing = LINE_THING then
            null;
         else
            exit;
         end if;
      end loop;
      Write_Line ("");
      Write_Line ("package body " & Error_Report_Unit_Name & " is");
      Write_Line ("");
      Write_Line ("    The_File : Text_io.File_Type;");
      Write_Line ("");
      -- Get user declarations of error reporting procedures from source file
      while (Current_Thing /= EOF_THING) loop
         if Current_Thing = INIT_THING then
            Write_Init (True, Current_Thing);
            Wrote_Init := True;
         elsif Current_Thing = FINISH_THING then
            Write_Finish (True, Current_Thing);
            Wrote_Finish := True;
         elsif Current_Thing = REPORT_THING then
            Write_Report (True, Current_Thing);
            Wrote_Report := True;
         else
            Get_Next_Thing (Current_Thing);
         end if;
      end loop;
      if not Wrote_Init then
         Write_Init (False, Current_Thing);
      end if;
      if not Wrote_Finish then
         Write_Finish (False, Current_Thing);
      end if;
      if not Wrote_Report then
         Write_Report (False, Current_Thing);
      end if;
      Write_Line ("");
      Write_Line ("    procedure Initialize_Output is");
      Write_Line ("      begin");
      Write_Line
        ("        Text_io.Create(The_File, Text_io.Out_File, " & '"' &
         Get_Listing_File_Name & '"' & ");");
      Write_Line ("        initialize_user_error_report;");
      Write_Line ("      end Initialize_Output;");
      Write_Line ("");
      Write_Line ("    procedure Finish_Output is");
      Write_Line ("      begin");
      Write_Line ("        Text_io.Close(The_File);");
      Write_Line ("        terminate_user_error_report;");
      Write_Line ("      end Finish_Output;");
      Write_Line ("");
      Write_Line ("    procedure Put(S: in String) is");
      Write_Line ("    begin");
      Write_Line ("      Text_io.put(The_File, S);");
      Write_Line ("    end Put;");
      Write_Line ("");
      Write_Line ("    procedure Put(C: in Character) is");
      Write_Line ("    begin");
      Write_Line ("      Text_io.put(The_File, C);");
      Write_Line ("    end Put;");
      Write_Line ("");
      Write_Line ("    procedure Put_Line(S: in String) is");
      Write_Line ("    begin");
      Write_Line ("      Text_io.put_Line(The_File, S);");
      Write_Line ("    end Put_Line;");
      Write_Line ("");
      Write_Line ("");
      Write_Line ("end " & Error_Report_Unit_Name & ";");
      Close (The_File);
   end Write_File;
-- ...................................................

begin
   null;
end Error_Report_File;
