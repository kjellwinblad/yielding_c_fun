
IDIR = .

CC = cc

ifdef MODERN_CC
	EXTRA_C_FLAGS = -g -O02 -std=c99 -pedantic -Wall
else
	EXTRA_C_FLAGS =
endif

ifdef USE_GC
	USE_GC_STRING = -use_gc
endif

ifdef ADD_SAN
	CC = clang
	EXTRA_C_FLAGS = -std=c99 -Wall -pedantic -g -O00 -fsanitize-blacklist=lib/simple_c_gc/.misc/clang_blacklist.txt -fsanitize=address -fno-omit-frame-pointer
	USE_GC_STRING = -use_gc
endif

ifdef MEM_SAN
	CC = clang
	EXTRA_C_FLAGS = -std=c99 -Wall -pedantic -g -O00 -fsanitize-blacklist=lib/simple_c_gc/.misc/clang_blacklist.txt -fsanitize=memory -fno-omit-frame-pointer
endif

ifdef UB_SAN
	CC = clang
	EXTRA_C_FLAGS = -std=c99 -Wall -pedantic -g -O00 -fsanitize-blacklist=lib/simple_c_gc/.misc/clang_blacklist.txt -fsanitize=undefined -fno-omit-frame-pointer
endif



CFLAGS = -I$(IDIR) $(EXTRA_C_FLAGS)

ODIR = .
LDIR = lib/tiny_regex_c

_DEPS = ycf_lists.h  ycf_node.h  ycf_parser.h  ycf_printers.h  ycf_string.h  ycf_symbol.h  ycf_utils.h  ycf_yield_fun.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = ycf_main.o  ycf_lexer.o  ycf_node.o  ycf_parser.o  ycf_printers.o  ycf_string.o  ycf_symbol.o  ycf_utils.o  ycf_yield_fun.o lib/tiny_regex_c/re.o lib/simple_c_gc/simple_c_gc.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))
C_FILES = [$(patsubst %.o,%.c,$(_OBJ))

bin/yielding_c_fun.bin: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: clean test run_test_continusly CMakeLists.txt cmake_compile clang_format test_add_san test_mem_san test_modern_cc test_sanitizers test_gcc_clang_tcc clang_tidy test_all

test: bin/yielding_c_fun.bin
	./test/test.sh $(USE_GC_STRING) &&\
	printf "\n\n\033[0;32mALL TESTS PASSED!\033[0m\n\n\n" ||\
	printf "\n\n\033[0;31mTEST FAILED!\033[0m\n\n\n"

test_add_san:
	make clean
	make ADD_SAN=1 test

test_mem_san:
	make clean
	make MEM_SAN=1 test

test_ub_san:
	make clean
	make UB_SAN=1 test

test_modern_cc:
	make clean
	make MODERN_CC=1 test

test_sanitizers:
	make test_add_san
	make test_mem_san
	make test_ub_san

test_gcc_clang_tcc:
	make CC=gcc EXTRA_C_FLAGS="-g -O01 -std=c99 -pedantic -Wall -Werror" clean bin/yielding_c_fun.bin
	make CC=clang EXTRA_C_FLAGS="-g -O01 -std=c99 -pedantic -Wall -Werror" clean bin/yielding_c_fun.bin
	make CC=tcc EXTRA_C_FLAGS="-g -O01 -std=c99 -pedantic -Wall -Werror" clean bin/yielding_c_fun.bin

test_all:
	make test_gcc_clang_tcc
	make clang_tidy
	make test_sanitizers
	make test_modern_cc

run_test_continusly:
	inotifywait -e close_write,moved_to,create -m ./*.c ./*.h -m test -m test/examples | while read -r directory events filename; do gtags ; make test_all ; done

CMakeLists.txt: $(C_FILES)
	echo "cmake_minimum_required (VERSION 2.6)" > CMakeLists.txt
	echo "project (YIELDING_C_FUN C)" >> CMakeLists.txt
	echo "add_executable(cmake.out" >> CMakeLists.txt
	echo $(C_FILES) >> CMakeLists.txt
	echo ")" >> CMakeLists.txt

cmake_compile: CMakeLists.txt
	mkdir cmake_mkdir || true
	cd cmake_mkdir && cmake ..

clang_tidy:
	(ls *.c ; echo lib/tiny_regex_c/re.c ; echo lib/simple_c_gc/simple_c_gc.c) | xargs -I{} -n1 clang-tidy -warnings-as-errors=*  {} -- $(CFLAGS)

clang_format:
	clang-format -style="{BasedOnStyle: LLVM}" -i *.c *.h

clean:
	rm -f lib/simple_c_gc/*.o lib/tiny_regex_c/*.o $(ODIR)/*.o *~ core $(IDIR)/*~ trap parse bin/yielding_c_fun.bin CMakeLists.txt
