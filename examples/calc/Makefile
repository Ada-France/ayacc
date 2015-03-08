GNATMAKE=gnatmake
AYACC=ayacc

LEX_FILES=calc_lex.ads calc_lex.adb calc_lex_dfa.ads calc_lex_dfa.adb calc_lex_io.ads calc_lex_io.adb
AYACC_FILES=calc_goto.ads calc_shift_reduce.ads calc_tokens.ads parser.ads parser.adb

build: $(LEX_FILES) $(AYACC_FILES)
	$(GNATMAKE) driver.adb

clean:
	rm -f *.ali *.o driver ada.ada ada_lex.ada
	rm -f $(LEX_FILES)
	rm -f $(AYACC_FILES)

$(LEX_FILES): calc_lex.l
	aflex calc_lex.l
	gnatchop -w calc_lex.ada
	rm -f calc_lex.ada

$(AYACC_FILES):	calc.y
	$(AYACC) calc.y
	gnatchop -w calc.ada
	rm -f calc.ada
