/*made by elodream copyright elodream 2022*/
/*scanner for h5maker file */   
%option  noyywrap 
%option header-file="h5mlex.hpp" 
%{
#include "h5mparse.hxx"
#include <iostream>
#include<fstream>

using namespace std;

string location;

%}
 
%x locenv
var             [a-zA-Z]+[0-9]*

%%
"\""            { location.clear(); BEGIN(locenv); }
<locenv>"\""    { BEGIN(INITIAL);yylval.str=(char*)malloc(sizeof(char)*location.size());sprintf(yylval.str,"%s",location.c_str());return(PATH); }
<locenv><<EOF>> { BEGIN(INITIAL);yylval.str=new char[location.size()+1] ;sprintf(yylval.str,"%s",location.c_str());return(PATH); }
<locenv>.       { location+=yytext[0]; }
";"             {return SEMI;}
"="             {return EQUAL;}
{var}           {yylval.str=new char[strlen(yytext)]; return VAR;}

"{"             {return LBRACE;}
"}"             {return RBRACE;}
"\n"            {}



%%

