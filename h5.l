%{
extern int lineNumber; // definie dans prog.y, utilise par notre code pour \n
void yyerror(const char * msg); // definie dans prog.y, utilise par notre code pour .
#include "h5parse.hpp"
#include <iostream>

using namespace std;
string val;
%}

/* doesn’t need yywrap() */
%option     noyywrap
%x strenv


i_command       @include
e_command       @extends
l_command       @layout
f_command       @field

command {i_command}|{e_command}|{l_command}|{f_command}

%%
"\""       { val.clear(); BEGIN(strenv); }
<strenv>"\""    { BEGIN(INITIAL);sprintf(yylval.str,"%s",val.c_str());return(STRING); }
<strenv><<EOF>> { BEGIN(INITIAL); sprintf(yylval.str,"%s",val.c_str());return(STRING); }
<strenv>.       { val+=yytext[0]; }
{command}       {sprintf(yylval.str,"%s",yytext);return (COMMAND);}
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
.               {yylval.c=yytext[0];return TXT; }



%%
