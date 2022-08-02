example: h5parse.y
	bison -d h5parse.y -o h5parse.cxx
	flex -o h5lex.cxx h5lex.l
	bison -d h5mparse.y -o h5mparse.cxx
	flex -o h5mlex.cxx h5mlex.l
	g++ h5lex.cxx h5parse.cxx h5mlex.cxx h5mparse.cxx  h5maker.cpp h5.cpp -o H5A.exe
