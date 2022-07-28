   

/*nodefault  bison-bridge*/
%{
extern int lineNumber; // definie dans prog.y, utilise par notre code pour \n
#include "h5parse.hpp"
#include <iostream>
#include<fstream>

using namespace std;
extern string initialdata;
extern string pdata;
extern bool loop;
string val;
string compile(string content);
string compilefile(string path);
void runwithargs(int argc ,char ** argv);

int saveoutput(string compileddata ,string outputpath="");

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
<strenv>"\""    { BEGIN(INITIAL);sprintf(yylval.str,"%s",val.c_str());return(STRING); }
<strenv><<EOF>> { BEGIN(INITIAL); sprintf(yylval.str,"%s",val.c_str());return(STRING); }
<strenv>.       { val+=yytext[0]; }
{command}       {sprintf(yylval.str,"%s",yytext);return (COMMAND);}
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
.|\n               {yylval.c=yytext[0];return TXT; }
<<EOF>> {
            		yypop_buffer_state();

            if ( !YY_CURRENT_BUFFER )
                {
                yyterminate();
                }
         }
%%

int main(int argc,char ** argv)
{


if(argc>1)runwithargs(argc,argv);

system("pause");
return(0);
}

void runwithargs(int argc ,char ** argv)
{
    if(argc ==2)
    saveoutput(compilefile(argv[1]));
    
}


string compile(string content)
{

do 
{
loop=false;
pdata.clear();
 YY_BUFFER_STATE b =yy_scan_string(content.c_str());
yyparse();
content=pdata; 
}while(loop==true);
return content;
}

string compilefile(string path)
{
string data;
ifstream inputfile(path,ios::in|ios::binary|ios::ate);
int length  = inputfile.tellg();           
inputfile.seekg(0, std::ios::beg);  
char * buffer = new char[length];// allocate memory for a buffer of appropriate dimension
inputfile.read(buffer, length);       // read the whole file into the buffer
inputfile.close();  

return compile(string(buffer));
}


int saveoutput(string compileddata ,string outputpath)
{
ofstream outputfile;

if(outputpath!="")
outputfile.open(outputpath);
else
outputfile = ofstream("output");
outputfile<<compileddata;
cout<<compileddata;

return 0;

}

int yywrap()
{
    return 1;
}