#
# !!!!!!!!!!! OBS Generated by GNUmakefile !!!!!!!!!!!!
# This file is supposed to be compatible with as many make implementations as possible
#

bin/yielding_c_fun.bin: ycf_main.o ycf_lexer.o ycf_node.o ycf_parser.o ycf_printers.o ycf_string.o ycf_symbol.o ycf_utils.o ycf_yield_fun.o re.o simple_c_gc.o
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS) -o bin/yielding_c_fun.bin  ycf_main.o ycf_lexer.o ycf_node.o ycf_parser.o ycf_printers.o ycf_string.o ycf_symbol.o ycf_utils.o ycf_yield_fun.o re.o simple_c_gc.o

ycf_main.o: ycf_main.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_main.o ycf_main.c

ycf_lexer.o: ycf_lexer.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_lexer.o ycf_lexer.c

ycf_node.o: ycf_node.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_node.o ycf_node.c

ycf_parser.o: ycf_parser.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_parser.o ycf_parser.c

ycf_printers.o: ycf_printers.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_printers.o ycf_printers.c

ycf_string.o: ycf_string.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_string.o ycf_string.c

ycf_symbol.o: ycf_symbol.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_symbol.o ycf_symbol.c

ycf_utils.o: ycf_utils.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_utils.o ycf_utils.c

ycf_yield_fun.o: ycf_yield_fun.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o ycf_yield_fun.o ycf_yield_fun.c

re.o: lib/tiny_regex_c/re.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o re.o lib/tiny_regex_c/re.c

simple_c_gc.o: lib/simple_c_gc/simple_c_gc.c
	$(CC) -I. -I./lib/simple_c_gc -I./lib/tiny_regex_c $(CFLAGS)  -c -o simple_c_gc.o lib/simple_c_gc/simple_c_gc.c

