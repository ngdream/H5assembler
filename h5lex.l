   
%option stack noyywrap  reentrant bison-bridge
%{
extern int lineNumber; // definie dans prog.y, utilise par notre code pour \n
#include "h5parse.hpp"
#include <iostream>
#include<fstream>

using namespace std;
extern string initialdata;
extern string pdata;
extern bool loop;
extern string basedir;
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
<strenv>"\""    { BEGIN(INITIAL);sprintf(yylval->str,"%s",val.c_str());return(STRING); }
<strenv><<EOF>> { BEGIN(INITIAL); sprintf(yylval->str,"%s",val.c_str());return(STRING); }
<strenv>.       { val+=yytext[0]; }
{command}       {sprintf(yylval->str,"%s",yytext);return (COMMAND);}
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
.|\n            {yylval->c=yytext[0];return TXT; }

%%

//our main function 
int main(int argc,char ** argv)
{

if(argc>1)runwithargs(argc,argv);// if there are arguments run with them

system("pause");//don't quit the app at the end of assembly
return(0);
}

//run h5A by using  arguments
void runwithargs(int argc ,char ** argv)
{
  if(argv[2]=="-m")
  {
    if(argc<3)
    {
        //will assemble a file using a H5maker file
        cout<<"no H5maker file specified"<<endl;
    }

  }
  else
  {
    if(argc>2)
    {
        for(int i=2 ; i<argc;i++)
        saveoutput(compilefile(argv[1]),argv[i]);
    }
    else
        saveoutput(compilefile(argv[1]));
  }
    
}

//assemble a string 
string compile(string content)
{

do 
{
loop=false;
yyscan_t * scan= new yyscan_t;
pdata.clear();
yylex_init(scan) ;
YY_BUFFER_STATE buf=yy_scan_bytes(content.c_str(),strlen(content.c_str()),*scan);
yyparse(*scan);
yylex_destroy (*scan) ;
content=pdata; 


 }while(loop==true);
return content;
}

//assemble file
string compilefile(string path)
{
string data;
ifstream inputfile(path,ios::in|ios::binary|ios::ate);
int length  = inputfile.tellg();           
inputfile.seekg(0, std::ios::beg);  
char * buffer = new char[length];// allocate memory for a buffer of appropriate dimension
inputfile.read(buffer, length);// read the whole file into the buffer
inputfile.close(); 
cout<<"start assembly : "<<path<<endl;


const size_t last_slash_idx = path.rfind('\\');
if (std::string::npos != last_slash_idx)
{
    basedir = path.substr(0, last_slash_idx);
}
cout<<"directory is :"<<basedir;

return compile(string(buffer));
}

//save  assembled  file to a specified path 
int saveoutput(string compileddata ,string outputpath)
{

outputpath=(outputpath=="")?"output.html":outputpath;
ofstream outputfile  (outputpath);
outputfile<<compileddata;
cout<<"\noperation terminated successfuly , output at :"
    <<outputpath<<endl;

return 0;

}
