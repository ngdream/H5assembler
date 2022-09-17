/*made by elodream copyright elodream 2022*/
/*
parser for h5maker file 
*/   

%{
#include<vector>
#include <iostream>
#include<fstream>
#include<map>
#include "h5mlex.hpp"

using namespace  std;


map<string,void*> variables;
vector<string> l;
void yyerror (const char *msg);
int saveoutput(string compileddata, string outputpath = "");

string compile(string content);
string compilefile(string path);
int   yylex();

%}
/* token definition */
%token VAR ASSIGN  SEMI  EQUAL
%token PATH  COMA
%token RBRACE LBRACE

%union {  char * str ;}
%type<str> PATH VAR pathlistargs  pathlist;
%start program
%%
program:instructions  ;


assign: VAR EQUAL PATH {
    variables[$1]=(void*) $3;
    }; 
    | VAR EQUAL VAR 
    {variables[$1]=(void*) $3;};
pathlist: LBRACE pathlistargs RBRACE {$$=$2; }
pathlistargs: pathlistargs  PATH {char *str = (char*) malloc(strlen($1) + strlen($2) + 1);
      strcpy(str, $1);
      strcat(str, ",");
      strcat(str, $2);
      free($2);
      free($1);
      $$ = str;
      } 
      | PATH 

buildpath:PATH EQUAL pathlist {
     char * token = strtok($3, ",");
   // loop through the string to extract all other tokens
   while( token != NULL ) {
     l.push_back(token); //printing each token
     saveoutput(compilefile($1),token);
      token = strtok(NULL, ",");
      
   }

}
instruction:assign SEMI | buildpath SEMI | pathlist SEMI | pathlistargs SEMI;
instructions:instruction instructions |instruction

%%

void yyerror (const char *msg)
{
    cerr<<"error in h5maker file";
}

void inith5m()
{
variables["BUILD_PATH"]=new char [100];
variables["BUILD_PATH"]=(void*)"build";
}