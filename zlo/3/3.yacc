%{
#include <stdio.h>
#include <string.h>


void yyerror(const char * str)
{
    fprintf(stderr,"error:%s\n",str);
}

int yyparse();

int yylex();

int yywrap()
{ 
    return 1;
}
int main()
{
    yyparse();
    return 1;
}
%}

%union {
    char* str;
}

%token <str> CONST BG ND KEY_VAR IDENTIFIER SEMICOLON COMMA SIGN MINUS ADD MULTIPLY DIV OPBRACKET ENBRACKET
%type <str> PROGRAM OPS VARS VAR_LIST OPS_LIST ASSIGNMENT EXPRESSION SUBEXPR UNAR BINAR OPERAND

%%
PROGRAM: VARS OPS 
{
    printf("%s\n", $1);
    printf("%s\n", $2);
    printf("\n");
}
;

OPS: BG OPS_LIST ND 
{
    $$ = strdup("Begin\n");
    $$ = strcat($$, $2);
    $$ = strcat($$ , strdup("End.\n"));
}
;

VARS: KEY_VAR VAR_LIST SEMICOLON
{
    $$ = strdup("Var ");
    $$ = strcat($$, $2);
}
;

VAR_LIST: IDENTIFIER
{
    $$ = $1;
} 
| IDENTIFIER COMMA VAR_LIST
{
    $$ = strcat($1, ", ");
    $$ = strcat($$, $3);
}
;

OPS_LIST: ASSIGNMENT
{
    $$ = $1;
}
| ASSIGNMENT OPS_LIST
{
   $$ = strcat($1, $2);
}
;

ASSIGNMENT: IDENTIFIER SIGN EXPRESSION SEMICOLON
{
    $$ = strcat($1, "= ");
    $$ = strcat($$, $3);
    $$ = strcat($$, strdup("\n"));
}
;

EXPRESSION: UNAR SUBEXPR
{
    $$ = strcat($1, $2);
} 
| SUBEXPR 
{
    $$ = $1;
}
;

SUBEXPR: OPBRACKET EXPRESSION ENBRACKET
{
    $$ = strdup("(");
    $$ = strcat($$, $2);
    $$ = strcat($$, strdup(")"));
}
| OPERAND
{
    $$ = $1;
}
| SUBEXPR BINAR SUBEXPR 
{
    $$ = strcat($1, $2);
    $$ = strcat($$, $3);
}
; 

UNAR: MINUS
{
    $$ = strdup("-");
}
;

BINAR: MINUS
{
    $$ = strdup("-");
}
| ADD 
{
    $$ = strdup("+");
}
| MULTIPLY
{
    $$ = strdup("*");
}
| DIV
{
    $$ = strdup("/");
}
;

OPERAND: IDENTIFIER 
{
    $$ = $1;
}
| CONST
{
    $$ = $1;
}
;
%%