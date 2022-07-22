%{
extern int lineNumber; // definie dans prog.y, utilise par notre code pour \n
void yyerror(const char * msg); // definie dans prog.y, utilise par notre code pour .
#include "h5parse.hpp"
#include <iostream>
#include<fstream>


using namespace std;
extern string initialdata;
extern string pdata;
extern bool alway ;
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


int main(int argc,char ** argv)
{
ifstream t;
int length;
char * buffer;
if(argc>1)
{

t.open(argv[1]);     
t.seekg(0, std::ios::end);    
length = t.tellg();           
t.seekg(0, std::ios::beg);  
buffer = new char[length];    // allocate memory for a buffer of appropriate dimension
t.read(buffer, length);       // read the whole file into the buffer
t.close();   
} 
initialdata=buffer;
do 
{
 alway=false;
pdata.clear();

 YY_BUFFER_STATE b =yy_scan_string(initialdata.c_str());
lineNumber=1;
yyparse();
cout<<pdata;
yy_switch_to_buffer(b);

initialdata=pdata;  



}while(alway==true);
cout<<pdata;


system("pause");
return(0);
}
