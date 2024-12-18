%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "variables.h"
    #include <string.h>

    int yylex(void);
    void yyerror(const char *);
    extern FILE *yyin, *yyout;

%}

%union {
    int intValue;
    float floatValue;
    char *stringValue;
}

%token <stringValue> ID
%token <intValue> INT
%token <floatValue> FLOAT
%token INTTYPE FLOATTYPE PRINT
%token IF ELIF ELSE WHILE FOR EQ NOTEQUAL GT GE LT LE PLUS MINUS MUL DIV

%type <intValue> bool_expression if_statement elif_statements else_statement code
%type <floatValue> expression for_loop
%type <stringValue> assignment 

%right '='
%left PLUS MINUS
%left MUL DIV

%start program

%%

program:
    code
;

code:
    statement code {}
    | {}
;

statement:
    definition
    | assignment
    | print_statement
    | if_statement
    | for_loop
    | while_loop
;

definition:
    INTTYPE ID '=' expression ';' {
        define_variable(1, $2);
        assign_variable($2, $4, 0.0);
        fprintf(yyout, "_________________________\n");
    }
    | FLOATTYPE ID '=' expression ';' {
        define_variable(2, $2);
        assign_variable($2, 0, $4);
        fprintf(yyout, "_________________________\n");
    }
;

assignment:
    ID '=' expression ';' {
        assign_variable($1, $3, $3);
        $$ = $1;
        fprintf(yyout, "_________________________\n");
    }
;

print_statement:
    PRINT '(' ID ')' ';' {
        print_variable($3);
        fprintf(yyout, "_________________________\n");
    }
    | PRINT '(' expression ')' ';' {
        fprintf(yyout, "PRINT Value of Expression = %.2f\n", $3);
        fprintf(yyout, "_________________________\n");
    }
;

if_statement:
    IF '(' bool_expression ')' '{' code '}' elif_statements else_statement {
        if ($3) {
            fprintf(yyout, "IF Block Executed.\n");
        }
        else if ($8) {
            fprintf(yyout, "ELIF Block Executed.\n");
        }
        else {
            fprintf(yyout, "ELSE Block Executed.\n");
        }
        fprintf(yyout, "_________________________\n");
    }
;

elif_statements:
    ELIF '(' bool_expression ')' '{' code '}' elif_statements {
        if ($3) {
            $$ = 1;
        }
        else {
            $$ = 0;
        }
    }
    | { }
;

else_statement:
    ELSE '{' code '}' 
    | { }
;

while_loop:
WHILE '(' expression LT expression ')' '{' code '}' 
        {
	int i = $3, j = $5, itr = 1;
	while (i < j) { fprintf(yyout, "Iteraton number %d of the loop. \n", itr); itr++; i++; }
	fprintf(yyout, "WHILE Loop Excuted Succefully\n");
	fprintf(yyout, "_______________________________\n");					
        }
;

for_loop:
    FOR '(' assignment expression LT expression ';' assignment ')' '{' code '}'         
       {
	variable_t var = get_variable($3); 
	if(var.var_type == 1) 
		$$ = get_int_variable_value($3); 
	else 
		$$ = get_float_variable_value($3);

	int i, itr = 1;
	for (i = $$; i < $6; i++, itr++) { 
		fprintf(yyout, "Iteraton number %d of the loop. \n", itr);
	}

	fprintf(yyout, "FOR Loop Excuted Succefully\n");
	fprintf(yyout, "_______________________________\n");		
        }
    | FOR '(' assignment bool_expression ';' assignment ')' '{' code '}'   
         {

	fprintf(yyout, "FOR Loop Excuted Succefully\n");
	fprintf(yyout, "_______________________________\n");
         }
;

bool_expression:
    expression EQ expression { 
	$$ = ($1 == $3);
	print_bool_expression_state($$);
          }
    | expression NOTEQUAL expression { 
	$$ = ($1 != $3); 
	print_bool_expression_state($$);
          }
    | expression GT expression { 
	$$ = ($1 > $3); 
	print_bool_expression_state($$);
          }
    | expression GE expression { 
	$$ = ($1 >= $3); 
	print_bool_expression_state($$);
          }
    | expression LT expression { 
	$$ = ($1 < $3); 
	print_bool_expression_state($$);
          }
    | expression LE expression { 
	$$ = ($1 <= $3); 
	print_bool_expression_state($$);
          }
    | expression { 
	$$ = !($1 == 0); 
	print_bool_expression_state($$);
          }
;

expression:
     INT { $$ = $1; }
    | FLOAT { $$ = $1; }
    | ID { 
	variable_t var = get_variable($1); 
	if(var.var_type == 1) 
		$$ = get_int_variable_value($1); 
	else 
		$$ = get_float_variable_value($1);
            }
    | expression PLUS expression { $$ = $1 + $3; }
    | expression MINUS expression { $$ = $1 - $3; }
    | expression MUL expression { $$ = $1 * $3; }
    | expression DIV expression {
        	if ($3 != 0) $$ = $1 / $3;
        	else { yyerror("Error : Division by zero"); $$ = 0; }
          }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    if (!yyin || !yyout) {
        fprintf(stderr, "Error: Could not open input/output files.\n");
        return 1;
    }

    yyparse();

    fclose(yyin);
    fclose(yyout);
    return 0;
}
