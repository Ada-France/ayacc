--  Advanced Resource Embedder 1.5.0
package Parse_Template_File.Templates is

   body_ayacc : aliased constant Content_Array;

private

   L_1   : aliased constant String := "--  Warning: This file is automatically g"
       & "enerated by AYACC.";
   L_2   : aliased constant String := "--           It is useless to modify it. "
       & "Change the "".Y"" & "".L"" files instead.";
   L_3   : aliased constant String := "%%1 user";
   L_4   : aliased constant String := "";
   L_5   : aliased constant String := "   procedure ${YYPARSE}${YYPARSEPARAM} is";
   L_6   : aliased constant String := "%yydecl";
   L_7   : aliased constant String := "      --  Rename User Defined Packages to"
       & " Internal Names.";
   L_8   : aliased constant String := "%%2 renames";
   L_9   : aliased constant String := "";
   L_10  : aliased constant String := "      use yy_tokens, yy_goto_tables, yy_s"
       & "hift_reduce_tables;";
   L_11  : aliased constant String := "";
   L_12  : aliased constant String := "%if yyerrok";
   L_13  : aliased constant String := "      procedure yyerrok;";
   L_14  : aliased constant String := "%end";
   L_15  : aliased constant String := "%if yyclearin";
   L_16  : aliased constant String := "      procedure yyclearin;";
   L_17  : aliased constant String := "%end";
   L_18  : aliased constant String := "      procedure handle_error;";
   L_19  : aliased constant String := "";
   L_20  : aliased constant String := "%if error";
   L_21  : aliased constant String := "      --   One of the extension of ayacc."
       & " Used for";
   L_22  : aliased constant String := "      --   error recovery and error repor"
       & "ting.";
   L_23  : aliased constant String := "";
   L_24  : aliased constant String := "      package yyparser_input is";
   L_25  : aliased constant String := "         --";
   L_26  : aliased constant String := "         --  TITLE";
   L_27  : aliased constant String := "         --   yyparser input.";
   L_28  : aliased constant String := "         --";
   L_29  : aliased constant String := "         -- OVERVIEW";
   L_30  : aliased constant String := "         --   In Ayacc, parser get the in"
       & "put directly from lexical scanner.";
   L_31  : aliased constant String := "         --   In the extension, we have m"
       & "ore power in error recovery which will";
   L_32  : aliased constant String := "         --   try to replace, delete or i"
       & "nsert a token into the input";
   L_33  : aliased constant String := "         --   stream. Since general lexic"
       & "al scanner does not support";
   L_34  : aliased constant String := "         --   replace, delete or insert a"
       & " token, we must maintain our";
   L_35  : aliased constant String := "         --   own input stream to support"
       & " these functions. It is the";
   L_36  : aliased constant String := "         --   purpose that we introduce y"
       & "yparser_input. So parser no";
   L_37  : aliased constant String := "         --   longer interacts with lexic"
       & "al scanner, instead, parser";
   L_38  : aliased constant String := "         --   will get the input from yyp"
       & "arser_input. Yyparser_Input";
   L_39  : aliased constant String := "         --   get the input from lexical "
       & "scanner and supports";
   L_40  : aliased constant String := "         --   replacing, deleting and ins"
       & "erting tokens.";
   L_41  : aliased constant String := "         --";
   L_42  : aliased constant String := "";
   L_43  : aliased constant String := "         type string_ptr is access string"
       & ";";
   L_44  : aliased constant String := "";
   L_45  : aliased constant String := "         type tokenbox is record";
   L_46  : aliased constant String := "          --";
   L_47  : aliased constant String := "          --  OVERVIEW";
   L_48  : aliased constant String := "          --    Tokenbox is the type of t"
       & "he element of the input";
   L_49  : aliased constant String := "          --    stream maintained in yypa"
       & "rser_input. It contains";
   L_50  : aliased constant String := "          --    the value of the token, t"
       & "he line on which the token";
   L_51  : aliased constant String := "          --    resides, the line number "
       & "on which the token resides.";
   L_52  : aliased constant String := "          --    It also contains the begi"
       & "n and end column of the token.";
   L_53  : aliased constant String := "            token         : yy_tokens.Tok"
       & "en;";
   L_54  : aliased constant String := "            lval          : YYSType;";
   L_55  : aliased constant String := "            line          : string_ptr;";
   L_56  : aliased constant String := "            line_number   : Natural := 1;";
   L_57  : aliased constant String := "            token_start   : Natural := 1;";
   L_58  : aliased constant String := "            token_end     : Natural := 1;";
   L_59  : aliased constant String := "         end record;";
   L_60  : aliased constant String := "";
   L_61  : aliased constant String := "         type boxed_token is access token"
       & "box;";
   L_62  : aliased constant String := "";
   L_63  : aliased constant String := "         procedure unget(tok : in boxed_t"
       & "oken);";
   L_64  : aliased constant String := "         --  push a token back into input"
       & " stream.";
   L_65  : aliased constant String := "";
   L_66  : aliased constant String := "         function get return boxed_token;";
   L_67  : aliased constant String := "         --  get a token from input strea"
       & "m";
   L_68  : aliased constant String := "";
   L_69  : aliased constant String := "         procedure reset_peek;";
   L_70  : aliased constant String := "         function peek return boxed_token"
       & ";";
   L_71  : aliased constant String := "         --  During error recovery, we wi"
       & "ll lookahead to see the";
   L_72  : aliased constant String := "         --  affect of the error recovery"
       & ". The lookahead does not";
   L_73  : aliased constant String := "         --  means that we actually accep"
       & "t the input, instead, it";
   L_74  : aliased constant String := "         --  only means that we peek the "
       & "future input. It is the";
   L_75  : aliased constant String := "         --  purpose of function peek and"
       & " it is also the difference";
   L_76  : aliased constant String := "         --  between peek and get. We mai"
       & "ntain a counter indicating";
   L_77  : aliased constant String := "         --  how many token we have peeke"
       & "d and reset_peek will";
   L_78  : aliased constant String := "         --  reset that counter.";
   L_79  : aliased constant String := "";
   L_80  : aliased constant String := "         function tbox (token : yy_tokens"
       & ".Token ) return boxed_token;";
   L_81  : aliased constant String := "         --  Given the token got from the"
       & " lexical scanner, tbox";
   L_82  : aliased constant String := "         --  collect other information, s"
       & "uch as, line, line number etc.";
   L_83  : aliased constant String := "         --  to construct a boxed_token.";
   L_84  : aliased constant String := "";
   L_85  : aliased constant String := "         input_token    : yyparser_input."
       & "boxed_token;";
   L_86  : aliased constant String := "         previous_token : yyparser_input."
       & "boxed_token;";
   L_87  : aliased constant String := "         --  The current and previous tok"
       & "en processed by parser.";
   L_88  : aliased constant String := "";
   L_89  : aliased constant String := "      end yyparser_input;";
   L_90  : aliased constant String := "";
   L_91  : aliased constant String := "      package yyerror_recovery is";
   L_92  : aliased constant String := "         --";
   L_93  : aliased constant String := "         -- TITLE";
   L_94  : aliased constant String := "         --";
   L_95  : aliased constant String := "         --   Yyerror_Recovery.";
   L_96  : aliased constant String := "         --";
   L_97  : aliased constant String := "         -- OVERVIEW";
   L_98  : aliased constant String := "         --   This package contains all o"
       & "f errro recovery staff,";
   L_99  : aliased constant String := "         --   in addition to those of Aya"
       & "cc.";
   L_100 : aliased constant String := "";
   L_101 : aliased constant String := "         previous_action : Integer;";
   L_102 : aliased constant String := "         -- This variable is used to save"
       & " the previous action the parser made.";
   L_103 : aliased constant String := "";
   L_104 : aliased constant String := "         previous_error_flag : Natural :="
       & " 0;";
   L_105 : aliased constant String := "         -- This variable is used to save"
       & " the previous error flag.";
   L_106 : aliased constant String := "";
   L_107 : aliased constant String := "         valuing : Boolean := True;";
   L_108 : aliased constant String := "         -- Indicates whether to perform "
       & "semantic actions. If exception";
   L_109 : aliased constant String := "         -- is raised during semantic act"
       & "ion after error recovery, we";
   L_110 : aliased constant String := "         -- set valuing to False which ca"
       & "uses no semantic actions to";
   L_111 : aliased constant String := "         -- be invoked any more.";
   L_112 : aliased constant String := "";
   L_113 : aliased constant String := "         procedure flag_token ( error : i"
       & "n Boolean := True );";
   L_114 : aliased constant String := "         --  This procedure will point ou"
       & "t the position of the";
   L_115 : aliased constant String := "         --  current token.";
   L_116 : aliased constant String := "";
   L_117 : aliased constant String := "         procedure finale;";
   L_118 : aliased constant String := "         -- This procedure prepares the f"
       & "inal report for error report.";
   L_119 : aliased constant String := "";
   L_120 : aliased constant String := "         procedure try_recovery;";
   L_121 : aliased constant String := "         -- It is the main procedure for "
       & "error recovery.";
   L_122 : aliased constant String := "";
   L_123 : aliased constant String := "         line_number : Integer := 0;";
   L_124 : aliased constant String := "         -- Indicates the last line havin"
       & "g been outputed to the error file.";
   L_125 : aliased constant String := "";
   L_126 : aliased constant String := "         procedure put_new_line;";
   L_127 : aliased constant String := "         -- This procedure outputs the wh"
       & "ole line on which input_token";
   L_128 : aliased constant String := "         -- resides along with line numbe"
       & "r to the file for error reporting.";
   L_129 : aliased constant String := "      end yyerror_recovery;";
   L_130 : aliased constant String := "";
   L_131 : aliased constant String := "      use yyerror_recovery;";
   L_132 : aliased constant String := "";
   L_133 : aliased constant String := "      package user_defined_errors is";
   L_134 : aliased constant String := "         --";
   L_135 : aliased constant String := "         --  TITLE";
   L_136 : aliased constant String := "         --    User Defined Errors.";
   L_137 : aliased constant String := "         --";
   L_138 : aliased constant String := "         --  OVERVIEW";
   L_139 : aliased constant String := "         --    This package is used to fa"
       & "cilite the error reporting.";
   L_140 : aliased constant String := "";
   L_141 : aliased constant String := "         procedure parser_error(Message :"
       & " in String );";
   L_142 : aliased constant String := "         procedure parser_warning(Message"
       & " : in String );";
   L_143 : aliased constant String := "";
   L_144 : aliased constant String := "      end user_defined_errors;";
   L_145 : aliased constant String := "";
   L_146 : aliased constant String := "%end";
   L_147 : aliased constant String := "      subtype goto_row is yy_goto_tables."
       & "Row;";
   L_148 : aliased constant String := "      subtype reduce_row is yy_shift_redu"
       & "ce_tables.Row;";
   L_149 : aliased constant String := "";
   L_150 : aliased constant String := "      package yy is";
   L_151 : aliased constant String := "";
   L_152 : aliased constant String := "         --  the size of the value and st"
       & "ate stacks";
   L_153 : aliased constant String := "         --  Affects error 'Stack size ex"
       & "ceeded on state_stack'";
   L_154 : aliased constant String := "         stack_size : constant Natural :="
       & " ${YYSTACKSIZE};";
   L_155 : aliased constant String := "";
   L_156 : aliased constant String := "         --  subtype rule         is Natu"
       & "ral;";
   L_157 : aliased constant String := "         subtype parse_state is Natural;";
   L_158 : aliased constant String := "         --  subtype nonterminal  is Inte"
       & "ger;";
   L_159 : aliased constant String := "";
   L_160 : aliased constant String := "         --  encryption constants";
   L_161 : aliased constant String := "         default           : constant := "
       & "-1;";
   L_162 : aliased constant String := "         first_shift_entry : constant := "
       & "0;";
   L_163 : aliased constant String := "         accept_code       : constant := "
       & "-3001;";
   L_164 : aliased constant String := "         error_code        : constant := "
       & "-3000;";
   L_165 : aliased constant String := "";
   L_166 : aliased constant String := "         --  stack data used by the parse"
       & "r";
   L_167 : aliased constant String := "         tos                : Natural := "
       & "0;";
   L_168 : aliased constant String := "         value_stack        : array (0 .."
       & " stack_size) of yy_tokens.YYSType;";
   L_169 : aliased constant String := "         state_stack        : array (0 .."
       & " stack_size) of parse_state;";
   L_170 : aliased constant String := "";
   L_171 : aliased constant String := "         --  current input symbol and act"
       & "ion the parser is on";
   L_172 : aliased constant String := "         action             : Integer;";
   L_173 : aliased constant String := "         rule_id            : Rule;";
   L_174 : aliased constant String := "         input_symbol       : yy_tokens.T"
       & "oken := ERROR;";
   L_175 : aliased constant String := "";
   L_176 : aliased constant String := "         --  error recovery flag";
   L_177 : aliased constant String := "         error_flag : Natural := 0;";
   L_178 : aliased constant String := "         --  indicates  3 - (number of va"
       & "lid shifts after an error occurs)";
   L_179 : aliased constant String := "";
   L_180 : aliased constant String := "         look_ahead : Boolean := True;";
   L_181 : aliased constant String := "         index      : reduce_row;";
   L_182 : aliased constant String := "";
   L_183 : aliased constant String := "         --  Is Debugging option on or of"
       & "f";
   L_184 : aliased constant String := "%if debug";
   L_185 : aliased constant String := "         debug : constant Boolean := True"
       & ";";
   L_186 : aliased constant String := "%else";
   L_187 : aliased constant String := "         debug : constant Boolean := Fals"
       & "e;";
   L_188 : aliased constant String := "%end";
   L_189 : aliased constant String := "      end yy;";
   L_190 : aliased constant String := "";
   L_191 : aliased constant String := "      procedure Put_State_Stack is";
   L_192 : aliased constant String := "         begin";
   L_193 : aliased constant String := "            Text_IO.Put (""Stack:"");";
   L_194 : aliased constant String := "            for index in 0 .. yy.tos loop";
   L_195 : aliased constant String := "               Text_IO.Put (yy.state_stac"
       & "k (index)'Image);";
   L_196 : aliased constant String := "            end loop;";
   L_197 : aliased constant String := "            Text_IO.New_Line;";
   L_198 : aliased constant String := "         end;";
   L_199 : aliased constant String := "";
   L_200 : aliased constant String := "      procedure shift_debug (state_id : y"
       & "y.parse_state; lexeme : yy_tokens.Token);";
   L_201 : aliased constant String := "      procedure reduce_debug (rule_id : R"
       & "ule; state_id : yy.parse_state);";
   L_202 : aliased constant String := "";
   L_203 : aliased constant String := "      function goto_state";
   L_204 : aliased constant String := "         (state : yy.parse_state;";
   L_205 : aliased constant String := "          sym   : Nonterminal) return yy."
       & "parse_state;";
   L_206 : aliased constant String := "";
   L_207 : aliased constant String := "      function parse_action";
   L_208 : aliased constant String := "         (state : yy.parse_state;";
   L_209 : aliased constant String := "          t     : yy_tokens.Token) return"
       & " Integer;";
   L_210 : aliased constant String := "";
   L_211 : aliased constant String := "      pragma Inline (goto_state, parse_ac"
       & "tion);";
   L_212 : aliased constant String := "";
   L_213 : aliased constant String := "      function goto_state (state : yy.par"
       & "se_state;";
   L_214 : aliased constant String := "                           sym   : Nonter"
       & "minal) return yy.parse_state is";
   L_215 : aliased constant String := "         index : goto_row;";
   L_216 : aliased constant String := "      begin";
   L_217 : aliased constant String := "         index := Goto_Offset (state);";
   L_218 : aliased constant String := "         while Goto_Matrix (index).Nonter"
       & "m /= sym loop";
   L_219 : aliased constant String := "            index := index + 1;";
   L_220 : aliased constant String := "         end loop;";
   L_221 : aliased constant String := "         return Integer (Goto_Matrix (ind"
       & "ex).Newstate);";
   L_222 : aliased constant String := "      end goto_state;";
   L_223 : aliased constant String := "";
   L_224 : aliased constant String := "";
   L_225 : aliased constant String := "      function parse_action (state : yy.p"
       & "arse_state;";
   L_226 : aliased constant String := "                             t     : yy_t"
       & "okens.Token) return Integer is";
   L_227 : aliased constant String := "         index   : reduce_row;";
   L_228 : aliased constant String := "         tok_pos : Integer;";
   L_229 : aliased constant String := "         default : constant Integer := -1"
       & ";";
   L_230 : aliased constant String := "      begin";
   L_231 : aliased constant String := "         tok_pos := yy_tokens.Token'Pos ("
       & "t);";
   L_232 : aliased constant String := "         index   := Shift_Reduce_Offset ("
       & "state);";
   L_233 : aliased constant String := "         while Integer (Shift_Reduce_Matr"
       & "ix (index).T) /= tok_pos";
   L_234 : aliased constant String := "           and then Integer (Shift_Reduce"
       & "_Matrix (index).T) /= default";
   L_235 : aliased constant String := "         loop";
   L_236 : aliased constant String := "            index := index + 1;";
   L_237 : aliased constant String := "         end loop;";
   L_238 : aliased constant String := "         return Integer (Shift_Reduce_Mat"
       & "rix (index).Act);";
   L_239 : aliased constant String := "      end parse_action;";
   L_240 : aliased constant String := "";
   L_241 : aliased constant String := "      --  error recovery stuff";
   L_242 : aliased constant String := "";
   L_243 : aliased constant String := "      procedure handle_error is";
   L_244 : aliased constant String := "         temp_action : Integer;";
   L_245 : aliased constant String := "      begin";
   L_246 : aliased constant String := "";
   L_247 : aliased constant String := "         if yy.error_flag = 3 then --  no"
       & " shift yet, clobber input.";
   L_248 : aliased constant String := "            if yy.debug then";
   L_249 : aliased constant String := "               Text_IO.Put_Line (""  -- A"
       & "yacc.YYParse: Error Recovery Clobbers """;
   L_250 : aliased constant String := "                                 & yy_tok"
       & "ens.Token'Image (yy.input_symbol));";
   L_251 : aliased constant String := "%if error";
   L_252 : aliased constant String := "-- UMASS CODES :";
   L_253 : aliased constant String := "               yy_error_report.Put_Line ("
       & """Ayacc.YYParse: Error Recovery Clobbers """;
   L_254 : aliased constant String := "                                         "
       & "& yy_tokens.Token'Image (yy.input_symbol));";
   L_255 : aliased constant String := "-- END OF UMASS CODES.";
   L_256 : aliased constant String := "%end";
   L_257 : aliased constant String := "            end if;";
   L_258 : aliased constant String := "            if yy.input_symbol = yy_token"
       & "s.END_OF_INPUT then  -- don't discard,";
   L_259 : aliased constant String := "               if yy.debug then";
   L_260 : aliased constant String := "                  Text_IO.Put_Line (""  -"
       & "- Ayacc.YYParse: Can't discard END_OF_INPUT, quiting..."");";
   L_261 : aliased constant String := "%if error";
   L_262 : aliased constant String := "-- UMASS CODES :";
   L_263 : aliased constant String := "                  yy_error_report.Put_Lin"
       & "e (""Ayacc.YYParse: Can't discard END_OF_INPUT, quiting..."");";
   L_264 : aliased constant String := "-- END OF UMASS CODES.";
   L_265 : aliased constant String := "%end";
   L_266 : aliased constant String := "               end if;";
   L_267 : aliased constant String := "%if error";
   L_268 : aliased constant String := "-- UMASS CODES :";
   L_269 : aliased constant String := "               yyerror_recovery.finale;";
   L_270 : aliased constant String := "-- END OF UMASS CODES.";
   L_271 : aliased constant String := "%end";
   L_272 : aliased constant String := "               raise yy_tokens.Syntax_Err"
       & "or;";
   L_273 : aliased constant String := "            end if;";
   L_274 : aliased constant String := "";
   L_275 : aliased constant String := "            yy.look_ahead := True;   --  "
       & "get next token";
   L_276 : aliased constant String := "            return;                  --  "
       & "and try again...";
   L_277 : aliased constant String := "         end if;";
   L_278 : aliased constant String := "";
   L_279 : aliased constant String := "         if yy.error_flag = 0 then --  br"
       & "and new error";
   L_280 : aliased constant String := "            yyerror (""Syntax Error"");";
   L_281 : aliased constant String := "%if error";
   L_282 : aliased constant String := "-- UMASS CODES :";
   L_283 : aliased constant String := "            yy_error_report.Put_Line ( """
       & "Skipping..."" );";
   L_284 : aliased constant String := "            yy_error_report.Put_Line ( "
       & """"" );";
   L_285 : aliased constant String := "-- END OF UMASS CODES.";
   L_286 : aliased constant String := "%end";
   L_287 : aliased constant String := "         end if;";
   L_288 : aliased constant String := "";
   L_289 : aliased constant String := "         yy.error_flag := 3;";
   L_290 : aliased constant String := "";
   L_291 : aliased constant String := "         --  find state on stack where er"
       & "ror is a valid shift --";
   L_292 : aliased constant String := "";
   L_293 : aliased constant String := "         if yy.debug then";
   L_294 : aliased constant String := "            Text_IO.Put_Line (""  -- Ayac"
       & "c.YYParse: Looking for state with error as valid shift"");";
   L_295 : aliased constant String := "%if error";
   L_296 : aliased constant String := "-- UMASS CODES :";
   L_297 : aliased constant String := "            yy_error_report.Put_Line(""Ay"
       & "acc.YYParse: Looking for state with error as valid shift"");";
   L_298 : aliased constant String := "-- END OF UMASS CODES.";
   L_299 : aliased constant String := "%end";
   L_300 : aliased constant String := "         end if;";
   L_301 : aliased constant String := "";
   L_302 : aliased constant String := "         loop";
   L_303 : aliased constant String := "            if yy.debug then";
   L_304 : aliased constant String := "               Text_IO.Put_Line (""  -- A"
       & "yacc.YYParse: Examining State """;
   L_305 : aliased constant String := "                                 & yy.par"
       & "se_state'Image (yy.state_stack (yy.tos)));";
   L_306 : aliased constant String := "%if error";
   L_307 : aliased constant String := "-- UMASS CODES :";
   L_308 : aliased constant String := "               yy_error_report.Put_Line ("
       & """Ayacc.YYParse: Examining State """;
   L_309 : aliased constant String := "                                         "
       & "& yy.parse_state'Image (yy.state_stack (yy.tos)));";
   L_310 : aliased constant String := "-- END OF UMASS CODES.";
   L_311 : aliased constant String := "%end";
   L_312 : aliased constant String := "            end if;";
   L_313 : aliased constant String := "            temp_action := parse_action ("
       & "yy.state_stack (yy.tos), ERROR);";
   L_314 : aliased constant String := "";
   L_315 : aliased constant String := "            if temp_action >= yy.first_sh"
       & "ift_entry then";
   L_316 : aliased constant String := "               if yy.tos = yy.stack_size "
       & "then";
   L_317 : aliased constant String := "                  Text_IO.Put_Line (""  -"
       & "- Ayacc.YYParse: Stack size exceeded on state_stack"");";
   L_318 : aliased constant String := "%if error";
   L_319 : aliased constant String := "-- UMASS CODES :";
   L_320 : aliased constant String := "                  yy_error_report.Put_Lin"
       & "e (""Ayacc.YYParse: Stack size exceeded on state_stack"");";
   L_321 : aliased constant String := "                  yyerror_recovery.finale"
       & ";";
   L_322 : aliased constant String := "-- END OF UMASS CODES.";
   L_323 : aliased constant String := "%end";
   L_324 : aliased constant String := "                  raise yy_tokens.Syntax_"
       & "Error;";
   L_325 : aliased constant String := "               end if;";
   L_326 : aliased constant String := "               yy.tos                  :="
       & " yy.tos + 1;";
   L_327 : aliased constant String := "               yy.state_stack (yy.tos) :="
       & " temp_action;";
   L_328 : aliased constant String := "               exit;";
   L_329 : aliased constant String := "            end if;";
   L_330 : aliased constant String := "";
   L_331 : aliased constant String := "            if yy.tos /= 0 then";
   L_332 : aliased constant String := "               yy.tos := yy.tos - 1;";
   L_333 : aliased constant String := "            end if;";
   L_334 : aliased constant String := "";
   L_335 : aliased constant String := "            if yy.tos = 0 then";
   L_336 : aliased constant String := "               if yy.debug then";
   L_337 : aliased constant String := "                  Text_IO.Put_Line";
   L_338 : aliased constant String := "                     (""  -- Ayacc.YYPars"
       & "e: Error recovery popped entire stack, aborting..."");";
   L_339 : aliased constant String := "%if error";
   L_340 : aliased constant String := "-- UMASS CODES :";
   L_341 : aliased constant String := "                  yy_error_report.Put_Lin"
       & "e";
   L_342 : aliased constant String := "                     (""Ayacc.YYParse: Er"
       & "ror recovery popped entire stack, aborting..."");";
   L_343 : aliased constant String := "-- END OF UMASS CODES.";
   L_344 : aliased constant String := "%end";
   L_345 : aliased constant String := "               end if;";
   L_346 : aliased constant String := "%if error";
   L_347 : aliased constant String := "-- UMASS CODES :";
   L_348 : aliased constant String := "               yyerror_recovery.finale;";
   L_349 : aliased constant String := "-- END OF UMASS CODES.";
   L_350 : aliased constant String := "%end";
   L_351 : aliased constant String := "               raise yy_tokens.Syntax_Err"
       & "or;";
   L_352 : aliased constant String := "            end if;";
   L_353 : aliased constant String := "         end loop;";
   L_354 : aliased constant String := "";
   L_355 : aliased constant String := "         if yy.debug then";
   L_356 : aliased constant String := "            Text_IO.Put_Line (""  -- Ayac"
       & "c.YYParse: Shifted error token in state """;
   L_357 : aliased constant String := "                              & yy.parse_"
       & "state'Image (yy.state_stack (yy.tos)));";
   L_358 : aliased constant String := "%if error";
   L_359 : aliased constant String := "-- UMASS CODES :";
   L_360 : aliased constant String := "            yy_error_report.Put_Line (""A"
       & "yacc.YYParse: Shifted error token in state "" &";
   L_361 : aliased constant String := "                                      yy."
       & "parse_state'Image (yy.state_stack (yy.tos)));";
   L_362 : aliased constant String := "-- END OF UMASS CODES.";
   L_363 : aliased constant String := "%end";
   L_364 : aliased constant String := "         end if;";
   L_365 : aliased constant String := "";
   L_366 : aliased constant String := "      end handle_error;";
   L_367 : aliased constant String := "";
   L_368 : aliased constant String := "      --  print debugging information for"
       & " a shift operation";
   L_369 : aliased constant String := "      procedure shift_debug (state_id : y"
       & "y.parse_state; lexeme : yy_tokens.Token) is";
   L_370 : aliased constant String := "      begin";
   L_371 : aliased constant String := "         Text_IO.Put_Line (""  -- Ayacc.Y"
       & "YParse: Shift """;
   L_372 : aliased constant String := "                           & yy.parse_sta"
       & "te'Image (state_id) & "" on input symbol """;
   L_373 : aliased constant String := "                           & yy_tokens.To"
       & "ken'Image (lexeme));";
   L_374 : aliased constant String := "%if error";
   L_375 : aliased constant String := "-- UMASS CODES :";
   L_376 : aliased constant String := "         yy_error_report.Put_Line (""Ayac"
       & "c.YYParse: Shift ""& yy.parse_state'Image (state_id)&"" on input symbo"
       & "l ""&";
   L_377 : aliased constant String := "                                   yy_tok"
       & "ens.Token'Image (lexeme) );";
   L_378 : aliased constant String := "-- END OF UMASS CODES.";
   L_379 : aliased constant String := "%end";
   L_380 : aliased constant String := "      end shift_debug;";
   L_381 : aliased constant String := "";
   L_382 : aliased constant String := "      --  print debugging information for"
       & " a reduce operation";
   L_383 : aliased constant String := "      procedure reduce_debug (rule_id : R"
       & "ule; state_id : yy.parse_state) is";
   L_384 : aliased constant String := "      begin";
   L_385 : aliased constant String := "         Text_IO.Put_Line (""  -- Ayacc.Y"
       & "YParse: Reduce by rule """;
   L_386 : aliased constant String := "                           & Rule'Image ("
       & "rule_id) & "" goto state """;
   L_387 : aliased constant String := "                           & yy.parse_sta"
       & "te'Image (state_id));";
   L_388 : aliased constant String := "%if error";
   L_389 : aliased constant String := "-- UMASS CODES :";
   L_390 : aliased constant String := "         yy_error_report.Put_Line (""Ayac"
       & "c.YYParse: Reduce by rule "" & Rule'Image (rule_id) & "" goto state """
       & "&";
   L_391 : aliased constant String := "                                   yy.par"
       & "se_state'Image (state_id));";
   L_392 : aliased constant String := "-- END OF UMASS CODES.";
   L_393 : aliased constant String := "%end";
   L_394 : aliased constant String := "      end reduce_debug;";
   L_395 : aliased constant String := "";
   L_396 : aliased constant String := "%if yyerrok";
   L_397 : aliased constant String := "      --  make the parser believe that 3 "
       & "valid shifts have occured.";
   L_398 : aliased constant String := "      --  used for error recovery.";
   L_399 : aliased constant String := "      procedure yyerrok is";
   L_400 : aliased constant String := "      begin";
   L_401 : aliased constant String := "         yy.error_flag := 0;";
   L_402 : aliased constant String := "      end yyerrok;";
   L_403 : aliased constant String := "";
   L_404 : aliased constant String := "%end";
   L_405 : aliased constant String := "%if yyclearin";
   L_406 : aliased constant String := "      --  called to clear input symbol th"
       & "at caused an error.";
   L_407 : aliased constant String := "      procedure yyclearin is";
   L_408 : aliased constant String := "      begin";
   L_409 : aliased constant String := "         --  yy.input_symbol := ${YYLEX};";
   L_410 : aliased constant String := "         yy.look_ahead := True;";
   L_411 : aliased constant String := "      end yyclearin;";
   L_412 : aliased constant String := "";
   L_413 : aliased constant String := "%end";
   L_414 : aliased constant String := "%if error";
   L_415 : aliased constant String := "-- UMASS CODES :";
   L_416 : aliased constant String := "   --   Bodies of yyparser_input, yyerror"
       & "_recovery, user_define_errors.";
   L_417 : aliased constant String := "";
   L_418 : aliased constant String := "package body yyparser_input is";
   L_419 : aliased constant String := "   pragma Style_Checks (""-mrlut"");";
   L_420 : aliased constant String := "";
   L_421 : aliased constant String := "   input_stream_size : constant Integer :"
       & "= 10;";
   L_422 : aliased constant String := "   --  Input_stream_size indicates how ma"
       & "ny tokens can";
   L_423 : aliased constant String := "   --  be hold in input stream.";
   L_424 : aliased constant String := "";
   L_425 : aliased constant String := "   input_stream : array (0 .. input_strea"
       & "m_size - 1) of boxed_token;";
   L_426 : aliased constant String := "";
   L_427 : aliased constant String := "   index : Integer := 0;           --  In"
       & "dicates the position of the next";
   L_428 : aliased constant String := "                                   --  bu"
       & "ffered token in the input stream.";
   L_429 : aliased constant String := "   peek_count : Integer := 0;      --  # "
       & "of tokens seen by peeking in the input stream.";
   L_430 : aliased constant String := "   buffered : Integer := 0;        --  # "
       & "of buffered tokens in the input stream.";
   L_431 : aliased constant String := "";
   L_432 : aliased constant String := "   function tbox(token : yy_tokens.Token)"
       & " return boxed_token is";
   L_433 : aliased constant String := "     boxed : boxed_token;";
   L_434 : aliased constant String := "     line : string ( 1 .. 1024 );";
   L_435 : aliased constant String := "     line_length : Integer;";
   L_436 : aliased constant String := "   begin";
   L_437 : aliased constant String := "      boxed := new tokenbox;";
   L_438 : aliased constant String := "      boxed.token := token;";
   L_439 : aliased constant String := "      boxed.lval := YYLVal;";
   L_440 : aliased constant String := "      boxed.line_number := yy_line_number"
       & ";";
   L_441 : aliased constant String := "      yy_get_token_line (line, line_lengt"
       & "h);";
   L_442 : aliased constant String := "      boxed.line := new String (1 .. line"
       & "_length);";
   L_443 : aliased constant String := "      boxed.line (1 .. line_length ) := l"
       & "ine (1 .. line_length);";
   L_444 : aliased constant String := "      boxed.token_start := yy_begin_colum"
       & "n;";
   L_445 : aliased constant String := "      boxed.token_end := yy_end_column;";
   L_446 : aliased constant String := "      return boxed;";
   L_447 : aliased constant String := "   end tbox;";
   L_448 : aliased constant String := "";
   L_449 : aliased constant String := "   function get return boxed_token is";
   L_450 : aliased constant String := "      t : boxed_token;";
   L_451 : aliased constant String := "   begin";
   L_452 : aliased constant String := "      if buffered = 0 then";
   L_453 : aliased constant String := "         --  No token is buffered in the "
       & "input stream";
   L_454 : aliased constant String := "         --  so we get input from lexical"
       & " scanner and return.";
   L_455 : aliased constant String := "         return tbox (${YYLEX});";
   L_456 : aliased constant String := "      else";
   L_457 : aliased constant String := "         --  return the next buffered tok"
       & "en. And remove";
   L_458 : aliased constant String := "         --  it from input stream.";
   L_459 : aliased constant String := "         t := input_stream (index);";
   L_460 : aliased constant String := "         yylval := t.lval;";
   L_461 : aliased constant String := "         --  Increase index and decrease "
       & "buffered has";
   L_462 : aliased constant String := "         --  the affect of removing the r"
       & "eturned token";
   L_463 : aliased constant String := "         --  from input stream.";
   L_464 : aliased constant String := "         index := (index + 1) mod input_s"
       & "tream_size;";
   L_465 : aliased constant String := "         buffered := buffered - 1;";
   L_466 : aliased constant String := "         if peek_count > 0 then";
   L_467 : aliased constant String := "            --  Previously we were peekin"
       & "g the tokens";
   L_468 : aliased constant String := "            --  from index - 1 to index -"
       & " 1 + peek_count.";
   L_469 : aliased constant String := "            --  But now token at index - "
       & "1 is returned";
   L_470 : aliased constant String := "            --  and remove, so this token"
       & " is no longer";
   L_471 : aliased constant String := "            --  one of the token being pe"
       & "ek. So we must";
   L_472 : aliased constant String := "            --  decrease the peek_count. "
       & "If peek_count";
   L_473 : aliased constant String := "            --  is 0, we remains peeking "
       & "0 token, so we";
   L_474 : aliased constant String := "            --  do nothing.";
   L_475 : aliased constant String := "            peek_count := peek_count - 1;";
   L_476 : aliased constant String := "         end if;";
   L_477 : aliased constant String := "         return t;";
   L_478 : aliased constant String := "      end if;";
   L_479 : aliased constant String := "   end get;";
   L_480 : aliased constant String := "";
   L_481 : aliased constant String := "   procedure reset_peek is";
   L_482 : aliased constant String := "      --  Make it as if we have not peeke"
       & "d anything.";
   L_483 : aliased constant String := "   begin";
   L_484 : aliased constant String := "      peek_count := 0;";
   L_485 : aliased constant String := "   end reset_peek;";
   L_486 : aliased constant String := "";
   L_487 : aliased constant String := "   function peek return boxed_token is";
   L_488 : aliased constant String := "      t : boxed_token;";
   L_489 : aliased constant String := "   begin";
   L_490 : aliased constant String := "      if peek_count = buffered then";
   L_491 : aliased constant String := "         --  We have peeked all the buffe"
       & "red tokens";
   L_492 : aliased constant String := "         --  in the input stream, so next"
       & " peeked";
   L_493 : aliased constant String := "         --  token should be got from lex"
       & "ical scanner.";
   L_494 : aliased constant String := "         --  Also we must buffer that tok"
       & "en in the";
   L_495 : aliased constant String := "         --  input stream. It is the diff"
       & "erence between";
   L_496 : aliased constant String := "         --  peek and get.";
   L_497 : aliased constant String := "         t := tbox (${YYLEX});";
   L_498 : aliased constant String := "         input_stream ((index + buffered)"
       & " mod input_stream_size) := t;";
   L_499 : aliased constant String := "         buffered := buffered + 1;";
   L_500 : aliased constant String := "         if buffered > input_stream_size "
       & "then";
   L_501 : aliased constant String := "            Text_IO.Put_Line (""Warning :"
       & " input stream size exceed.""";
   L_502 : aliased constant String := "                              & "" So tok"
       & "en is lost in the input stream."" );";
   L_503 : aliased constant String := "         end if;";
   L_504 : aliased constant String := "";
   L_505 : aliased constant String := "      else";
   L_506 : aliased constant String := "         --  We have not peeked all the b"
       & "uffered tokens,";
   L_507 : aliased constant String := "         --  so we peek next buffered tok"
       & "en.";
   L_508 : aliased constant String := "";
   L_509 : aliased constant String := "         t := input_stream ((index+peek_c"
       & "ount) mod input_stream_size);";
   L_510 : aliased constant String := "      end if;";
   L_511 : aliased constant String := "";
   L_512 : aliased constant String := "      peek_count := peek_count + 1;";
   L_513 : aliased constant String := "      return t;";
   L_514 : aliased constant String := "   end peek;";
   L_515 : aliased constant String := "";
   L_516 : aliased constant String := "   procedure unget (tok : in boxed_token)"
       & " is";
   L_517 : aliased constant String := "   begin";
   L_518 : aliased constant String := "      --  First decrease the index.";
   L_519 : aliased constant String := "      if index = 0 then";
   L_520 : aliased constant String := "         index := input_stream_size - 1;";
   L_521 : aliased constant String := "      else";
   L_522 : aliased constant String := "         index := index - 1;";
   L_523 : aliased constant String := "      end if;";
   L_524 : aliased constant String := "      input_stream (index) := tok;";
   L_525 : aliased constant String := "      buffered := buffered + 1;";
   L_526 : aliased constant String := "      if buffered > input_stream_size the"
       & "n";
   L_527 : aliased constant String := "        Text_IO.Put_Line (""Warning : inp"
       & "ut stream size exceed.""";
   L_528 : aliased constant String := "                          & "" So token i"
       & "s lost in the input stream."" );";
   L_529 : aliased constant String := "      end if;";
   L_530 : aliased constant String := "";
   L_531 : aliased constant String := "      if peek_count > 0 then";
   L_532 : aliased constant String := "         --  We are peeking tokens, so we"
       & " must increase";
   L_533 : aliased constant String := "         --  peek_count to maintain the c"
       & "orrect peeking position.";
   L_534 : aliased constant String := "         peek_count := peek_count + 1;";
   L_535 : aliased constant String := "      end if;";
   L_536 : aliased constant String := "   end unget;";
   L_537 : aliased constant String := "";
   L_538 : aliased constant String := "   end yyparser_input;";
   L_539 : aliased constant String := "";
   L_540 : aliased constant String := "";
   L_541 : aliased constant String := "   package body user_defined_errors is";
   L_542 : aliased constant String := "";
   L_543 : aliased constant String := "      procedure parser_error(Message : in"
       & " String) is";
   L_544 : aliased constant String := "      begin";
   L_545 : aliased constant String := "         yy_error_report.report_continuab"
       & "le_error";
   L_546 : aliased constant String := "            (yyparser_input.input_token.l"
       & "ine_number,";
   L_547 : aliased constant String := "             yyparser_input.input_token.t"
       & "oken_start,";
   L_548 : aliased constant String := "             yyparser_input.input_token.t"
       & "oken_end,";
   L_549 : aliased constant String := "             Message,";
   L_550 : aliased constant String := "             True);";
   L_551 : aliased constant String := "         yy_error_report.total_errors := "
       & "yy_error_report.total_errors + 1;";
   L_552 : aliased constant String := "      end parser_error;";
   L_553 : aliased constant String := "";
   L_554 : aliased constant String := "      procedure parser_warning(Message : "
       & "in String) is";
   L_555 : aliased constant String := "      begin";
   L_556 : aliased constant String := "         yy_error_report.report_continuab"
       & "le_error";
   L_557 : aliased constant String := "            (yyparser_input.input_token.l"
       & "ine_number,";
   L_558 : aliased constant String := "             yyparser_input.input_token.t"
       & "oken_start,";
   L_559 : aliased constant String := "             yyparser_input.input_token.t"
       & "oken_end,";
   L_560 : aliased constant String := "             Message,";
   L_561 : aliased constant String := "             False);";
   L_562 : aliased constant String := "         yy_error_report.total_warnings :"
       & "= yy_error_report.total_warnings + 1;";
   L_563 : aliased constant String := "      end parser_warning;";
   L_564 : aliased constant String := "";
   L_565 : aliased constant String := "    end user_defined_errors;";
   L_566 : aliased constant String := "";
   L_567 : aliased constant String := "";
   L_568 : aliased constant String := "    package body yyerror_recovery is";
   L_569 : aliased constant String := "";
   L_570 : aliased constant String := "    max_forward_moves : constant Integer "
       & ":= 5;";
   L_571 : aliased constant String := "    --  Indicates how many tokens we will"
       & " peek at most during error recovery.";
   L_572 : aliased constant String := "";
   L_573 : aliased constant String := "    type change_type is (replace, insert,"
       & " delete);";
   L_574 : aliased constant String := "    --  Indicates what kind of change err"
       & "or recovery does to the input stream.";
   L_575 : aliased constant String := "";
   L_576 : aliased constant String := "    type correction_type is record";
   L_577 : aliased constant String := "       --  Indicates the correction error"
       & " recovery does to the input stream.";
   L_578 : aliased constant String := "       change    :   change_type;";
   L_579 : aliased constant String := "       score     :   Integer;";
   L_580 : aliased constant String := "       tokenbox  :   yyparser_input.boxed"
       & "_token;";
   L_581 : aliased constant String := "    end record;";
   L_582 : aliased constant String := "";
   L_583 : aliased constant String := "    procedure put_new_line is";
   L_584 : aliased constant String := "       line_number_string : constant stri"
       & "ng :=";
   L_585 : aliased constant String := "          Integer'Image (yyparser_input.i"
       & "nput_token.line_number);";
   L_586 : aliased constant String := "    begin";
   L_587 : aliased constant String := "       yy_error_report.put (line_number_s"
       & "tring);";
   L_588 : aliased constant String := "       for i in 1 .. 5 - Integer (line_nu"
       & "mber_string'length) loop";
   L_589 : aliased constant String := "          yy_error_report.put ("" "");";
   L_590 : aliased constant String := "       end loop;";
   L_591 : aliased constant String := "       yy_error_report.put (yyparser_inpu"
       & "t.input_token.line.all);";
   L_592 : aliased constant String := "    end put_new_line;";
   L_593 : aliased constant String := "";
   L_594 : aliased constant String := "";
   L_595 : aliased constant String := "    procedure finale is";
   L_596 : aliased constant String := "    begin";
   L_597 : aliased constant String := "       if yy_error_report.total_errors > "
       & "0 then";
   L_598 : aliased constant String := "          yy_error_report.Put_Line ("""")"
       & ";";
   L_599 : aliased constant String := "          yy_error_report.put (""Ayacc.YY"
       & "Parse : "" & Natural'Image (yy_error_report.total_errors));";
   L_600 : aliased constant String := "          if yy_error_report.total_errors"
       & " = 1 then";
   L_601 : aliased constant String := "             yy_error_report.Put_Line ("""
       & " syntax error found."");";
   L_602 : aliased constant String := "          else";
   L_603 : aliased constant String := "             yy_error_report.Put_Line ("""
       & " syntax errors found."");";
   L_604 : aliased constant String := "          end if;";
   L_605 : aliased constant String := "          yy_error_report.Finish_Output;";
   L_606 : aliased constant String := "          raise yy_error_report.Syntax_Er"
       & "ror;";
   L_607 : aliased constant String := "       elsif yy_error_report.total_warnin"
       & "gs > 0 then";
   L_608 : aliased constant String := "          yy_error_report.Put_Line ("""")"
       & ";";
   L_609 : aliased constant String := "          yy_error_report.put (""Ayacc.YY"
       & "Parse : "" & Natural'Image (yy_error_report.total_warnings));";
   L_610 : aliased constant String := "          if yy_error_report.total_warnin"
       & "gs = 1 then";
   L_611 : aliased constant String := "             yy_error_report.Put_Line ("""
       & " syntax warning found."");";
   L_612 : aliased constant String := "          else";
   L_613 : aliased constant String := "             yy_error_report.Put_Line ("""
       & " syntax warnings found."");";
   L_614 : aliased constant String := "          end if;";
   L_615 : aliased constant String := "";
   L_616 : aliased constant String := "          yy_error_report.Finish_Output;";
   L_617 : aliased constant String := "          raise yy_error_report.syntax_wa"
       & "rning;";
   L_618 : aliased constant String := "       end if;";
   L_619 : aliased constant String := "       yy_error_report.Finish_Output;";
   L_620 : aliased constant String := "    end finale;";
   L_621 : aliased constant String := "";
   L_622 : aliased constant String := "    procedure flag_token (error : in Bool"
       & "ean := True) is";
   L_623 : aliased constant String := "    --";
   L_624 : aliased constant String := "    --  OVERVIEW";
   L_625 : aliased constant String := "    --    This procedure will point out t"
       & "he position of the";
   L_626 : aliased constant String := "    --    current token.";
   L_627 : aliased constant String := "    --";
   L_628 : aliased constant String := "    begin";
   L_629 : aliased constant String := "       if yy.error_flag > 0 then";
   L_630 : aliased constant String := "          --  We have not seen 3 valid sh"
       & "ift yet, so we";
   L_631 : aliased constant String := "          --  do not need to report this "
       & "error.";
   L_632 : aliased constant String := "          return;";
   L_633 : aliased constant String := "       end if;";
   L_634 : aliased constant String := "";
   L_635 : aliased constant String := "       if error then";
   L_636 : aliased constant String := "          yy_error_report.put (""Error"")"
       & "; --  5 characters for line number.";
   L_637 : aliased constant String := "       else";
   L_638 : aliased constant String := "          yy_error_report.put(""OK   "");";
   L_639 : aliased constant String := "       end if;";
   L_640 : aliased constant String := "";
   L_641 : aliased constant String := "       for i in 1 .. yyparser_input.input"
       & "_token.token_start - 1 loop";
   L_642 : aliased constant String := "          if yyparser_input.input_token.l"
       & "ine (i) = Ascii.ht then";
   L_643 : aliased constant String := "             yy_error_report.put (Ascii.h"
       & "t);";
   L_644 : aliased constant String := "          else";
   L_645 : aliased constant String := "             yy_error_report.put ("" "");";
   L_646 : aliased constant String := "          end if;";
   L_647 : aliased constant String := "       end loop;";
   L_648 : aliased constant String := "       yy_error_report.Put_Line (""^"");";
   L_649 : aliased constant String := "    end flag_token;";
   L_650 : aliased constant String := "";
   L_651 : aliased constant String := "";
   L_652 : aliased constant String := "    procedure print_correction_message (c"
       & "orrection : in correction_type) is";
   L_653 : aliased constant String := "    --";
   L_654 : aliased constant String := "    --  OVERVIEW";
   L_655 : aliased constant String := "    --    This is a local procedure used "
       & "to print out the message";
   L_656 : aliased constant String := "    --    about the correction error reco"
       & "very did.";
   L_657 : aliased constant String := "    --";
   L_658 : aliased constant String := "    begin";
   L_659 : aliased constant String := "       if yy.error_flag > 0 then";
   L_660 : aliased constant String := "          --  We have not seen 3 valid sh"
       & "ift yet, so we";
   L_661 : aliased constant String := "          --  do not need to report this "
       & "error.";
   L_662 : aliased constant String := "          return;";
   L_663 : aliased constant String := "      end if;";
   L_664 : aliased constant String := "";
   L_665 : aliased constant String := "      flag_token;";
   L_666 : aliased constant String := "      case correction.change is";
   L_667 : aliased constant String := "         when delete =>";
   L_668 : aliased constant String := "            yy_error_report.put (""token "
       & "delete "" );";
   L_669 : aliased constant String := "            user_defined_errors.parser_er"
       & "ror (""token delete "" );";
   L_670 : aliased constant String := "";
   L_671 : aliased constant String := "         when replace =>";
   L_672 : aliased constant String := "            yy_error_report.put (""token "
       & "replaced by "" &";
   L_673 : aliased constant String := "                                 yy_token"
       & "s.Token'Image (correction.tokenbox.Token));";
   L_674 : aliased constant String := "            user_defined_errors.parser_er"
       & "ror (""token replaced by "" &";
   L_675 : aliased constant String := "                                         "
       & "     yy_tokens.Token'Image (correction.tokenbox.token));";
   L_676 : aliased constant String := "";
   L_677 : aliased constant String := "         when insert =>";
   L_678 : aliased constant String := "            yy_error_report.put (""insert"
       & "ed token "" &";
   L_679 : aliased constant String := "                                yy_tokens"
       & ".token'Image (correction.tokenbox.token));";
   L_680 : aliased constant String := "            user_defined_errors.parser_er"
       & "ror (""inserted token "" &";
   L_681 : aliased constant String := "                                         "
       & "     yy_tokens.Token'Image (correction.tokenbox.token));";
   L_682 : aliased constant String := "      end case;";
   L_683 : aliased constant String := "";
   L_684 : aliased constant String := "      if yy.debug then";
   L_685 : aliased constant String := "         yy_error_report.Put_Line (""... "
       & "Correction Score is""";
   L_686 : aliased constant String := "                                   & Inte"
       & "ger'Image (correction.score));";
   L_687 : aliased constant String := "      else";
   L_688 : aliased constant String := "         yy_error_report.Put_Line ("""");";
   L_689 : aliased constant String := "      end if;";
   L_690 : aliased constant String := "      yy_error_report.Put_Line ("""");";
   L_691 : aliased constant String := "   end print_correction_message;";
   L_692 : aliased constant String := "";
   L_693 : aliased constant String := "   procedure install_correction (correcti"
       & "on : correction_type) is";
   L_694 : aliased constant String := "       --  This is a local procedure used"
       & " to install the correction.";
   L_695 : aliased constant String := "   begin";
   L_696 : aliased constant String := "      case correction.change is";
   L_697 : aliased constant String := "         when delete  => null;";
   L_698 : aliased constant String := "                          -- Since error "
       & "found for current token,";
   L_699 : aliased constant String := "                          -- no state is "
       & "changed for current token.";
   L_700 : aliased constant String := "                          -- If we resume"
       & " Parser now, Parser will";
   L_701 : aliased constant String := "                          -- try to read "
       & "next token which has the";
   L_702 : aliased constant String := "                          -- affect of ig"
       & "noring current token.";
   L_703 : aliased constant String := "                          -- So for delet"
       & "ing correction, we need to";
   L_704 : aliased constant String := "                          -- do nothing.";
   L_705 : aliased constant String := "         when replace => yyparser_input.u"
       & "nget(correction.tokenbox);";
   L_706 : aliased constant String := "         when insert  => yyparser_input.u"
       & "nget(yyparser_input.input_token);";
   L_707 : aliased constant String := "                         yyparser_input.i"
       & "nput_token := null;";
   L_708 : aliased constant String := "                         yyparser_input.u"
       & "nget(correction.tokenbox);";
   L_709 : aliased constant String := "      end case;";
   L_710 : aliased constant String := "   end install_correction;";
   L_711 : aliased constant String := "";
   L_712 : aliased constant String := "";
   L_713 : aliased constant String := "   function simulate_moves return Integer"
       & " is";
   L_714 : aliased constant String := "   --";
   L_715 : aliased constant String := "    --  OVERVIEW";
   L_716 : aliased constant String := "    --    This is a local procedure simul"
       & "ating the Parser work to";
   L_717 : aliased constant String := "    --    evaluate a potential correction"
       & ". It will look at most";
   L_718 : aliased constant String := "    --    max_forward_moves tokens. It be"
       & "haves very similarly as";
   L_719 : aliased constant String := "    --    the actual Parser except that i"
       & "t does not invoke user";
   L_720 : aliased constant String := "    --    action and it exits when either"
       & " error is found or";
   L_721 : aliased constant String := "    --    the whole input is accepted. Si"
       & "mulate_moves also";
   L_722 : aliased constant String := "    --    collects and returns the score."
       & " Simulate_Moves";
   L_723 : aliased constant String := "    --    do the simulation on the copied"
       & " state stack to";
   L_724 : aliased constant String := "    --    avoid changing the original one"
       & ".";
   L_725 : aliased constant String := "";
   L_726 : aliased constant String := "       --  the score for each valid shift"
       & ".";
   L_727 : aliased constant String := "      shift_increment : constant Integer "
       & ":= 20;";
   L_728 : aliased constant String := "      --  the score for each valid reduce"
       & ".";
   L_729 : aliased constant String := "      reduce_increment : constant Integer"
       & " := 10;";
   L_730 : aliased constant String := "      --  the score for accept action.";
   L_731 : aliased constant String := "      accept_increment : Integer := 14 * "
       & "max_forward_moves;";
   L_732 : aliased constant String := "      --  the decrement for error found.";
   L_733 : aliased constant String := "      error_decrement : Integer := -10 * "
       & "max_forward_moves;";
   L_734 : aliased constant String := "";
   L_735 : aliased constant String := "      --  Indicates how many reduces made"
       & " between last shift";
   L_736 : aliased constant String := "      --  and current shift.";
   L_737 : aliased constant String := "      current_reduces : Integer := 0;";
   L_738 : aliased constant String := "";
   L_739 : aliased constant String := "      --  Indicates how many reduces made"
       & " till now.";
   L_740 : aliased constant String := "      total_reduces : Integer := 0;";
   L_741 : aliased constant String := "";
   L_742 : aliased constant String := "      --  Indicates how many tokens seen "
       & "so far during simulation.";
   L_743 : aliased constant String := "      tokens_seen : Integer := 0;";
   L_744 : aliased constant String := "";
   L_745 : aliased constant String := "      score : Integer := 0; -- the score "
       & "of the simulation.";
   L_746 : aliased constant String := "";
   L_747 : aliased constant String := "      The_Copied_Stack : array (0 .. yy.s"
       & "tack_size) of yy.parse_state;";
   L_748 : aliased constant String := "      The_Copied_Tos   : Integer;";
   L_749 : aliased constant String := "      The_Copied_Input_Token : yyparser_i"
       & "nput.boxed_token;";
   L_750 : aliased constant String := "      Look_Ahead : Boolean := True;";
   L_751 : aliased constant String := "";
   L_752 : aliased constant String := "   begin";
   L_753 : aliased constant String := "";
   L_754 : aliased constant String := "      --  First we copy the state stack.";
   L_755 : aliased constant String := "      for i in 0 .. yy.tos loop";
   L_756 : aliased constant String := "         The_Copied_Stack (i) := yy.state"
       & "_stack (i);";
   L_757 : aliased constant String := "      end loop;";
   L_758 : aliased constant String := "      The_Copied_Tos := yy.tos;";
   L_759 : aliased constant String := "      The_Copied_Input_Token := yyparser_"
       & "input.input_token;";
   L_760 : aliased constant String := "      --  Reset peek_count because each s"
       & "imulation";
   L_761 : aliased constant String := "      --  starts a new process of peeking"
       & ".";
   L_762 : aliased constant String := "      yyparser_input.reset_peek;";
   L_763 : aliased constant String := "";
   L_764 : aliased constant String := "      --  Do the simulation.";
   L_765 : aliased constant String := "      loop";
   L_766 : aliased constant String := "         --  We peek at most max_forward_"
       & "moves tokens during simulation.";
   L_767 : aliased constant String := "         exit when tokens_seen = max_forw"
       & "ard_moves;";
   L_768 : aliased constant String := "";
   L_769 : aliased constant String := "         --  The following codes is very "
       & "similar the codes in Parser.";
   L_770 : aliased constant String := "         yy.index := Shift_Reduce_Offset "
       & "(yy.state_stack (yy.tos));";
   L_771 : aliased constant String := "         if Integer (Shift_Reduce_Matrix "
       & "(yy.index).T) = yy.default then";
   L_772 : aliased constant String := "            yy.action := Integer (Shift_R"
       & "educe_Matrix (yy.index).Act);";
   L_773 : aliased constant String := "         else";
   L_774 : aliased constant String := "            if look_ahead then";
   L_775 : aliased constant String := "               look_ahead := False;";
   L_776 : aliased constant String := "               --  Since it is in simulat"
       & "ion, we peek the token instead of";
   L_777 : aliased constant String := "               --  get the token.";
   L_778 : aliased constant String := "               The_Copied_Input_Token  :="
       & " yyparser_input.peek;";
   L_779 : aliased constant String := "            end if;";
   L_780 : aliased constant String := "            yy.action :=";
   L_781 : aliased constant String := "              parse_action (The_Copied_St"
       & "ack (The_Copied_Tos), The_Copied_Input_Token.token);";
   L_782 : aliased constant String := "         end if;";
   L_783 : aliased constant String := "";
   L_784 : aliased constant String := "         if yy.action >= yy.first_shift_e"
       & "ntry then  -- SHIFT";
   L_785 : aliased constant String := "            if yy.debug then";
   L_786 : aliased constant String := "               shift_debug (yy.action, Th"
       & "e_Copied_Input_Token.token);";
   L_787 : aliased constant String := "            end if;";
   L_788 : aliased constant String := "";
   L_789 : aliased constant String := "            --  Enter new state";
   L_790 : aliased constant String := "            The_Copied_Tos := The_Copied_"
       & "Tos + 1;";
   L_791 : aliased constant String := "            The_Copied_Stack (The_Copied_"
       & "Tos) := yy.action;";
   L_792 : aliased constant String := "";
   L_793 : aliased constant String := "            --  Advance lookahead";
   L_794 : aliased constant String := "            look_ahead := True;";
   L_795 : aliased constant String := "";
   L_796 : aliased constant String := "            score := score + shift_increm"
       & "ent + current_reduces * reduce_increment;";
   L_797 : aliased constant String := "            current_reduces := 0;";
   L_798 : aliased constant String := "            tokens_seen := tokens_seen + "
       & "1;";
   L_799 : aliased constant String := "";
   L_800 : aliased constant String := "         elsif yy.action = yy.error_code "
       & "then       --  ERROR";
   L_801 : aliased constant String := "            score := score - total_reduce"
       & "s * reduce_increment;";
   L_802 : aliased constant String := "            exit; -- exit the loop for si"
       & "mulation.";
   L_803 : aliased constant String := "";
   L_804 : aliased constant String := "         elsif yy.action = yy.accept_code"
       & " then";
   L_805 : aliased constant String := "            score := score + accept_incre"
       & "ment;";
   L_806 : aliased constant String := "            exit; -- exit the loop for si"
       & "mulation.";
   L_807 : aliased constant String := "";
   L_808 : aliased constant String := "         else --  Reduce Action";
   L_809 : aliased constant String := "";
   L_810 : aliased constant String := "            --  Convert action into a rul"
       & "e";
   L_811 : aliased constant String := "            yy.rule_id  := Rule (-1 * yy."
       & "action);";
   L_812 : aliased constant String := "";
   L_813 : aliased constant String := "            --  Don't Execute User Action";
   L_814 : aliased constant String := "";
   L_815 : aliased constant String := "            --  Pop RHS states and goto n"
       & "ext state";
   L_816 : aliased constant String := "            The_Copied_Tos      := The_Co"
       & "pied_Tos - Rule_Length (yy.rule_id) + 1;";
   L_817 : aliased constant String := "            The_Copied_Stack (The_Copied_"
       & "Tos) := goto_state (The_Copied_Stack (The_Copied_Tos - 1) ,";
   L_818 : aliased constant String := "                                 Get_LHS_"
       & "Rule (yy.rule_id));";
   L_819 : aliased constant String := "";
   L_820 : aliased constant String := "            --  Leave value stack alone";
   L_821 : aliased constant String := "";
   L_822 : aliased constant String := "            if yy.debug then";
   L_823 : aliased constant String := "               reduce_debug (yy.rule_id,";
   L_824 : aliased constant String := "                  goto_state (The_Copied_"
       & "Stack (The_Copied_Tos - 1),";
   L_825 : aliased constant String := "                              Get_LHS_Rul"
       & "e (yy.rule_id)));";
   L_826 : aliased constant String := "            end if;";
   L_827 : aliased constant String := "";
   L_828 : aliased constant String := "            --  reduces only credited to "
       & "score when a token can be shifted";
   L_829 : aliased constant String := "            --  but no more than 3 reduce"
       & "s can count between shifts";
   L_830 : aliased constant String := "            current_reduces := current_re"
       & "duces + 1;";
   L_831 : aliased constant String := "            total_reduces := total_reduce"
       & "s + 1;";
   L_832 : aliased constant String := "";
   L_833 : aliased constant String := "         end if;";
   L_834 : aliased constant String := "";
   L_835 : aliased constant String := "      end loop; --  loop for simulation;";
   L_836 : aliased constant String := "";
   L_837 : aliased constant String := "      yyparser_input.reset_peek;";
   L_838 : aliased constant String := "";
   L_839 : aliased constant String := "      return score;";
   L_840 : aliased constant String := "   end simulate_moves;";
   L_841 : aliased constant String := "";
   L_842 : aliased constant String := "";
   L_843 : aliased constant String := "";
   L_844 : aliased constant String := "   procedure primary_recovery (best_corre"
       & "ction : in out correction_type;";
   L_845 : aliased constant String := "                               stop_score"
       & "      : in Integer ) is";
   L_846 : aliased constant String := "    --";
   L_847 : aliased constant String := "    -- OVERVIEW";
   L_848 : aliased constant String := "    --    This is a local procedure used "
       & "by try_recovery. This";
   L_849 : aliased constant String := "    --    procedure will try the followin"
       & "g corrections :";
   L_850 : aliased constant String := "    --      1. Delete current token.";
   L_851 : aliased constant String := "    --      2. Replace current token with"
       & " any token acceptible";
   L_852 : aliased constant String := "    --         from current state, or,";
   L_853 : aliased constant String := "    --         Insert any one of the toke"
       & "ns acceptible from current state.";
   L_854 : aliased constant String := "    --";
   L_855 : aliased constant String := "      token_code      : Integer;";
   L_856 : aliased constant String := "      new_score       : Integer;";
   L_857 : aliased constant String := "      the_boxed_token : yyparser_input.bo"
       & "xed_token;";
   L_858 : aliased constant String := "   begin";
   L_859 : aliased constant String := "";
   L_860 : aliased constant String := "      --  First try to delete current tok"
       & "en.";
   L_861 : aliased constant String := "      if yy.debug then";
   L_862 : aliased constant String := "         yy_error_report.Put_Line (""tryi"
       & "ng to delete """;
   L_863 : aliased constant String := "                                   & yy_t"
       & "okens.token'Image (yyparser_input.input_token.token));";
   L_864 : aliased constant String := "      end if;";
   L_865 : aliased constant String := "";
   L_866 : aliased constant String := "      best_correction.change := delete;";
   L_867 : aliased constant String := "      --  try to evaluate the correction."
       & " NOTE : simulating the Parser";
   L_868 : aliased constant String := "      --  from current state has affect o"
       & "f ignoring current token";
   L_869 : aliased constant String := "      --  because error was found for cur"
       & "rent token and no state";
   L_870 : aliased constant String := "      --  was pushed to state stack.";
   L_871 : aliased constant String := "      best_correction.score := simulate_m"
       & "oves;";
   L_872 : aliased constant String := "      best_correction.tokenbox := null;";
   L_873 : aliased constant String := "";
   L_874 : aliased constant String := "      --  If the score is less than stop_"
       & "score, we try";
   L_875 : aliased constant String := "      --  the 2nd kind of corrections, th"
       & "at is, replace or insert.";
   L_876 : aliased constant String := "      if best_correction.score < stop_sco"
       & "re then";
   L_877 : aliased constant String := "         for i in shift_reduce_offset (yy"
       & ".state_stack (yy.tos)) ..";
   L_878 : aliased constant String := "                 (shift_reduce_offset (yy"
       & ".state_stack (yy.tos) + 1) - 1) loop";
   L_879 : aliased constant String := "            --  We try to use the accepti"
       & "ble token from current state";
   L_880 : aliased constant String := "            --  to replace current token "
       & "or try to insert the acceptible token.";
   L_881 : aliased constant String := "            token_code := Integer (Shift_"
       & "Reduce_Matrix (i).t);";
   L_882 : aliased constant String := "            --  yy.default is not a valid"
       & " token, we must exit.";
   L_883 : aliased constant String := "            exit when token_code = yy.def"
       & "ault;";
   L_884 : aliased constant String := "";
   L_885 : aliased constant String := "            the_boxed_token := yyparser_i"
       & "nput.tbox (yy_tokens.token'val(token_code));";
   L_886 : aliased constant String := "            for change in replace .. inse"
       & "rt loop";
   L_887 : aliased constant String := "               --  We try replacing and t"
       & "he inserting.";
   L_888 : aliased constant String := "               case change is";
   L_889 : aliased constant String := "                  when replace => yyparse"
       & "r_input.unget(the_boxed_token);";
   L_890 : aliased constant String := "                               -- put the"
       & "_boxed_token into the input stream";
   L_891 : aliased constant String := "                               -- has the"
       & " affect of replacing current token";
   L_892 : aliased constant String := "                               -- because"
       & " current token has been retrieved";
   L_893 : aliased constant String := "                               -- but no "
       & "state was change because of the error.";
   L_894 : aliased constant String := "                               if yy.debu"
       & "g then";
   L_895 : aliased constant String := "                                  yy_erro"
       & "r_report.Put_Line (""trying to replace """;
   L_896 : aliased constant String := "                                         "
       & " & yy_tokens.token'Image";
   L_897 : aliased constant String := "                                         "
       & "    (yyparser_input.input_token.token)";
   L_898 : aliased constant String := "                                         "
       & " & "" with """;
   L_899 : aliased constant String := "                                         "
       & " & yy_tokens.token'Image (the_boxed_token.token));";
   L_900 : aliased constant String := "                               end if;";
   L_901 : aliased constant String := "                  when insert  => yyparse"
       & "r_input.unget(yyparser_input.input_token);";
   L_902 : aliased constant String := "                               yyparser_i"
       & "nput.unget(the_boxed_token);";
   L_903 : aliased constant String := "                               if yy.debu"
       & "g then";
   L_904 : aliased constant String := "                                  yy_erro"
       & "r_report.Put_Line (""trying to insert """;
   L_905 : aliased constant String := "                                         "
       & "  & yy_tokens.token'Image (the_boxed_token.token)";
   L_906 : aliased constant String := "                                         "
       & "  & "" before """;
   L_907 : aliased constant String := "                                         "
       & "  & yy_tokens.token'Image (";
   L_908 : aliased constant String := "                                         "
       & "       yyparser_input.input_token.token));";
   L_909 : aliased constant String := "                               end if;";
   L_910 : aliased constant String := "               end case;";
   L_911 : aliased constant String := "";
   L_912 : aliased constant String := "               -- Evaluate the correction"
       & ".";
   L_913 : aliased constant String := "               new_score := simulate_move"
       & "s;";
   L_914 : aliased constant String := "";
   L_915 : aliased constant String := "               if new_score > best_correc"
       & "tion.score then";
   L_916 : aliased constant String := "                  -- We find a higher sco"
       & "re, so we overwrite the old one.";
   L_917 : aliased constant String := "                  best_correction := (cha"
       & "nge, new_score, the_boxed_token);";
   L_918 : aliased constant String := "               end if;";
   L_919 : aliased constant String := "";
   L_920 : aliased constant String := "               -- We have change the inpu"
       & "t stream when we do replacing or";
   L_921 : aliased constant String := "               -- inserting. So we must u"
       & "ndo the affect.";
   L_922 : aliased constant String := "               declare";
   L_923 : aliased constant String := "                  ignore_result : yyparse"
       & "r_input.boxed_token;";
   L_924 : aliased constant String := "               begin";
   L_925 : aliased constant String := "                  case change is";
   L_926 : aliased constant String := "                    when replace => ignor"
       & "e_result := yyparser_input.get;";
   L_927 : aliased constant String := "                    when insert  => ignor"
       & "e_result := yyparser_input.get;";
   L_928 : aliased constant String := "                                    ignor"
       & "e_result := yyparser_input.get;";
   L_929 : aliased constant String := "                  end case;";
   L_930 : aliased constant String := "               end;";
   L_931 : aliased constant String := "";
   L_932 : aliased constant String := "               --  If we got a score high"
       & "er than stop score, we";
   L_933 : aliased constant String := "               --  feel it is good enough"
       & ", so we exit.";
   L_934 : aliased constant String := "               exit when best_correction."
       & "score > stop_score;";
   L_935 : aliased constant String := "";
   L_936 : aliased constant String := "            end loop;  --  change in repl"
       & "ace .. insert";
   L_937 : aliased constant String := "";
   L_938 : aliased constant String := "            --  If we got a score higher "
       & "than stop score, we";
   L_939 : aliased constant String := "            --  feel it is good enough, s"
       & "o we exit.";
   L_940 : aliased constant String := "            exit when best_correction.sco"
       & "re > stop_score;";
   L_941 : aliased constant String := "";
   L_942 : aliased constant String := "         end loop;  --  i in shift_reduce"
       & "_offset...";
   L_943 : aliased constant String := "";
   L_944 : aliased constant String := "      end if; --  best_correction.score <"
       & " stop_score;";
   L_945 : aliased constant String := "";
   L_946 : aliased constant String := "   end primary_recovery;";
   L_947 : aliased constant String := "";
   L_948 : aliased constant String := "";
   L_949 : aliased constant String := "   procedure try_recovery is";
   L_950 : aliased constant String := "    --";
   L_951 : aliased constant String := "    -- OVERVIEW";
   L_952 : aliased constant String := "    --   This is the main procedure doing"
       & " error recovery.";
   L_953 : aliased constant String := "    --   During the process of error reco"
       & "very, we use score to";
   L_954 : aliased constant String := "    --   evaluate the potential correctio"
       & "n. When we try a potential";
   L_955 : aliased constant String := "    --   correction, we will peek some fu"
       & "ture tokens and simulate";
   L_956 : aliased constant String := "    --   the work of Parser. Any valid sh"
       & "ift, reduce or accept action";
   L_957 : aliased constant String := "    --   in the simulation leading from a"
       & " potential correction";
   L_958 : aliased constant String := "    --   will increase the score of the p"
       & "otential correction.";
   L_959 : aliased constant String := "    --   Any error found during the simul"
       & "ation will decrease the";
   L_960 : aliased constant String := "    --   score of the potential correctio"
       & "n and stop the simulation.";
   L_961 : aliased constant String := "    --   Since we limit the number of tok"
       & "ens being peeked, the";
   L_962 : aliased constant String := "    --   simulation will stop no matter w"
       & "hat the correction is.";
   L_963 : aliased constant String := "    --   If the score of a potential corr"
       & "ection is higher enough,";
   L_964 : aliased constant String := "    --   we will accept that correction a"
       & "nd install and let the Parser";
   L_965 : aliased constant String := "    --   continues. During the simulation"
       & ", we will do almost the";
   L_966 : aliased constant String := "    --   same work as the actual Parser d"
       & "oes, except that we do";
   L_967 : aliased constant String := "    --   not invoke any user actions and "
       & "we collect the score.";
   L_968 : aliased constant String := "    --   So we will use the state_stack o"
       & "f the Parser. In order";
   L_969 : aliased constant String := "    --   to avoid change the value of sta"
       & "te_stack, we will make";
   L_970 : aliased constant String := "    --   a copy of the state_stack and th"
       & "e simulation is done";
   L_971 : aliased constant String := "    --   on the copy. Below is the outlin"
       & "e of sequence of corrections";
   L_972 : aliased constant String := "    --   the error recovery algorithm tri"
       & "es:";
   L_973 : aliased constant String := "    --      1. Delete current token.";
   L_974 : aliased constant String := "    --      2. Replace current token with"
       & " any token acceptible";
   L_975 : aliased constant String := "    --         from current state, or,";
   L_976 : aliased constant String := "    --         Insert any one of the toke"
       & "ns acceptible from current state.";
   L_977 : aliased constant String := "    --      3. If previous parser action "
       & "is shift, back up one state,";
   L_978 : aliased constant String := "    --         and try the corrections in"
       & " 1 and 2 again.";
   L_979 : aliased constant String := "    --      4. If none of the scores of t"
       & "he corrections above are highed";
   L_980 : aliased constant String := "    --         enough, we invoke the hand"
       & "le_error in Ayacc.";
   L_981 : aliased constant String := "    --";
   L_982 : aliased constant String := "      correction : correction_type;";
   L_983 : aliased constant String := "      backed_up  : Boolean := False; -- i"
       & "ndicates whether or not we backed up";
   L_984 : aliased constant String := "                                     -- d"
       & "uring error recovery.";
   L_985 : aliased constant String := "      -- scoring : evaluate a potential c"
       & "orrection with a number. high is good";
   L_986 : aliased constant String := "      min_ok_score : constant Integer := "
       & "70;       -- will rellluctantly use";
   L_987 : aliased constant String := "      stop_score   : constant Integer := "
       & "100;      -- this or higher is best.";
   L_988 : aliased constant String := "   begin";
   L_989 : aliased constant String := "";
   L_990 : aliased constant String := "      -- First try recovery without backi"
       & "ng up.";
   L_991 : aliased constant String := "      primary_recovery (correction, stop_"
       & "score);";
   L_992 : aliased constant String := "";
   L_993 : aliased constant String := "      if correction.score < stop_score th"
       & "en";
   L_994 : aliased constant String := "         --  The score of the correction "
       & "is not high enough,";
   L_995 : aliased constant String := "         --  so we try to back up and try"
       & " more corrections.";
   L_996 : aliased constant String := "         --  But we can back up only if p"
       & "revious Parser action";
   L_997 : aliased constant String := "         --  is shift.";
   L_998 : aliased constant String := "         if previous_action >= yy.first_s"
       & "hift_entry then";
   L_999 : aliased constant String := "            --  Previous action is a shif"
       & "t, so we back up.";
   L_1000: aliased constant String := "            backed_up := True;";
   L_1001: aliased constant String := "";
   L_1002: aliased constant String := "            -- we put back the input toke"
       & "n and";
   L_1003: aliased constant String := "            -- roll back the state stack "
       & "and input token.";
   L_1004: aliased constant String := "            yyparser_input.unget (yyparse"
       & "r_input.input_token);";
   L_1005: aliased constant String := "            yyparser_input.input_token :="
       & " yyparser_input.previous_token;";
   L_1006: aliased constant String := "            yy.tos := yy.tos - 1;";
   L_1007: aliased constant String := "";
   L_1008: aliased constant String := "            --  Then we try recovery agai"
       & "n";
   L_1009: aliased constant String := "            primary_recovery (correction,"
       & " stop_score);";
   L_1010: aliased constant String := "         end if;";
   L_1011: aliased constant String := "      end if;  --  correction_score < sto"
       & "p_score";
   L_1012: aliased constant String := "";
   L_1013: aliased constant String := "      --  Now we have try all possible co"
       & "rrection.";
   L_1014: aliased constant String := "      --  The highest score is in correct"
       & "ion.";
   L_1015: aliased constant String := "      if correction.score >= min_ok_score"
       & " then";
   L_1016: aliased constant String := "         --  We accept this correction.";
   L_1017: aliased constant String := "";
   L_1018: aliased constant String := "         --  First, if the input token re"
       & "sides on the different line";
   L_1019: aliased constant String := "         --  of previous token and we hav"
       & "e not backed up, we must";
   L_1020: aliased constant String := "         --  output the new line before w"
       & "e printed the error message.";
   L_1021: aliased constant String := "         --  If we have backed up, we do "
       & "nothing here because";
   L_1022: aliased constant String := "         --  previous line has been outpu"
       & "t.";
   L_1023: aliased constant String := "         if not backed_up and then";
   L_1024: aliased constant String := "            (line_number <";
   L_1025: aliased constant String := "               yyparser_input.input_token"
       & ".line_number ) then";
   L_1026: aliased constant String := "            put_new_line;";
   L_1027: aliased constant String := "            line_number := yyparser_input"
       & ".input_token.line_number;";
   L_1028: aliased constant String := "         end if;";
   L_1029: aliased constant String := "";
   L_1030: aliased constant String := "         print_correction_message(correct"
       & "ion);";
   L_1031: aliased constant String := "         install_correction(correction);";
   L_1032: aliased constant String := "";
   L_1033: aliased constant String := "      else";
   L_1034: aliased constant String := "         --  No score is high enough, we "
       & "try to invoke handle_error";
   L_1035: aliased constant String := "         --  First, if we backed up durin"
       & "g error recovery, we now must";
   L_1036: aliased constant String := "         --  try to undo the affect of ba"
       & "cking up.";
   L_1037: aliased constant String := "         if backed_up then";
   L_1038: aliased constant String := "            yyparser_input.input_token :="
       & " yyparser_input.get;";
   L_1039: aliased constant String := "            yy.tos := yy.tos + 1;";
   L_1040: aliased constant String := "         end if;";
   L_1041: aliased constant String := "";
   L_1042: aliased constant String := "         --  Output the new line if neces"
       & "sary because the";
   L_1043: aliased constant String := "         --  new line has not been output"
       & " yet.";
   L_1044: aliased constant String := "         if line_number <";
   L_1045: aliased constant String := "             yyparser_input.input_token.l"
       & "ine_number then";
   L_1046: aliased constant String := "            put_new_line;";
   L_1047: aliased constant String := "            line_number := yyparser_input"
       & ".input_token.line_number;";
   L_1048: aliased constant String := "         end if;";
   L_1049: aliased constant String := "";
   L_1050: aliased constant String := "         if yy.debug then";
   L_1051: aliased constant String := "            if not backed_up then";
   L_1052: aliased constant String := "               yy_error_report.Put_Line ("
       & """can't back yp over last token..."");";
   L_1053: aliased constant String := "            end if;";
   L_1054: aliased constant String := "            yy_error_report.Put_Line (""1"
       & "st level recovery failed, going to 2nd level..."");";
   L_1055: aliased constant String := "         end if;";
   L_1056: aliased constant String := "";
   L_1057: aliased constant String := "         --  Point out the position of th"
       & "e token on which error occurs.";
   L_1058: aliased constant String := "         flag_token;";
   L_1059: aliased constant String := "";
   L_1060: aliased constant String := "         --  count it as error if it is a"
       & " new error. NOTE : if correction is accepted, total_errors";
   L_1061: aliased constant String := "         --  count will be increase durin"
       & "g error reporting.";
   L_1062: aliased constant String := "         if yy.error_flag = 0 then --  br"
       & "and new error";
   L_1063: aliased constant String := "            yy_error_report.total_errors "
       & ":= yy_error_report.total_errors + 1;";
   L_1064: aliased constant String := "         end if;";
   L_1065: aliased constant String := "";
   L_1066: aliased constant String := "         --  Goes to 2nd level.";
   L_1067: aliased constant String := "         handle_error;";
   L_1068: aliased constant String := "";
   L_1069: aliased constant String := "      end if; --  correction.score >= min"
       & "_ok_score";
   L_1070: aliased constant String := "";
   L_1071: aliased constant String := "      --  No matter what happen, let the "
       & "parser move forward.";
   L_1072: aliased constant String := "      yy.look_ahead := True;";
   L_1073: aliased constant String := "";
   L_1074: aliased constant String := "   end try_recovery;";
   L_1075: aliased constant String := "";
   L_1076: aliased constant String := "";
   L_1077: aliased constant String := "   end yyerror_recovery;";
   L_1078: aliased constant String := "";
   L_1079: aliased constant String := "";
   L_1080: aliased constant String := "-- END OF UMASS CODES.";
   L_1081: aliased constant String := "%end";
   L_1082: aliased constant String := "   begin";
   L_1083: aliased constant String := "      --  initialize by pushing state 0 a"
       & "nd getting the first input symbol";
   L_1084: aliased constant String := "      yy.state_stack (yy.tos) := 0;";
   L_1085: aliased constant String := "      if yy.debug then";
   L_1086: aliased constant String := "         Put_State_Stack;";
   L_1087: aliased constant String := "      end if;";
   L_1088: aliased constant String := "%yyinit";
   L_1089: aliased constant String := "%if error";
   L_1090: aliased constant String := "-- UMASS CODES :";
   L_1091: aliased constant String := "      yy_error_report.Initialize_Output;";
   L_1092: aliased constant String := "      --  initialize input token and prev"
       & "ious token";
   L_1093: aliased constant String := "      yyparser_input.input_token := new y"
       & "yparser_input.tokenbox;";
   L_1094: aliased constant String := "      yyparser_input.input_token.line_num"
       & "ber := 0;";
   L_1095: aliased constant String := "-- END OF UMASS CODES.";
   L_1096: aliased constant String := "%end";
   L_1097: aliased constant String := "";
   L_1098: aliased constant String := "      loop";
   L_1099: aliased constant String := "         yy.index := Shift_Reduce_Offset "
       & "(yy.state_stack (yy.tos));";
   L_1100: aliased constant String := "         if Integer (Shift_Reduce_Matrix "
       & "(yy.index).T) = yy.default then";
   L_1101: aliased constant String := "            yy.action := Integer (Shift_R"
       & "educe_Matrix (yy.index).Act);";
   L_1102: aliased constant String := "         else";
   L_1103: aliased constant String := "            if yy.look_ahead then";
   L_1104: aliased constant String := "               yy.look_ahead := False;";
   L_1105: aliased constant String := "%if error";
   L_1106: aliased constant String := "-- UMASS CODES :";
   L_1107: aliased constant String := "               --  Let Parser get the inp"
       & "ut from yyparser_input instead of lexical";
   L_1108: aliased constant String := "               --  scanner and maintain p"
       & "revious_token and input_token.";
   L_1109: aliased constant String := "               yyparser_input.previous_to"
       & "ken := yyparser_input.input_token;";
   L_1110: aliased constant String := "               yyparser_input.input_token"
       & " := yyparser_input.get;";
   L_1111: aliased constant String := "               yy.input_symbol := yyparse"
       & "r_input.input_token.token;";
   L_1112: aliased constant String := "-- END OF UMASS CODES.";
   L_1113: aliased constant String := "%else";
   L_1114: aliased constant String := "               yy.input_symbol := ${YYLEX"
       & "};";
   L_1115: aliased constant String := "%end";
   L_1116: aliased constant String := "            end if;";
   L_1117: aliased constant String := "            yy.action := parse_action (yy"
       & ".state_stack (yy.tos), yy.input_symbol);";
   L_1118: aliased constant String := "         end if;";
   L_1119: aliased constant String := "";
   L_1120: aliased constant String := "%if error";
   L_1121: aliased constant String := "-- UMASS CODES :";
   L_1122: aliased constant String := "         --   If input_token is not on th"
       & "e line yyerror_recovery.line_number,";
   L_1123: aliased constant String := "         --   we just get to a new line. "
       & "So we output the new line to";
   L_1124: aliased constant String := "         --   file of error report. But i"
       & "f yy.action is error, we";
   L_1125: aliased constant String := "         --   will not output the new lin"
       & "e because we will do error";
   L_1126: aliased constant String := "         --   recovery and during error r"
       & "ecovery, we may back up";
   L_1127: aliased constant String := "         --   which may cause error repor"
       & "ted on previous line.";
   L_1128: aliased constant String := "         --   So if yy.action is error, w"
       & "e will let error recovery";
   L_1129: aliased constant String := "         --   to output the new line.";
   L_1130: aliased constant String := "         if (yyerror_recovery.line_number"
       & " <";
   L_1131: aliased constant String := "             yyparser_input.input_token.l"
       & "ine_number ) and then";
   L_1132: aliased constant String := "            yy.action /= yy.error_code th"
       & "en";
   L_1133: aliased constant String := "            put_new_line;";
   L_1134: aliased constant String := "            yyerror_recovery.line_number "
       & ":= yyparser_input.input_token.line_number;";
   L_1135: aliased constant String := "         end if;";
   L_1136: aliased constant String := "-- END OF UMASS CODES.";
   L_1137: aliased constant String := "%end";
   L_1138: aliased constant String := "";
   L_1139: aliased constant String := "         if yy.action >= yy.first_shift_e"
       & "ntry then  --  SHIFT";
   L_1140: aliased constant String := "";
   L_1141: aliased constant String := "            if yy.debug then";
   L_1142: aliased constant String := "               shift_debug (yy.action, yy"
       & ".input_symbol);";
   L_1143: aliased constant String := "            end if;";
   L_1144: aliased constant String := "";
   L_1145: aliased constant String := "            --  Enter new state";
   L_1146: aliased constant String := "            if yy.tos = yy.stack_size the"
       & "n";
   L_1147: aliased constant String := "               Text_IO.Put_Line ("" Stack"
       & " size exceeded on state_stack"");";
   L_1148: aliased constant String := "               raise yy_tokens.Syntax_Err"
       & "or;";
   L_1149: aliased constant String := "            end if;";
   L_1150: aliased constant String := "            yy.tos                  := yy"
       & ".tos + 1;";
   L_1151: aliased constant String := "            yy.state_stack (yy.tos) := yy"
       & ".action;";
   L_1152: aliased constant String := "%if error";
   L_1153: aliased constant String := "-- UMASS CODES :";
   L_1154: aliased constant String := "            --   Set value stack only if "
       & "valuing is True.";
   L_1155: aliased constant String := "            if yyerror_recovery.valuing t"
       & "hen";
   L_1156: aliased constant String := "-- END OF UMASS CODES.";
   L_1157: aliased constant String := "%end";
   L_1158: aliased constant String := "            yy.value_stack (yy.tos) := YY"
       & "LVal;";
   L_1159: aliased constant String := "%if error";
   L_1160: aliased constant String := "-- UMASS CODES :";
   L_1161: aliased constant String := "            end if;";
   L_1162: aliased constant String := "-- END OF UMASS CODES.";
   L_1163: aliased constant String := "%end";
   L_1164: aliased constant String := "            if yy.debug then";
   L_1165: aliased constant String := "               Put_State_Stack;";
   L_1166: aliased constant String := "            end if;";
   L_1167: aliased constant String := "";
   L_1168: aliased constant String := "            if yy.error_flag > 0 then  --"
       & "  indicate a valid shift";
   L_1169: aliased constant String := "               yy.error_flag := yy.error_"
       & "flag - 1;";
   L_1170: aliased constant String := "            end if;";
   L_1171: aliased constant String := "";
   L_1172: aliased constant String := "            --  Advance lookahead";
   L_1173: aliased constant String := "            yy.look_ahead := True;";
   L_1174: aliased constant String := "";
   L_1175: aliased constant String := "         elsif yy.action = yy.error_code "
       & "then       -- ERROR";
   L_1176: aliased constant String := "%if error";
   L_1177: aliased constant String := "-- UMASS CODES :";
   L_1178: aliased constant String := "            try_recovery;";
   L_1179: aliased constant String := "-- END OF UMASS CODES.";
   L_1180: aliased constant String := "%else";
   L_1181: aliased constant String := "            handle_error;";
   L_1182: aliased constant String := "%end";
   L_1183: aliased constant String := "";
   L_1184: aliased constant String := "         elsif yy.action = yy.accept_code"
       & " then";
   L_1185: aliased constant String := "            if yy.debug then";
   L_1186: aliased constant String := "               Text_IO.Put_Line (""  --  "
       & "Ayacc.YYParse: Accepting Grammar..."");";
   L_1187: aliased constant String := "%if error";
   L_1188: aliased constant String := "-- UMASS CODES :";
   L_1189: aliased constant String := "               yy_error_report.Put_Line ("
       & """Ayacc.YYParse: Accepting Grammar..."");";
   L_1190: aliased constant String := "-- END OF UMASS CODES.";
   L_1191: aliased constant String := "%end";
   L_1192: aliased constant String := "            end if;";
   L_1193: aliased constant String := "            exit;";
   L_1194: aliased constant String := "";
   L_1195: aliased constant String := "         else --  Reduce Action";
   L_1196: aliased constant String := "";
   L_1197: aliased constant String := "            --  Convert action into a rul"
       & "e";
   L_1198: aliased constant String := "            yy.rule_id := Rule (-1 * yy.a"
       & "ction);";
   L_1199: aliased constant String := "";
   L_1200: aliased constant String := "            --  Execute User Action";
   L_1201: aliased constant String := "            --  user_action(yy.rule_id);";
   L_1202: aliased constant String := "%if error";
   L_1203: aliased constant String := "-- UMASS CODES :";
   L_1204: aliased constant String := "";
   L_1205: aliased constant String := "            --   Only invoke semantic act"
       & "ion if valuing is True.";
   L_1206: aliased constant String := "            --   And if exception is rais"
       & "ed during semantic action";
   L_1207: aliased constant String := "            --   and total_errors is not "
       & "zero, we set valuing to False";
   L_1208: aliased constant String := "            --   because we assume that e"
       & "rror recovery causes the exception";
   L_1209: aliased constant String := "            --   and we no longer want to"
       & " invoke any semantic action.";
   L_1210: aliased constant String := "            if yyerror_recovery.valuing t"
       & "hen";
   L_1211: aliased constant String := "               begin";
   L_1212: aliased constant String := "-- END OF UMASS CODES.";
   L_1213: aliased constant String := "%end";
   L_1214: aliased constant String := "            case yy.rule_id is";
   L_1215: aliased constant String := "               pragma Style_Checks (Off);";
   L_1216: aliased constant String := "%%4 rules";
   L_1217: aliased constant String := "               pragma Style_Checks (On);";
   L_1218: aliased constant String := "";
   L_1219: aliased constant String := "               when others => null;";
   L_1220: aliased constant String := "            end case;";
   L_1221: aliased constant String := "";
   L_1222: aliased constant String := "%if error";
   L_1223: aliased constant String := "-- UMASS CODES :";
   L_1224: aliased constant String := "            --   Corresponding to the cod"
       & "es above.";
   L_1225: aliased constant String := "            exception";
   L_1226: aliased constant String := "               when others =>";
   L_1227: aliased constant String := "                  if yy_error_report.tota"
       & "l_errors > 0 then";
   L_1228: aliased constant String := "                     yyerror_recovery.val"
       & "uing := False;";
   L_1229: aliased constant String := "                     --  We no longer wan"
       & "t to invoke any semantic action.";
   L_1230: aliased constant String := "                  else";
   L_1231: aliased constant String := "                     --  this exception i"
       & "s not caused by syntax error,";
   L_1232: aliased constant String := "                     --  so we reraise an"
       & "yway.";
   L_1233: aliased constant String := "                     yy_error_report.Fini"
       & "sh_Output;";
   L_1234: aliased constant String := "                     raise;";
   L_1235: aliased constant String := "                  end if;";
   L_1236: aliased constant String := "            end;";
   L_1237: aliased constant String := "            end if;";
   L_1238: aliased constant String := "";
   L_1239: aliased constant String := "-- END OF UMASS CODES.";
   L_1240: aliased constant String := "%end";
   L_1241: aliased constant String := "            --  Pop RHS states and goto n"
       & "ext state";
   L_1242: aliased constant String := "            yy.tos := yy.tos - Rule_Lengt"
       & "h (yy.rule_id) + 1;";
   L_1243: aliased constant String := "            if yy.tos > yy.stack_size the"
       & "n";
   L_1244: aliased constant String := "               Text_IO.Put_Line ("" Stack"
       & " size exceeded on state_stack"");";
   L_1245: aliased constant String := "%if error";
   L_1246: aliased constant String := "-- UMASS CODES :";
   L_1247: aliased constant String := "               yy_error_report.Put_Line ("
       & """ Stack size exceeded on state_stack"");";
   L_1248: aliased constant String := "               yyerror_recovery.finale;";
   L_1249: aliased constant String := "-- END OF UMASS CODES.";
   L_1250: aliased constant String := "%end";
   L_1251: aliased constant String := "               raise yy_tokens.Syntax_Err"
       & "or;";
   L_1252: aliased constant String := "            end if;";
   L_1253: aliased constant String := "            yy.state_stack (yy.tos) := go"
       & "to_state (yy.state_stack (yy.tos - 1),";
   L_1254: aliased constant String := "                                         "
       & "          Get_LHS_Rule (yy.rule_id));";
   L_1255: aliased constant String := "%if error";
   L_1256: aliased constant String := "-- UMASS CODES :";
   L_1257: aliased constant String := "            --   Set value stack only if "
       & "valuing is True.";
   L_1258: aliased constant String := "            if yyerror_recovery.valuing t"
       & "hen";
   L_1259: aliased constant String := "-- END OF UMASS CODES.";
   L_1260: aliased constant String := "%end";
   L_1261: aliased constant String := "";
   L_1262: aliased constant String := "            yy.value_stack (yy.tos) := YY"
       & "Val;";
   L_1263: aliased constant String := "%if error";
   L_1264: aliased constant String := "-- UMASS CODES :";
   L_1265: aliased constant String := "            end if;";
   L_1266: aliased constant String := "-- END OF UMASS CODES.";
   L_1267: aliased constant String := "%end";
   L_1268: aliased constant String := "            if yy.debug then";
   L_1269: aliased constant String := "               reduce_debug (yy.rule_id,";
   L_1270: aliased constant String := "                  goto_state (yy.state_st"
       & "ack (yy.tos - 1),";
   L_1271: aliased constant String := "                              Get_LHS_Rul"
       & "e (yy.rule_id)));";
   L_1272: aliased constant String := "               Put_State_Stack;";
   L_1273: aliased constant String := "            end if;";
   L_1274: aliased constant String := "";
   L_1275: aliased constant String := "         end if;";
   L_1276: aliased constant String := "%if error";
   L_1277: aliased constant String := "-- UMASS CODES :";
   L_1278: aliased constant String := "";
   L_1279: aliased constant String := "        --  If the error flag is set to z"
       & "ero at current token,";
   L_1280: aliased constant String := "        --  we flag current token out.";
   L_1281: aliased constant String := "        if yyerror_recovery.previous_erro"
       & "r_flag > 0 and then";
   L_1282: aliased constant String := "           yy.error_flag = 0 then";
   L_1283: aliased constant String := "           yyerror_recovery.flag_token (e"
       & "rror => False);";
   L_1284: aliased constant String := "        end if;";
   L_1285: aliased constant String := "";
   L_1286: aliased constant String := "        --   save the action made and err"
       & "or flag.";
   L_1287: aliased constant String := "        yyerror_recovery.previous_action "
       & ":= yy.action;";
   L_1288: aliased constant String := "        yyerror_recovery.previous_error_f"
       & "lag := yy.error_flag;";
   L_1289: aliased constant String := "-- END OF UMASS CODES.";
   L_1290: aliased constant String := "%end";
   L_1291: aliased constant String := "      end loop;";
   L_1292: aliased constant String := "";
   L_1293: aliased constant String := "   end ${YYPARSE};";
   body_ayacc : aliased constant Content_Array :=
     (L_1'Access,
      L_2'Access,
      L_3'Access,
      L_4'Access,
      L_5'Access,
      L_6'Access,
      L_7'Access,
      L_8'Access,
      L_9'Access,
      L_10'Access,
      L_11'Access,
      L_12'Access,
      L_13'Access,
      L_14'Access,
      L_15'Access,
      L_16'Access,
      L_17'Access,
      L_18'Access,
      L_19'Access,
      L_20'Access,
      L_21'Access,
      L_22'Access,
      L_23'Access,
      L_24'Access,
      L_25'Access,
      L_26'Access,
      L_27'Access,
      L_28'Access,
      L_29'Access,
      L_30'Access,
      L_31'Access,
      L_32'Access,
      L_33'Access,
      L_34'Access,
      L_35'Access,
      L_36'Access,
      L_37'Access,
      L_38'Access,
      L_39'Access,
      L_40'Access,
      L_41'Access,
      L_42'Access,
      L_43'Access,
      L_44'Access,
      L_45'Access,
      L_46'Access,
      L_47'Access,
      L_48'Access,
      L_49'Access,
      L_50'Access,
      L_51'Access,
      L_52'Access,
      L_53'Access,
      L_54'Access,
      L_55'Access,
      L_56'Access,
      L_57'Access,
      L_58'Access,
      L_59'Access,
      L_60'Access,
      L_61'Access,
      L_62'Access,
      L_63'Access,
      L_64'Access,
      L_65'Access,
      L_66'Access,
      L_67'Access,
      L_68'Access,
      L_69'Access,
      L_70'Access,
      L_71'Access,
      L_72'Access,
      L_73'Access,
      L_74'Access,
      L_75'Access,
      L_76'Access,
      L_77'Access,
      L_78'Access,
      L_79'Access,
      L_80'Access,
      L_81'Access,
      L_82'Access,
      L_83'Access,
      L_84'Access,
      L_85'Access,
      L_86'Access,
      L_87'Access,
      L_88'Access,
      L_89'Access,
      L_90'Access,
      L_91'Access,
      L_92'Access,
      L_93'Access,
      L_94'Access,
      L_95'Access,
      L_96'Access,
      L_97'Access,
      L_98'Access,
      L_99'Access,
      L_100'Access,
      L_101'Access,
      L_102'Access,
      L_103'Access,
      L_104'Access,
      L_105'Access,
      L_106'Access,
      L_107'Access,
      L_108'Access,
      L_109'Access,
      L_110'Access,
      L_111'Access,
      L_112'Access,
      L_113'Access,
      L_114'Access,
      L_115'Access,
      L_116'Access,
      L_117'Access,
      L_118'Access,
      L_119'Access,
      L_120'Access,
      L_121'Access,
      L_122'Access,
      L_123'Access,
      L_124'Access,
      L_125'Access,
      L_126'Access,
      L_127'Access,
      L_128'Access,
      L_129'Access,
      L_130'Access,
      L_131'Access,
      L_132'Access,
      L_133'Access,
      L_134'Access,
      L_135'Access,
      L_136'Access,
      L_137'Access,
      L_138'Access,
      L_139'Access,
      L_140'Access,
      L_141'Access,
      L_142'Access,
      L_143'Access,
      L_144'Access,
      L_145'Access,
      L_146'Access,
      L_147'Access,
      L_148'Access,
      L_149'Access,
      L_150'Access,
      L_151'Access,
      L_152'Access,
      L_153'Access,
      L_154'Access,
      L_155'Access,
      L_156'Access,
      L_157'Access,
      L_158'Access,
      L_159'Access,
      L_160'Access,
      L_161'Access,
      L_162'Access,
      L_163'Access,
      L_164'Access,
      L_165'Access,
      L_166'Access,
      L_167'Access,
      L_168'Access,
      L_169'Access,
      L_170'Access,
      L_171'Access,
      L_172'Access,
      L_173'Access,
      L_174'Access,
      L_175'Access,
      L_176'Access,
      L_177'Access,
      L_178'Access,
      L_179'Access,
      L_180'Access,
      L_181'Access,
      L_182'Access,
      L_183'Access,
      L_184'Access,
      L_185'Access,
      L_186'Access,
      L_187'Access,
      L_188'Access,
      L_189'Access,
      L_190'Access,
      L_191'Access,
      L_192'Access,
      L_193'Access,
      L_194'Access,
      L_195'Access,
      L_196'Access,
      L_197'Access,
      L_198'Access,
      L_199'Access,
      L_200'Access,
      L_201'Access,
      L_202'Access,
      L_203'Access,
      L_204'Access,
      L_205'Access,
      L_206'Access,
      L_207'Access,
      L_208'Access,
      L_209'Access,
      L_210'Access,
      L_211'Access,
      L_212'Access,
      L_213'Access,
      L_214'Access,
      L_215'Access,
      L_216'Access,
      L_217'Access,
      L_218'Access,
      L_219'Access,
      L_220'Access,
      L_221'Access,
      L_222'Access,
      L_223'Access,
      L_224'Access,
      L_225'Access,
      L_226'Access,
      L_227'Access,
      L_228'Access,
      L_229'Access,
      L_230'Access,
      L_231'Access,
      L_232'Access,
      L_233'Access,
      L_234'Access,
      L_235'Access,
      L_236'Access,
      L_237'Access,
      L_238'Access,
      L_239'Access,
      L_240'Access,
      L_241'Access,
      L_242'Access,
      L_243'Access,
      L_244'Access,
      L_245'Access,
      L_246'Access,
      L_247'Access,
      L_248'Access,
      L_249'Access,
      L_250'Access,
      L_251'Access,
      L_252'Access,
      L_253'Access,
      L_254'Access,
      L_255'Access,
      L_256'Access,
      L_257'Access,
      L_258'Access,
      L_259'Access,
      L_260'Access,
      L_261'Access,
      L_262'Access,
      L_263'Access,
      L_264'Access,
      L_265'Access,
      L_266'Access,
      L_267'Access,
      L_268'Access,
      L_269'Access,
      L_270'Access,
      L_271'Access,
      L_272'Access,
      L_273'Access,
      L_274'Access,
      L_275'Access,
      L_276'Access,
      L_277'Access,
      L_278'Access,
      L_279'Access,
      L_280'Access,
      L_281'Access,
      L_282'Access,
      L_283'Access,
      L_284'Access,
      L_285'Access,
      L_286'Access,
      L_287'Access,
      L_288'Access,
      L_289'Access,
      L_290'Access,
      L_291'Access,
      L_292'Access,
      L_293'Access,
      L_294'Access,
      L_295'Access,
      L_296'Access,
      L_297'Access,
      L_298'Access,
      L_299'Access,
      L_300'Access,
      L_301'Access,
      L_302'Access,
      L_303'Access,
      L_304'Access,
      L_305'Access,
      L_306'Access,
      L_307'Access,
      L_308'Access,
      L_309'Access,
      L_310'Access,
      L_311'Access,
      L_312'Access,
      L_313'Access,
      L_314'Access,
      L_315'Access,
      L_316'Access,
      L_317'Access,
      L_318'Access,
      L_319'Access,
      L_320'Access,
      L_321'Access,
      L_322'Access,
      L_323'Access,
      L_324'Access,
      L_325'Access,
      L_326'Access,
      L_327'Access,
      L_328'Access,
      L_329'Access,
      L_330'Access,
      L_331'Access,
      L_332'Access,
      L_333'Access,
      L_334'Access,
      L_335'Access,
      L_336'Access,
      L_337'Access,
      L_338'Access,
      L_339'Access,
      L_340'Access,
      L_341'Access,
      L_342'Access,
      L_343'Access,
      L_344'Access,
      L_345'Access,
      L_346'Access,
      L_347'Access,
      L_348'Access,
      L_349'Access,
      L_350'Access,
      L_351'Access,
      L_352'Access,
      L_353'Access,
      L_354'Access,
      L_355'Access,
      L_356'Access,
      L_357'Access,
      L_358'Access,
      L_359'Access,
      L_360'Access,
      L_361'Access,
      L_362'Access,
      L_363'Access,
      L_364'Access,
      L_365'Access,
      L_366'Access,
      L_367'Access,
      L_368'Access,
      L_369'Access,
      L_370'Access,
      L_371'Access,
      L_372'Access,
      L_373'Access,
      L_374'Access,
      L_375'Access,
      L_376'Access,
      L_377'Access,
      L_378'Access,
      L_379'Access,
      L_380'Access,
      L_381'Access,
      L_382'Access,
      L_383'Access,
      L_384'Access,
      L_385'Access,
      L_386'Access,
      L_387'Access,
      L_388'Access,
      L_389'Access,
      L_390'Access,
      L_391'Access,
      L_392'Access,
      L_393'Access,
      L_394'Access,
      L_395'Access,
      L_396'Access,
      L_397'Access,
      L_398'Access,
      L_399'Access,
      L_400'Access,
      L_401'Access,
      L_402'Access,
      L_403'Access,
      L_404'Access,
      L_405'Access,
      L_406'Access,
      L_407'Access,
      L_408'Access,
      L_409'Access,
      L_410'Access,
      L_411'Access,
      L_412'Access,
      L_413'Access,
      L_414'Access,
      L_415'Access,
      L_416'Access,
      L_417'Access,
      L_418'Access,
      L_419'Access,
      L_420'Access,
      L_421'Access,
      L_422'Access,
      L_423'Access,
      L_424'Access,
      L_425'Access,
      L_426'Access,
      L_427'Access,
      L_428'Access,
      L_429'Access,
      L_430'Access,
      L_431'Access,
      L_432'Access,
      L_433'Access,
      L_434'Access,
      L_435'Access,
      L_436'Access,
      L_437'Access,
      L_438'Access,
      L_439'Access,
      L_440'Access,
      L_441'Access,
      L_442'Access,
      L_443'Access,
      L_444'Access,
      L_445'Access,
      L_446'Access,
      L_447'Access,
      L_448'Access,
      L_449'Access,
      L_450'Access,
      L_451'Access,
      L_452'Access,
      L_453'Access,
      L_454'Access,
      L_455'Access,
      L_456'Access,
      L_457'Access,
      L_458'Access,
      L_459'Access,
      L_460'Access,
      L_461'Access,
      L_462'Access,
      L_463'Access,
      L_464'Access,
      L_465'Access,
      L_466'Access,
      L_467'Access,
      L_468'Access,
      L_469'Access,
      L_470'Access,
      L_471'Access,
      L_472'Access,
      L_473'Access,
      L_474'Access,
      L_475'Access,
      L_476'Access,
      L_477'Access,
      L_478'Access,
      L_479'Access,
      L_480'Access,
      L_481'Access,
      L_482'Access,
      L_483'Access,
      L_484'Access,
      L_485'Access,
      L_486'Access,
      L_487'Access,
      L_488'Access,
      L_489'Access,
      L_490'Access,
      L_491'Access,
      L_492'Access,
      L_493'Access,
      L_494'Access,
      L_495'Access,
      L_496'Access,
      L_497'Access,
      L_498'Access,
      L_499'Access,
      L_500'Access,
      L_501'Access,
      L_502'Access,
      L_503'Access,
      L_504'Access,
      L_505'Access,
      L_506'Access,
      L_507'Access,
      L_508'Access,
      L_509'Access,
      L_510'Access,
      L_511'Access,
      L_512'Access,
      L_513'Access,
      L_514'Access,
      L_515'Access,
      L_516'Access,
      L_517'Access,
      L_518'Access,
      L_519'Access,
      L_520'Access,
      L_521'Access,
      L_522'Access,
      L_523'Access,
      L_524'Access,
      L_525'Access,
      L_526'Access,
      L_527'Access,
      L_528'Access,
      L_529'Access,
      L_530'Access,
      L_531'Access,
      L_532'Access,
      L_533'Access,
      L_534'Access,
      L_535'Access,
      L_536'Access,
      L_537'Access,
      L_538'Access,
      L_539'Access,
      L_540'Access,
      L_541'Access,
      L_542'Access,
      L_543'Access,
      L_544'Access,
      L_545'Access,
      L_546'Access,
      L_547'Access,
      L_548'Access,
      L_549'Access,
      L_550'Access,
      L_551'Access,
      L_552'Access,
      L_553'Access,
      L_554'Access,
      L_555'Access,
      L_556'Access,
      L_557'Access,
      L_558'Access,
      L_559'Access,
      L_560'Access,
      L_561'Access,
      L_562'Access,
      L_563'Access,
      L_564'Access,
      L_565'Access,
      L_566'Access,
      L_567'Access,
      L_568'Access,
      L_569'Access,
      L_570'Access,
      L_571'Access,
      L_572'Access,
      L_573'Access,
      L_574'Access,
      L_575'Access,
      L_576'Access,
      L_577'Access,
      L_578'Access,
      L_579'Access,
      L_580'Access,
      L_581'Access,
      L_582'Access,
      L_583'Access,
      L_584'Access,
      L_585'Access,
      L_586'Access,
      L_587'Access,
      L_588'Access,
      L_589'Access,
      L_590'Access,
      L_591'Access,
      L_592'Access,
      L_593'Access,
      L_594'Access,
      L_595'Access,
      L_596'Access,
      L_597'Access,
      L_598'Access,
      L_599'Access,
      L_600'Access,
      L_601'Access,
      L_602'Access,
      L_603'Access,
      L_604'Access,
      L_605'Access,
      L_606'Access,
      L_607'Access,
      L_608'Access,
      L_609'Access,
      L_610'Access,
      L_611'Access,
      L_612'Access,
      L_613'Access,
      L_614'Access,
      L_615'Access,
      L_616'Access,
      L_617'Access,
      L_618'Access,
      L_619'Access,
      L_620'Access,
      L_621'Access,
      L_622'Access,
      L_623'Access,
      L_624'Access,
      L_625'Access,
      L_626'Access,
      L_627'Access,
      L_628'Access,
      L_629'Access,
      L_630'Access,
      L_631'Access,
      L_632'Access,
      L_633'Access,
      L_634'Access,
      L_635'Access,
      L_636'Access,
      L_637'Access,
      L_638'Access,
      L_639'Access,
      L_640'Access,
      L_641'Access,
      L_642'Access,
      L_643'Access,
      L_644'Access,
      L_645'Access,
      L_646'Access,
      L_647'Access,
      L_648'Access,
      L_649'Access,
      L_650'Access,
      L_651'Access,
      L_652'Access,
      L_653'Access,
      L_654'Access,
      L_655'Access,
      L_656'Access,
      L_657'Access,
      L_658'Access,
      L_659'Access,
      L_660'Access,
      L_661'Access,
      L_662'Access,
      L_663'Access,
      L_664'Access,
      L_665'Access,
      L_666'Access,
      L_667'Access,
      L_668'Access,
      L_669'Access,
      L_670'Access,
      L_671'Access,
      L_672'Access,
      L_673'Access,
      L_674'Access,
      L_675'Access,
      L_676'Access,
      L_677'Access,
      L_678'Access,
      L_679'Access,
      L_680'Access,
      L_681'Access,
      L_682'Access,
      L_683'Access,
      L_684'Access,
      L_685'Access,
      L_686'Access,
      L_687'Access,
      L_688'Access,
      L_689'Access,
      L_690'Access,
      L_691'Access,
      L_692'Access,
      L_693'Access,
      L_694'Access,
      L_695'Access,
      L_696'Access,
      L_697'Access,
      L_698'Access,
      L_699'Access,
      L_700'Access,
      L_701'Access,
      L_702'Access,
      L_703'Access,
      L_704'Access,
      L_705'Access,
      L_706'Access,
      L_707'Access,
      L_708'Access,
      L_709'Access,
      L_710'Access,
      L_711'Access,
      L_712'Access,
      L_713'Access,
      L_714'Access,
      L_715'Access,
      L_716'Access,
      L_717'Access,
      L_718'Access,
      L_719'Access,
      L_720'Access,
      L_721'Access,
      L_722'Access,
      L_723'Access,
      L_724'Access,
      L_725'Access,
      L_726'Access,
      L_727'Access,
      L_728'Access,
      L_729'Access,
      L_730'Access,
      L_731'Access,
      L_732'Access,
      L_733'Access,
      L_734'Access,
      L_735'Access,
      L_736'Access,
      L_737'Access,
      L_738'Access,
      L_739'Access,
      L_740'Access,
      L_741'Access,
      L_742'Access,
      L_743'Access,
      L_744'Access,
      L_745'Access,
      L_746'Access,
      L_747'Access,
      L_748'Access,
      L_749'Access,
      L_750'Access,
      L_751'Access,
      L_752'Access,
      L_753'Access,
      L_754'Access,
      L_755'Access,
      L_756'Access,
      L_757'Access,
      L_758'Access,
      L_759'Access,
      L_760'Access,
      L_761'Access,
      L_762'Access,
      L_763'Access,
      L_764'Access,
      L_765'Access,
      L_766'Access,
      L_767'Access,
      L_768'Access,
      L_769'Access,
      L_770'Access,
      L_771'Access,
      L_772'Access,
      L_773'Access,
      L_774'Access,
      L_775'Access,
      L_776'Access,
      L_777'Access,
      L_778'Access,
      L_779'Access,
      L_780'Access,
      L_781'Access,
      L_782'Access,
      L_783'Access,
      L_784'Access,
      L_785'Access,
      L_786'Access,
      L_787'Access,
      L_788'Access,
      L_789'Access,
      L_790'Access,
      L_791'Access,
      L_792'Access,
      L_793'Access,
      L_794'Access,
      L_795'Access,
      L_796'Access,
      L_797'Access,
      L_798'Access,
      L_799'Access,
      L_800'Access,
      L_801'Access,
      L_802'Access,
      L_803'Access,
      L_804'Access,
      L_805'Access,
      L_806'Access,
      L_807'Access,
      L_808'Access,
      L_809'Access,
      L_810'Access,
      L_811'Access,
      L_812'Access,
      L_813'Access,
      L_814'Access,
      L_815'Access,
      L_816'Access,
      L_817'Access,
      L_818'Access,
      L_819'Access,
      L_820'Access,
      L_821'Access,
      L_822'Access,
      L_823'Access,
      L_824'Access,
      L_825'Access,
      L_826'Access,
      L_827'Access,
      L_828'Access,
      L_829'Access,
      L_830'Access,
      L_831'Access,
      L_832'Access,
      L_833'Access,
      L_834'Access,
      L_835'Access,
      L_836'Access,
      L_837'Access,
      L_838'Access,
      L_839'Access,
      L_840'Access,
      L_841'Access,
      L_842'Access,
      L_843'Access,
      L_844'Access,
      L_845'Access,
      L_846'Access,
      L_847'Access,
      L_848'Access,
      L_849'Access,
      L_850'Access,
      L_851'Access,
      L_852'Access,
      L_853'Access,
      L_854'Access,
      L_855'Access,
      L_856'Access,
      L_857'Access,
      L_858'Access,
      L_859'Access,
      L_860'Access,
      L_861'Access,
      L_862'Access,
      L_863'Access,
      L_864'Access,
      L_865'Access,
      L_866'Access,
      L_867'Access,
      L_868'Access,
      L_869'Access,
      L_870'Access,
      L_871'Access,
      L_872'Access,
      L_873'Access,
      L_874'Access,
      L_875'Access,
      L_876'Access,
      L_877'Access,
      L_878'Access,
      L_879'Access,
      L_880'Access,
      L_881'Access,
      L_882'Access,
      L_883'Access,
      L_884'Access,
      L_885'Access,
      L_886'Access,
      L_887'Access,
      L_888'Access,
      L_889'Access,
      L_890'Access,
      L_891'Access,
      L_892'Access,
      L_893'Access,
      L_894'Access,
      L_895'Access,
      L_896'Access,
      L_897'Access,
      L_898'Access,
      L_899'Access,
      L_900'Access,
      L_901'Access,
      L_902'Access,
      L_903'Access,
      L_904'Access,
      L_905'Access,
      L_906'Access,
      L_907'Access,
      L_908'Access,
      L_909'Access,
      L_910'Access,
      L_911'Access,
      L_912'Access,
      L_913'Access,
      L_914'Access,
      L_915'Access,
      L_916'Access,
      L_917'Access,
      L_918'Access,
      L_919'Access,
      L_920'Access,
      L_921'Access,
      L_922'Access,
      L_923'Access,
      L_924'Access,
      L_925'Access,
      L_926'Access,
      L_927'Access,
      L_928'Access,
      L_929'Access,
      L_930'Access,
      L_931'Access,
      L_932'Access,
      L_933'Access,
      L_934'Access,
      L_935'Access,
      L_936'Access,
      L_937'Access,
      L_938'Access,
      L_939'Access,
      L_940'Access,
      L_941'Access,
      L_942'Access,
      L_943'Access,
      L_944'Access,
      L_945'Access,
      L_946'Access,
      L_947'Access,
      L_948'Access,
      L_949'Access,
      L_950'Access,
      L_951'Access,
      L_952'Access,
      L_953'Access,
      L_954'Access,
      L_955'Access,
      L_956'Access,
      L_957'Access,
      L_958'Access,
      L_959'Access,
      L_960'Access,
      L_961'Access,
      L_962'Access,
      L_963'Access,
      L_964'Access,
      L_965'Access,
      L_966'Access,
      L_967'Access,
      L_968'Access,
      L_969'Access,
      L_970'Access,
      L_971'Access,
      L_972'Access,
      L_973'Access,
      L_974'Access,
      L_975'Access,
      L_976'Access,
      L_977'Access,
      L_978'Access,
      L_979'Access,
      L_980'Access,
      L_981'Access,
      L_982'Access,
      L_983'Access,
      L_984'Access,
      L_985'Access,
      L_986'Access,
      L_987'Access,
      L_988'Access,
      L_989'Access,
      L_990'Access,
      L_991'Access,
      L_992'Access,
      L_993'Access,
      L_994'Access,
      L_995'Access,
      L_996'Access,
      L_997'Access,
      L_998'Access,
      L_999'Access,
      L_1000'Access,
      L_1001'Access,
      L_1002'Access,
      L_1003'Access,
      L_1004'Access,
      L_1005'Access,
      L_1006'Access,
      L_1007'Access,
      L_1008'Access,
      L_1009'Access,
      L_1010'Access,
      L_1011'Access,
      L_1012'Access,
      L_1013'Access,
      L_1014'Access,
      L_1015'Access,
      L_1016'Access,
      L_1017'Access,
      L_1018'Access,
      L_1019'Access,
      L_1020'Access,
      L_1021'Access,
      L_1022'Access,
      L_1023'Access,
      L_1024'Access,
      L_1025'Access,
      L_1026'Access,
      L_1027'Access,
      L_1028'Access,
      L_1029'Access,
      L_1030'Access,
      L_1031'Access,
      L_1032'Access,
      L_1033'Access,
      L_1034'Access,
      L_1035'Access,
      L_1036'Access,
      L_1037'Access,
      L_1038'Access,
      L_1039'Access,
      L_1040'Access,
      L_1041'Access,
      L_1042'Access,
      L_1043'Access,
      L_1044'Access,
      L_1045'Access,
      L_1046'Access,
      L_1047'Access,
      L_1048'Access,
      L_1049'Access,
      L_1050'Access,
      L_1051'Access,
      L_1052'Access,
      L_1053'Access,
      L_1054'Access,
      L_1055'Access,
      L_1056'Access,
      L_1057'Access,
      L_1058'Access,
      L_1059'Access,
      L_1060'Access,
      L_1061'Access,
      L_1062'Access,
      L_1063'Access,
      L_1064'Access,
      L_1065'Access,
      L_1066'Access,
      L_1067'Access,
      L_1068'Access,
      L_1069'Access,
      L_1070'Access,
      L_1071'Access,
      L_1072'Access,
      L_1073'Access,
      L_1074'Access,
      L_1075'Access,
      L_1076'Access,
      L_1077'Access,
      L_1078'Access,
      L_1079'Access,
      L_1080'Access,
      L_1081'Access,
      L_1082'Access,
      L_1083'Access,
      L_1084'Access,
      L_1085'Access,
      L_1086'Access,
      L_1087'Access,
      L_1088'Access,
      L_1089'Access,
      L_1090'Access,
      L_1091'Access,
      L_1092'Access,
      L_1093'Access,
      L_1094'Access,
      L_1095'Access,
      L_1096'Access,
      L_1097'Access,
      L_1098'Access,
      L_1099'Access,
      L_1100'Access,
      L_1101'Access,
      L_1102'Access,
      L_1103'Access,
      L_1104'Access,
      L_1105'Access,
      L_1106'Access,
      L_1107'Access,
      L_1108'Access,
      L_1109'Access,
      L_1110'Access,
      L_1111'Access,
      L_1112'Access,
      L_1113'Access,
      L_1114'Access,
      L_1115'Access,
      L_1116'Access,
      L_1117'Access,
      L_1118'Access,
      L_1119'Access,
      L_1120'Access,
      L_1121'Access,
      L_1122'Access,
      L_1123'Access,
      L_1124'Access,
      L_1125'Access,
      L_1126'Access,
      L_1127'Access,
      L_1128'Access,
      L_1129'Access,
      L_1130'Access,
      L_1131'Access,
      L_1132'Access,
      L_1133'Access,
      L_1134'Access,
      L_1135'Access,
      L_1136'Access,
      L_1137'Access,
      L_1138'Access,
      L_1139'Access,
      L_1140'Access,
      L_1141'Access,
      L_1142'Access,
      L_1143'Access,
      L_1144'Access,
      L_1145'Access,
      L_1146'Access,
      L_1147'Access,
      L_1148'Access,
      L_1149'Access,
      L_1150'Access,
      L_1151'Access,
      L_1152'Access,
      L_1153'Access,
      L_1154'Access,
      L_1155'Access,
      L_1156'Access,
      L_1157'Access,
      L_1158'Access,
      L_1159'Access,
      L_1160'Access,
      L_1161'Access,
      L_1162'Access,
      L_1163'Access,
      L_1164'Access,
      L_1165'Access,
      L_1166'Access,
      L_1167'Access,
      L_1168'Access,
      L_1169'Access,
      L_1170'Access,
      L_1171'Access,
      L_1172'Access,
      L_1173'Access,
      L_1174'Access,
      L_1175'Access,
      L_1176'Access,
      L_1177'Access,
      L_1178'Access,
      L_1179'Access,
      L_1180'Access,
      L_1181'Access,
      L_1182'Access,
      L_1183'Access,
      L_1184'Access,
      L_1185'Access,
      L_1186'Access,
      L_1187'Access,
      L_1188'Access,
      L_1189'Access,
      L_1190'Access,
      L_1191'Access,
      L_1192'Access,
      L_1193'Access,
      L_1194'Access,
      L_1195'Access,
      L_1196'Access,
      L_1197'Access,
      L_1198'Access,
      L_1199'Access,
      L_1200'Access,
      L_1201'Access,
      L_1202'Access,
      L_1203'Access,
      L_1204'Access,
      L_1205'Access,
      L_1206'Access,
      L_1207'Access,
      L_1208'Access,
      L_1209'Access,
      L_1210'Access,
      L_1211'Access,
      L_1212'Access,
      L_1213'Access,
      L_1214'Access,
      L_1215'Access,
      L_1216'Access,
      L_1217'Access,
      L_1218'Access,
      L_1219'Access,
      L_1220'Access,
      L_1221'Access,
      L_1222'Access,
      L_1223'Access,
      L_1224'Access,
      L_1225'Access,
      L_1226'Access,
      L_1227'Access,
      L_1228'Access,
      L_1229'Access,
      L_1230'Access,
      L_1231'Access,
      L_1232'Access,
      L_1233'Access,
      L_1234'Access,
      L_1235'Access,
      L_1236'Access,
      L_1237'Access,
      L_1238'Access,
      L_1239'Access,
      L_1240'Access,
      L_1241'Access,
      L_1242'Access,
      L_1243'Access,
      L_1244'Access,
      L_1245'Access,
      L_1246'Access,
      L_1247'Access,
      L_1248'Access,
      L_1249'Access,
      L_1250'Access,
      L_1251'Access,
      L_1252'Access,
      L_1253'Access,
      L_1254'Access,
      L_1255'Access,
      L_1256'Access,
      L_1257'Access,
      L_1258'Access,
      L_1259'Access,
      L_1260'Access,
      L_1261'Access,
      L_1262'Access,
      L_1263'Access,
      L_1264'Access,
      L_1265'Access,
      L_1266'Access,
      L_1267'Access,
      L_1268'Access,
      L_1269'Access,
      L_1270'Access,
      L_1271'Access,
      L_1272'Access,
      L_1273'Access,
      L_1274'Access,
      L_1275'Access,
      L_1276'Access,
      L_1277'Access,
      L_1278'Access,
      L_1279'Access,
      L_1280'Access,
      L_1281'Access,
      L_1282'Access,
      L_1283'Access,
      L_1284'Access,
      L_1285'Access,
      L_1286'Access,
      L_1287'Access,
      L_1288'Access,
      L_1289'Access,
      L_1290'Access,
      L_1291'Access,
      L_1292'Access,
      L_1293'Access);

end Parse_Template_File.Templates;
