%{
#include "parser.tab.h"
%}

%%
[ \t]                /* Ignore whitespace */
"="                     { return EQUALS; }
"["                     { return LBRACKET; }
"]"                     { return RBRACKET; }
","                     { return COMMA; }
[0-9]+(\.[0-9]+)?      { yylval.str = strdup(yytext); return NUMBER; }
"-"[0-9]+(\.[0-9]+)?   { yylval.str = strdup(yytext); return NUMBER; }
[A-Za-z_][A-Za-z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }
.                      { return yytext[0]; }
%%

int yywrap() {
    return 1;
}