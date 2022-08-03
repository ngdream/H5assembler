%define api.pure full
%lex-param {yyscan_t scanner}
%parse-param {yyscan_t scanner}

%{
#include <stdio.h>
#include <iostream>
#include<fstream>
#include<map>
using namespace std;
typedef void* yyscan_t;
int lineNumber; // notre compteur de lignes
typedef union YYSTYPE YYSTYPE;

map <string,string>layout_data;
void yyerror ( yyscan_t scan,char const *msg);
int yylex(YYSTYPE *c,yyscan_t scanner);


bool loop;

string basedir;
string pdata="";
%}
/* token definition */

%token STRING 
%token COMMAND
%token LPAREN RPAREN  LBRACE RBRACE
%token TXT


%union { char c; char str[0xfff] ; double real; int integer; }
%type<c> TXT;
%type<str> STRING COMMAND;



%start program
%%
program:value | command_call |txt | program program ;
value: STRING {  
    string a=$1;
    pdata+='\"'+a+'\"'; };
command_call : COMMAND LPAREN STRING  RPAREN   {
    
    string dir=basedir;
    if(dir!="")
    dir+='\\';
    dir+=$3;
    if(string($1)=="@field")
    {
         cout<<"define field :"<<$3<<endl;
         

    }
    else if(string($1)=="@include")
    {
        cout<<"include file: "<<dir<<endl;
      
        ifstream file(dir.c_str(),ios::in | ios::binary |ios::ate);
        if(file.is_open())
        {
        char * buffer;    
        int length = file.tellg();
        file.seekg(0, std::ios::beg); 
        buffer =(char*) malloc(sizeof(char)*length)   ;
        file.read(buffer, length); 
        buffer[length]='\0';
        file.close(); 
        pdata+=buffer;
        }
        else
        {
            cout<<"cannot find file :"<<dir;
        }
        
    }
    else if (string($1)=="@layout")
    {
        cout<<"define layout for field "<<$3<<endl;
    }
    else if (string($1)=="@repeat")
    {
        cout<<"reapeat instruction"<<$3<<endl;
    }
    else
    {
        cout<<"extend with : "<<$3<<endl;

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

void yyerror (yyscan_t scan,const char *msg)
{
    cerr<<msg;
}
