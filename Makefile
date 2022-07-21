example: h5.y
	bison -d h5.y -o h5parse.cpp
	flex -o h5lex.cpp h5.l
	g++ h5lex.cpp h5parse.cpp -o H5assembler.exe