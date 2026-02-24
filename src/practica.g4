grammar practica;

axioma: (NUM_REAL_CONST|NUM_INT_CONST|IDENT|STRING_CONSTANT|COMMENT|prg)* EOF;

/*

    no
    prg ::= "PROGRAM" IDENT ";"
            dcllist cabecera sentlist "END"
            "PROGRAM" IDENT subproglist

    si
    dcllist ::= ʎ | dcl dcllist

    no
    cabecera ::= ʎ | "INTERFACE" cablist "END" "INTERFACE"
    cablist ::= decproc decsubprog | decfun decsubprog
    decsubprog ::= ʎ | decproc decsubprog | decfun decsubprog
    sentlist ::= sent | sentlist sent


X -> Xa | b

x -> bX'
x' -> aX' | ;
*/

//Partes programa
prg: 'PROGRAM' IDENT ';' dcllist cabecera sentlist 'END' 'PROGRAM' IDENT subproglist;
dcllist: | dcl dcllist; // Recursividad solventada
cabecera:  | 'INTERFACE' cablist 'END' 'INTERFACE'; //No recursividad
cablist: decproc decsubprog | decfun decsubprog;
decsubprog: | decproc decsubprog | decfun decsubprog;
sentlist: sent sentlist_P;
sentlist_P: sent sentlist_P | ;

//Primera zona declaraciones
dcl: defcte | defvar;
defcte: tipo ',' 'PARAMETER' '::' IDENT '=' simpvalue ctelist ';';
ctelist:  | ',' IDENT '=' simpvalue ctelist;
simpvalue: NUM_INT_CONST | NUM_REAL_CONST | STRING_CONSTANT;
defvar: tipo '::' varlist  ';';
tipo: 'INTEGER' | 'REAL' | 'CHARACTER' charlength;
charlength: | '(' NUM_INT_CONST ')';
varlist: IDENT init varlist_P;
varlist_P: ',' IDENT init varlist_P | ;
init: | '=' simpvalue;

//Segunda zona declaraciones
decproc: 'SUBROUTINE' IDENT formal_paramlist dec_s_paramlist 'END' 'SUBROUTINE' IDENT;
formal_paramlist: | '(' nomparamlist ')';
nomparamlist: IDENT | IDENT ',' nomparamlist;
dec_s_paramlist: | tipo ',' 'INTENT' '(' tipoparam ')' IDENT ';' dec_s_paramlist;
tipoparam : 'IN' | 'OUT' | 'INOUT';
decfun : 'FUNCTION' IDENT '(' nomparamlist ')' tipo '::' IDENT ';' dec_f_paramlist 'END' 'FUNCTION' IDENT;
dec_f_paramlist:  tipo ',' 'INTENT' '(' 'IN' ')' IDENT ';' dec_f_paramlist | ;


//Zona de sentencias de programas
sent : IDENT '=' exp ';' | proc_call ';';
exp: factor exp_P;
exp_P: op exp exp_P| ;
op : '+' | '-' | '*' | '/';
factor : simpvalue | '(' exp ')' | IDENT '(' exp explist ')' | IDENT;
explist : ',' exp explist | ;
proc_call : 'CALL' IDENT subpparamlist;
subpparamlist: '(' exp explist ')' | ;

//Zona de implemetenacion de funciones
subproglist:  codproc subproglist | codfun subproglist | ; // vhsuivwhjui
codproc: 'SUBROUTINE' IDENT formal_paramlist dec_s_paramlist dcllist sentlist 'END' 'SUBROUTINE' IDENT;
codfun: 'FUNCTION' IDENT '(' nomparamlist ')' tipo '::' IDENT ';' dec_f_paramlist dcllist sentlist IDENT '=' exp ';' 'END' 'FUNCTION' IDENT;


//Constantes numericas
NUM_INT_CONST: '-'? [0-9]+;

NUM_REAL_CONST:  NUM_INT_CONST '.' [0-9]+ //Punto fijo
                | NUM_INT_CONST ('e'|'E') NUM_INT_CONST// Exponencial
                | NUM_INT_CONST '.' [0-9]+  ('e'|'E') NUM_INT_CONST; // Mixto

//Comentarios
COMMENT: '!' ~[\n\r]* ('\n' | '\r');

//Identifecadores
IDENT: [a-zA-Z]+ [a-zA-Z0-9_]*;

//Strings
STRING_CONSTANT: '\''   (~['\n\r] | '\'\'' )* '\''
                |'"'  (~["\n\r] | '""' )* '"';

OTHER: . -> skip;


