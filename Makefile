example: h5parse.y
	bison -d h5parse.y -o h5parse.cpp
	flex -o h5lex.cpp h5lex.l
	g++ h5lex.cpp h5parse.cpp -o H5assembler.exe