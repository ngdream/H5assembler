example: h5parse.y
	bison -d h5parse.y -o h5parse.cxx
	flex -o h5lex.cxx h5lex.l
	g++ h5lex.cxx h5parse.cxx h5.cpp -o H5assembler.exe