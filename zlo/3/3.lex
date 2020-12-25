%{
#include <stdio.h>
#include "y.tab.h"
#ifdef YYSTYPE
#define YYSTYPE char *
#endif
extern YYSTYPE yylval;
%}

%%

([0-9])+            yylval.str=strdup(yytext); return CONST;
(\[)                yylval.str=strdup(yytext); return BG;
(\])                yylval.str=strdup(yytext); return ND;
(Var)               yylval.str=strdup(yytext); return KEY_VAR;
([a-zA-Z])+         yylval.str=strdup(yytext); return IDENTIFIER;
(;)                 yylval.str=strdup(yytext); return SEMICOLON;
(,)                 yylval.str=strdup(yytext); return COMMA;
(=)                 yylval.str=strdup(yytext); return SIGN;
(-)                 yylval.str=strdup(yytext); return MINUS;
(\+)                yylval.str=strdup(yytext); return ADD;
(\*)                yylval.str=strdup(yytext); return MULTIPLY;
(\/)                yylval.str=strdup(yytext); return DIV;
(\()                yylval.str=strdup(yytext); return OPBRACKET;
(\))                yylval.str=strdup(yytext); return ENBRACKET;
\n                  ;
[ \t]+              ;
%%