%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
([0-9])+            return CONST;
(\[)                return BG;
(\])                return ND;
(Var)               return KEY_VAR;
([a-zA-Z])+         return IDENTIFIER;
(;)                 return SEMICOLON;
(,)                 return COMMA;
(=)                 return SIGN;
(-)                 return MINUS;
(\+)                return ADD;
(\*)                return MULTIPLY;
(\/)                return DIV;
(\()                return OPBRACKET;
(\))                return ENBRACKET;
\n                  ;
[ \t]+              ;
%%