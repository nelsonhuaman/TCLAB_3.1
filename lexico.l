%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <conio.h>
    #include <string.h>
    FILE *yyin;
%}



%option noyywrap

%option yylineno


DIGITO           [0-9]
LETRA            [a-zA-Z]
ESPACIO          [" "]
INI_COMENTARIO   ["/*"]
FIN_COMENTARIO   ["*/"]
GUIONES          ["_"]
CHAR_COMA        [","]
CHAR_PUNTO       ["."]
CHAR_PUNTOYCOMA  [";"]
CHAR_DOSPUNTOS   [":"]

INDENTIFICADOR   {LETRA}({LETRA}|{DIGITO}|{GUIONES})*
CONST_INTEGER    (-?[1-9][0-9]{0,4})|0
CONST_FLOAT      {DIGITO}{0,8}{CHAR_PUNTO}{DIGITO}{1,8}

CONST_CADENA     \"[^\n"]*\"

/*Operadores basicos de pseint*/
OP_SUMA       ["+"]
OP_RESTA      [-]
OP_MULT       ["*"]
OP_DIV        ["/"]
OP_IGUAL      ["="]
OP_MAYOR      [">"]
OP_MENOR      ["<"]
OP_MAYORIGUAL ">="
OP_MENORIGUAL "<="
OP_COMP_IGUAL "=="
OP_NEGACION   "!"
OP_DISTINTO   "<>"

OP_DOSPUNTOS  [":"]
OP_IGUALDAD   [""]

LLAVE_A       ["{"]
LLAVE_C       ["}"]
PARENTESIS_A  ["("]
PARENTESIS_C  [")"]
FIN_SENTENCIA [";"]

/*Caracteres de cierre*/

FINSI        "FinSi"
FINMIENTRAS  "FinMientras"
FINALGORITMO "FinAlgoritmo"

/*Caracteres de apertura*/
SI           "Si"|"SI"
ENTONCES     "Entonces"
MIENTRAS     "Mientras"
HACER        "Hacer"
ALGORITMO    "Algoritmo"
INTEGER      "INTEGER"|"Integer"
FLOAT        "Float"|"FLOAT"
ESCRIBIR     "Escribir"
LEER         "Leer"






%%

{OP_DOSPUNTOS}    {printf("\nOP_DOSPUNTOS  (%s)", yytext);}
{FIN_SENTENCIA}   {printf("\nFIN_SENTENCIA (%s)", yytext);}
{CHAR_COMA}       {printf("\nCHAR_COMA (%s)", yytext);}
{CHAR_PUNTOYCOMA} {printf("\nCHAR_PUNTOYCOMA (%s)", yytext);}
{CONST_INTEGER}   { fn_verificarRango(yytext); printf("\nCONST_INTEGER (%s)", yytext);}
{CONST_FLOAT}     {printf("\nCONST_FLOAT (%s)", yytext);}
{CONST_CADENA}    {printf("\nCONST_CADENA (%s)", yytext);}

{OP_SUMA}         {printf("\nOP_SUMA (%s)", yytext);}
{OP_RESTA}        {printf("\nOP_RESTA (%s)", yytext);}
{OP_MULT}         {printf("\nOP_MULT (%s)", yytext);}
{OP_DIV}          {printf("\nOP_DIV (%s)", yytext);}
{OP_IGUAL}        {printf("\nOP_IGUAL (%s)", yytext);}
{OP_MAYOR}        {printf("\nOP_MAYOR (%s)", yytext);}
{OP_MENOR}        {printf("\nOP_MENOR (%s)", yytext);}
{OP_MAYORIGUAL}   {printf("\nOP_MAYORIGUAL (%s)", yytext);}
{OP_MENORIGUAL}   {printf("\nOP_MENORIGUAL (%s)", yytext);}
{OP_COMP_IGUAL}   {printf("\nOP_COMP_IGUAL (%s)", yytext);}
{OP_NEGACION}     {printf("\nOP_NEGACION (%s)", yytext);}
{OP_DISTINTO}     {printf("\nOP_DISTINTO (%s)", yytext);}
{OP_DOSPUNTOS}    {printf("\nOP_DOSPUNTOS (%s)", yytext);}

{LLAVE_A}          {printf("\nLLAVE_A (%s)", yytext);}
{LLAVE_C}          {printf("\nOLLAVE_C (%s)", yytext);}
{PARENTESIS_A}     {printf("\nPARENTESIS_A (%s)", yytext);}
{PARENTESIS_C}     {printf("\nPARENTESIS_C (%s)", yytext);}

{FINSI}            {printf("\nPalabra Reservada FINSI: (%s)", yytext);}
{FINMIENTRAS}      {printf("\nPalabra Reservada FINMIENTRAS: (%s)", yytext);}
{FINALGORITMO}     {printf("\nPalabra Reservada FINALGORITMO: (%s)", yytext);}


{SI}          {printf("\nPalabra Reservada SI: (%s)", yytext);}
{HACER}       {printf("\nPalabra Reservada HACER: (%s)", yytext);}
{ENTONCES}    {printf("\nPalabra Reservada ENTONCES: (%s)", yytext);}
{MIENTRAS}    {printf("\nPalabra Reservada MIENTRAS: (%s)", yytext);}
{INTEGER}     {printf("\nPalabra Reservada INTEGER: (%s)", yytext);}
{FLOAT}       {printf("\nPalabra Reservada FLOAT: (%s)", yytext);}
{ESCRIBIR}    {printf("\nPalabra Reservada ESCRIBIR: (%s)", yytext);}
{ALGORITMO}   {printf("\nPalabra Reservada ALGORITMO: (%s)", yytext);}
{LEER}        {printf("\nPalabra Reservada LEER: (%s)", yytext);}
{FLOAT}       {printf("\nPalabra Reservada FLOAT: (%s)", yytext);}
{INTEGER}     {printf("\nPalabra Reservada INTEGER: (%s)", yytext);}

{INDENTIFICADOR}     {printf("\nINDENTIFICADOR (%s)", yytext);}

"\n"
"\t"
" "
.    yyerror();

%%

int main(int argc, char *argv[]){
    /*lectura de archivo*/
    if( (yyin = fopen(argv[1],"rt")) == NULL ){
        printf("\nNo se puede abrir el TXT: %s\n", argv[1]);
        return 1;
    }
    else{
        printf("\nEl archivo %s se abrio ok.\n", argv[1]);
        yylex();
    }
    printf("\nFLEX termino de leer el archivo %s \n", argv[1]);
    fclose(yyin);
    return 0;
}
int fn_verificarRango(char*ptr){
    int value = atoi(ptr);
    if(value < -32768 || value > 32767 ){
        return yyerror();
    }
    return 0;
}
    int yyerror(void){
        printf("\nError lexico: Invalido: %s, debe revisar...\n",yytext);
        exit(1);
        }

