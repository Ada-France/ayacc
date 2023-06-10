with calc_parser, calc_lex_io, text_io;

procedure driver is 
  in_file_name: string(1..80);
  last        : natural;
begin 
    text_io.put("Enter input file: ");
    text_io.get_line(in_file_name, last);
    calc_lex_io.open_input(in_file_name(1..last));
    --calc_lex_io.open_input("/dev/tty");
    calc_lex_io.create_output;
    calc_parser.yyparse;
    calc_lex_io.close_input;
    calc_lex_io.close_output;
end driver;
