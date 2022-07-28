

%{
#include <stdio.h>
#include <iostream>
#include<fstream>
#include<map>
using namespace std;
typedef void* yyscan_t;
int lineNumber; // notre compteur de lignes
map <string,string> clayouts;
void yyerror ( char const *msg);
typedef union YYSTYPE YYSTYPE;


void yyerror ( char const *msg);
int yylex();
bool loop;
string pdata="";
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
    loop=true;
     };//LPAREN RPAREN ;
txt: TXT {pdata+=$1;};

%%

void yyerror (const char *msg)
{
    cout<<msg;
}
