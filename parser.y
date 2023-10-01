%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lex.yy.c"

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(EXIT_FAILURE);
}

char** array_values;   // Global variable to store the array values
int array_size;        // Global variable to store the array size
char* array_name;      // Global variable to store the array name

%}

%union {
    int num;
    char* str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token EQUALS LBRACKET RBRACKET COMMA

%type <str> expr
%type <str> identifier

%{
int validate_index(char* index_str) {
    int index = atoi(index_str);
    if (index == 0 && strcmp(index_str, "0") != 0) {
        return 0; // Invalid index (alphabet)
    }
    return (index >= 0 && index < array_size);
}
%}

%%

program : array_declaration array_indexing { printf("Accepted\n"); exit(EXIT_SUCCESS); }
        | error { printf("Rejected\n"); exit(EXIT_FAILURE); } ;

array_declaration : identifier EQUALS LBRACKET values RBRACKET ;

values : expr { array_values = malloc(sizeof(char*)); array_values[0] = $1; array_size = 1; }
       | values COMMA expr { array_values = realloc(array_values, (array_size + 1) * sizeof(char*)); array_values[array_size] = $3; array_size++; }
       ;

array_indexing : identifier LBRACKET expr_list RBRACKET { array_name = $1; } ;

expr_list : expr {
    if (!validate_index($1)) {
        yyerror("Invalid index");
    }
    int index = atoi($1);
    printf("Index: %d, Value: %s\n", index, array_values[index]);
}
          | expr_list COMMA expr {
              if (!validate_index($3)) {
                  yyerror("Invalid index");
              }
              int index = atoi($3);
              printf("Index: %d, Value: %s\n", index, array_values[index]);
          }
          ;

expr : NUMBER
     | IDENTIFIER
     ;

identifier : IDENTIFIER ;

%%

int main(int argc, char** argv) {
    yyparse();
    return 0;
}