#ifndef VARIABLES_H
#define VARIABLES_H

#include <stdio.h>

typedef struct {
    char var_id[30];
    int var_type; // 1: int, 2: float
    int ival;
    float fval;
} variable_t;

void define_variable(int type, const char *id);
void assign_variable(const char *id, int ival, float fval);
variable_t get_variable(const char *id);
int get_int_variable_value(const char *id);
float get_float_variable_value(const char *id);
void print_variable(const char *id);
int search_id(const char *id);
void print_func(float num);
void print_bool_expression_state(int flag);

#endif
