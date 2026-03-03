
CC = gcc
# Force x86_64 target for the loader on Apple Silicon
# The compiler itself can be native (arm64) or x86_64, but the code it *generates* in codegen.c is bytes for x86_64.
# The `loader` MUST be compiled as x86_64 to execute those bytes natively (via Rosetta).
CFLAGS_LOADER = -target x86_64-apple-macos11

all: mcc loader

mcc: lex.yy.c y.tab.c codegen.c
	$(CC) -o mcc lex.yy.c y.tab.c codegen.c -ll

lex.yy.c: lexer.l
	flex lexer.l

y.tab.c: grammar.y
	bison -y -d grammar.y

loader: loader.c
	$(CC) $(CFLAGS_LOADER) -o loader loader.c

clean:
	rm -f mcc loader lex.yy.c y.tab.c y.tab.h output.bin

test: mcc loader
	@echo "a = 10; b = a + 20; return b * 2;" > test.src
	./mcc < test.src
	./loader output.bin
