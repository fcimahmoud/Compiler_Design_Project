%{

#include <stdio.h>
#include "parser.tab.h"
extern char* strdup(const char*);
#include <string.h>
#include <stdlib.h>

%}

ID          	[a-zA-Z][a-zA-Z0-9_]*
INT        	[0-9]+
FLOAT   	[0-9]*\.[0-9]+

%%

"int"	{ return INTTYPE; }
"float"	{ return FLOATTYPE; }
"if"	{ return IF; }
"elif"	{ return ELIF; }
"else"	{ return ELSE; }
"for"	{ return FOR; }
"while"	{ return WHILE; }
"print"	{ return PRINT; }

{ID}	{ yylval.stringValue = strdup(yytext); return ID; }
{INT}	{ yylval.intValue = atoi(yytext); return INT; }
{FLOAT}	{ yylval.floatValue = atof(yytext); return FLOAT; }

"=="	{ return EQ; }
"!="	{ return NOTEQUAL; }
">" 	{ return GT; }
">="	{ return GE; }
"<" 	{ return LT; }
"<="    	{ return LE; }
"+"          	{ return PLUS; }
"-"          	{ return MINUS; }
"*"         	{ return MUL; }
"/"             { return DIV; }

[,:;{}=()~] 	{ return *yytext; }
[ \n\t]+  	{ /* skip whitespace */ }
.        	{ printf("Unknown character: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}
