separate (Command_Line_Interface)
procedure Read_Command_Line (Command_Args : out Command_Line_Type) is

  procedure Get_Foreign (P : out String);
    pragma Interface (External, Get_Foreign);
    pragma Import_Valued_Procedure (Get_Foreign,
                                    "LIB$GET_FOREIGN",
                                    (String), (Descriptor (S)));

begin
  Get_Foreign (Command_Args);
end Read_Command_Line;
