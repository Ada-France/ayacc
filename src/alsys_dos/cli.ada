-- $Header: /cf/ua/arcadia/alex-ayacc/ayacc/src/RCS/cli__read_command_line.a,v 1.1 88/08/08 12:08:33 arcadia Exp $ 
--*************************************************************************** 
--          This file is subject to the Arcadia License Agreement. 
--
--                      (see notice in ayacc.a)
--
--*************************************************************************** 

--|
--| Notes: This routine contains the machine specific details of how
--|        Ayacc obtains the command line arguments from the host Operating
--|        System.  This version assumes Alsys running on DOS machines.
--|                  (modified by Sriram Sankar)
--|
--|        The only requirement on this subunit is that it place the string
--|        of characters typed by the user on the command line into the
--|        parameter "Command_Args".
--|

with DOS; use DOS;
separate (Command_Line_Interface)
procedure Read_Command_Line (Command_Args : out Command_Line_Type) is

  Parms : constant String := Get_Parms;

begin

  Command_Args(Command_Args'First .. Command_Args'First+Parms'Length-1) := Parms;
  Command_Args(Command_Args'First+Parms'Length .. Command_Args'Last) := (others => ' ');

end Read_Command_Line;
