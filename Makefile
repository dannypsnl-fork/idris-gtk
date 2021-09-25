.PHONY: all clean

all:
	@idris2 --build ./package.ipkg

clean:
	@idris2 --clean ./package.ipkg
