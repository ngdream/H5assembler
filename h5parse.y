%define api.pure full
%lex-param {yyscan_t scanner}
%parse-param {yyscan_t scanner}

%{
#include <stdio.h>
#include <iostream>
#include<fstream>
#include<map>
#include<cstring>
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


%union { char c; char *str ; double real; int integer; }
%type<c> TXT RPAREN LPAREN RBRACE LBRACE;
%type<str> STRING COMMAND command_call content   content_part tail tails ;
%start program
%%


program:content ;

// call command
command_call : COMMAND LPAREN STRING  RPAREN   {
    string dir=basedir;
    if(dir!="")
    dir+='\\';
    dir+=$3;
    if(string($1)=="@field")
    {
         cout<<"define field :"<<$3<<endl;
         $$= new char[layout_data[$3].size()];
         strcpy($$,layout_data[$3].c_str());

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
        $$=buffer;
        }
        else
        {
            cout<<"cannot find file :"<<dir;
        }
        
    }
    else if (string($1)=="@extends")
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

    | COMMAND LPAREN STRING  RPAREN LBRACE tails RBRACE
    {
    if (string($1)=="@repeat")
    {
        cout<<"reapeat instruction :"<<$3<<" times"<<endl;
        string repeated;
        for(int i=0 ;i<atoi($3);i++)
        {
            repeated+=$6;
        }
        $$=new char[repeated.size()];
        strcpy($$,repeated.c_str());
       
    }
    else if (string($1)=="@layout")
    {

        layout_data[$3]=$6;
    }

    }
//identify simple content
tail:
TXT{$$=new char[2]; $$[0]=$1; $$[1]='\0';} |RPAREN |LPAREN|STRING |command_call

tails:tails tail
{char *str = (char*) malloc(strlen($1) + strlen($2) + 1);
      strcpy(str, $1);
      strcat(str, $2);
      free($2);
      free($1);
      $$ = str;
      }
 |tail


content_part:TXT {pdata+=$1;}; 
|RPAREN {pdata+=$1;};  
|LPAREN {pdata+=$1;};
|STRING {  
    string a=$1;
    pdata+='\"'+a+'\"'; };  
|command_call{$$=$1;  pdata+=$$;}


content:content content_part 

 |content_part 

%%

//error message to display at sintax error
void yyerror (yyscan_t scan,const char *msg)
{
    cerr<<msg;
}
