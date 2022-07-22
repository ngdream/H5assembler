%{ /*-------- prog.y --------*/
#include <stdio.h>
#include <iostream>
#include<fstream>
#include<map>
using namespace std;
int yylex(void); // defini dans progL.cpp, utilise par yyparse()
void yyerror(const char * msg); // defini plus loin, utilise par yyparse()
typedef struct yy_buffer_state * YY_BUFFER_STATE;
int lineNumber; // notre compteur de lignes
map <string,string> clayouts;

string initialdata;
string pdata="";
bool alway ;
%}
/* token definition */
%token STRING 
%token COMMAND
%token LPAREN RPAREN  LBRACE RBRACE
%token TXT
%union { char c; char str [0Xfff]; double real; int integer; }
%type<c> TXT;
%type<str> STRING COMMAND;
%start program
%%
program:value | command_call |txt | program program ;
value: STRING {pdata+='\"'+$1+'\"';};
command_call : COMMAND LPAREN STRING  RPAREN   { 
    if(string($1)=="@field")
    {
         cout<<"define field :"<<$3;
         

    }
    else if(string($1)=="@include")
    {
        ifstream t;
        int length;
        char * buffer;
        t.open($3);     
        t.seekg(0, std::ios::end);    
        length = t.tellg();           
        t.seekg(0, std::ios::beg);  
        buffer = new char[length];    
        t.read(buffer, length);       
        t.close(); 
        pdata+=buffer;
    }
    else if (string($1)=="@layout")
    {
        cout<<"define layout for field "<<$3;
    }
    else if (string($1)=="@repeat")
    {
        cout<<"reapeat instruction"<<$3;
    }
    else
    {
        cout<<"extend with : "<<$3;

         ifstream t;
        int length;
        char * buffer;
        t.open($3);     
        t.seekg(0, std::ios::end);    
        length = t.tellg();           
        t.seekg(0, std::ios::beg);  
        buffer = new char[length];    
        t.read(buffer, length);       
        t.close(); 
       

    }
    alway=true;
     };//LPAREN RPAREN ;
txt: TXT {pdata+=$1;};

%%
void yyerror(const char * msg)
{
cout<<"error is occured";
cerr << "line " << lineNumber << ": " << msg << endl;
}
