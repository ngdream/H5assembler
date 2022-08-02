   
%option  noyywrap 
%option header-file="h5mlex.hpp" 
%{
#include "h5mparse.hxx"
#include <iostream>
#include<fstream>

using namespace std;

string location;


%}
/*reentrant bison-bridge*/
/* doesn’t need yywrap() */
 
%x locenv
VAR  [a-zA-Z]+[0-9]*

%%
"\""       { location.clear(); BEGIN(locenv); }
<locenv>"\""    { BEGIN(INITIAL);yylval.str=(char*)malloc(sizeof(char)*location.size());sprintf(yylval.str,"%s",location.c_str());return(PATH); }
<locenv><<EOF>> { BEGIN(INITIAL);yylval.str=new char[location.size()+1] ;sprintf(yylval.str,"%s",location.c_str());return(PATH); }
<locenv>.       { location+=yytext[0]; }
";"             {return SEMI;}
"="             {return EQUAL;}
{VAR}       {yylval.str=new char[strlen(yytext)];}
"\n"            {}
"{"             {return LBRACE;}
"}"             {return RBRACE;}
.           {}
{VAR}       {return VAR;}

%%

