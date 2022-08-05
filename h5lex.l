   
%option stack noyywrap  reentrant bison-bridge
%option header-file="h5lex.hpp" 
%{
extern int lineNumber; // definie dans prog.y, utilise par notre code pour \n
#include "h5parse.hxx"
#include <iostream>
#include<fstream>

using namespace std;

string val;


%}
/*reentrant bison-bridge*/
/* doesn’t need yywrap() */
 
%x strenv


i_command       @include
e_command       @extends
l_command       @layout
f_command       @field

command {i_command}|{e_command}|{l_command}|{f_command}

%%
"\""       { val.clear(); BEGIN(strenv); }
<strenv>"\""    { BEGIN(INITIAL);sprintf(yylval->str,"%s",val.c_str());return(STRING); }
<strenv><<EOF>> { BEGIN(INITIAL); sprintf(yylval->str,"%s",val.c_str());return(STRING); }
<strenv>.       { val+=yytext[0]; }
{command}       {sprintf(yylval->str,"%s",yytext);return (COMMAND);}
"("             {yylval->c=yytext[0]; return LPAREN; }
")"             {yylval->c=yytext[0]; return RPAREN; }
"{"             { yylval->c=yytext[0];return LBRACE; }
"}"             { yylval->c=yytext[0];return RBRACE; }
.|\n            {yylval->c=yytext[0];return TXT; }

%%

