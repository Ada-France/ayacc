GNATMAKE=gnatmake
AYACC=ayacc

LEX_FILES=ada_lex.ads ada_lex.adb ada_lex_dfa.ads ada_lex_dfa.adb ada_lex_io.ads ada_lex_io.adb
AYACC_FILES=ada_goto.ads ada_shift_reduce.ads ada_tokens.ads parser.ads parser.adb

build: $(LEX_FILES) $(AYACC_FILES)
	$(GNATMAKE) parse.adb

clean:
	rm -f *.ali *.o driver ada.ada ada_lex.ada
	rm -f $(LEX_FILES)
	rm -f $(AYACC_FILES)

$(LEX_FILES): ada_lex.l
	aflex ada_lex.l
	gnatchop -w ada_lex.ada

$(AYACC_FILES):	ada.y
	$(AYACC) ada.y
	gnatchop -w ada.ada
	rm -f ada.ada
