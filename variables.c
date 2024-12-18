#include "variables.h"
#include <string.h>
#include <stdlib.h>

#define MAX_VARIABLES 500

variable_t variables[MAX_VARIABLES];
int no_of_var = 0;

// External yyout declared in parser.y
extern FILE *yyout;

int search_id(const char *id) {
    for (int i = 0; i < no_of_var; i++) {
        if (strcmp(variables[i].var_id, id) == 0) {
            return i;
        }
    }
    return -1;
}

void define_variable(int type, const char *id) {
    if (search_id(id) == -1) {
        strcpy(variables[no_of_var].var_id, id);
        variables[no_of_var].var_type = type;
        variables[no_of_var].ival = 0;
        variables[no_of_var].fval = 0.0;
        no_of_var++;
        fprintf(yyout, "Variable '%s' defined.\n", id);
    } else {
        fprintf(yyout, "Error: Variable '%s' already defined.\n", id);
    }
}

void assign_variable(const char *id, int ival, float fval) {
    int idx = search_id(id);
    if (idx != -1) {
        if (variables[idx].var_type == 1) {
            variables[idx].ival = ival;
            fprintf(yyout, "Variable '%s' assigned integer value %d.\n", id, ival);
        } else if (variables[idx].var_type == 2) {
            variables[idx].fval = fval;
            fprintf(yyout, "Variable '%s' assigned float value %.2f.\n", id, fval);
        }
    } else {
        fprintf(yyout, "Error: Variable '%s' not defined.\n", id);
    }
}

variable_t get_variable(const char *id) {
    int idx = search_id(id);
    if (idx != -1) {
        return variables[idx];
    } else {
        fprintf(yyout, "Error: Variable '%s' not defined.\n", id);
        exit(1);
    }
}

int get_int_variable_value(const char *id) {
    int idx = search_id(id);
    if (idx != -1) {
        return variables[idx].ival;
    } else {
        fprintf(yyout, "Error: Variable '%s' not defined.\n", id);
        return 0;
    }
}

float get_float_variable_value(const char *id) {
    int idx = search_id(id);
    if (idx != -1) {
        return variables[idx].fval;
    } else {
        fprintf(yyout, "Error: Variable '%s' not defined.\n", id);
        return 0.0;
    }
}

void print_variable(const char *id) {
    int idx = search_id(id);
    if (idx != -1) {
        if (variables[idx].var_type == 1) {
            fprintf(yyout, "PRINT Value of Variable '%s' = %d\n", id, variables[idx].ival);
        } else if (variables[idx].var_type == 2) {
            fprintf(yyout, "PRINT Value of Variable '%s' = %.2f\n", id, variables[idx].fval);
        }
    } else {
        fprintf(yyout, "Error: Variable '%s' not defined.\n", id);
    }
}

void print_func(float num) {
    fprintf(yyout, "PRINT Value of Expression = %.2f\n", num);
}

void print_bool_expression_state(int flag){
    if(flag == 1) fprintf(yyout, "The Condition is True.\n");
    else fprintf(yyout, "The Condition is False.\n");
}
