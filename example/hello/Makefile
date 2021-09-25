.PHONY: all build run clean

all: build
build:
	@idris2 --build ./package.ipkg

run: build
	@./bin/hello

clean:
	@idris2 --clean ./package.ipkg
