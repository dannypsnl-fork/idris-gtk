.PHONY: all build run clean

all: build
build:
	@idris2 --build ./package.ipkg

run: build
	@./build/exec/hello

clean:
	@idris2 --clean ./package.ipkg
