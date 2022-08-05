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
%type<c> TXT RPAREN LPAREN RBRACE LBRACE;
%type<str> STRING COMMAND ;
%start program
%%


program:program content | content ;

// call command
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
        free(buffer);
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
        cout<<"extend file: "<<dir<<endl;
      
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
        free(buffer);
        }
        else
        {
            cout<<"cannot find file :"<<dir;
        }
    
    }
    loop=true;
     };
//identify simple content
simple_content:TXT {pdata+=$1;}; 
|RPAREN {pdata+=$1;};  
|LPAREN {pdata+=$1;};
|STRING {  
    string a=$1;
    pdata+='\"'+a+'\"'; };  
content:command_call | simple_content
%%

//error message to display at sintax error
void yyerror (yyscan_t scan,const char *msg)
{
    cerr<<msg;
}
