grammar practica;

axioma: (NUM_REAL_CONST|NUM_INT_CONST|IDENT|STRING_CONSTANT|COMMENT|prg|NUM_INT_CONST_B | NUM_INT_CONST_O | NUM_INT_CONST_H)* EOF;

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

//Opcional Notable

expcond : factorcond expcond_P;
expcond_P : oplog expcond expcond_P | ;
oplog : '.OR.' | '.AND.' | '.EQV.' | '.NEQV.';
factorcond : exp opcomp exp
    | '(' expcond ')' | '.NOT.' factorcond
    | '.TRUE.' | '.FALSE.';

opcomp : '<' | '>' | '<=' | '>=' | '==' | '/=';

doval : NUM_INT_CONST | IDENT;

casos : 'CASE' '(' etiquetas ')' sentlist casos
    | 'CASE' 'DEFAULT' sentlist
    | ;

etiquetas : simpvalue listaetiqetas
    | simpvalue ':' simpvalue
    | ':' simpvalue
    | simpvalue ':';

listaetiqetas : ',' simpvalue listaetiqetas | ;

//Partes programa
prg: 'PROGRAM' IDENT ';' dcllist cabecera sentlist 'END' 'PROGRAM' IDENT subproglist;
dcllist: | dcl dcllist; // Recursividad solventada
cabecera:  | 'INTERFACE' cablist 'END' 'INTERFACE'; //No recursividad
cablist: decproc decsubprog | decfun decsubprog;
decsubprog: | decproc decsubprog | decfun decsubprog;
sentlist: sent sentlist_P;
sentlist_P: sent sentlist_P | ;

//Primera zona declaraciones
// eliminamos dcl: defcte | defvar; como los directores coincidían factorizamos tipo en dcl y creamos una nueva
//regla def_P con las funciones sin tipo
dcl : tipo def_P;
def_P: defcte | defvar;
defcte:  ',' 'PARAMETER' '::' IDENT '=' simpvalue ctelist ';';
ctelist:  | ',' IDENT '=' simpvalue ctelist;
simpvalue: NUM_INT_CONST|NUM_INT_CONST_B|NUM_INT_CONST_H|NUM_INT_CONST_O| NUM_REAL_CONST | STRING_CONSTANT;
defvar: '::' varlist  ';';
tipo: 'INTEGER' | 'REAL' | 'CHARACTER' charlength;
charlength: | '(' NUM_INT_CONST ')';
varlist: IDENT init varlist_P;
varlist_P: ',' IDENT init varlist_P | ;
init: | '=' simpvalue;

//Segunda zona declaraciones
decproc: 'SUBROUTINE' IDENT formal_paramlist dec_s_paramlist 'END' 'SUBROUTINE' IDENT;
formal_paramlist: | '(' nomparamlist ')';


//nomparamlist: IDENT | IDENT ',' nomparamlist; factorizado condiciones LL1

nomparamlist: IDENT nomparamlist_P;
nomparamlist_P: | ',' nomparamlist;


dec_s_paramlist: | tipo ',' 'INTENT' '(' tipoparam ')' IDENT ';' dec_s_paramlist;
tipoparam : 'IN' | 'OUT' | 'INOUT';
decfun : 'FUNCTION' IDENT '(' nomparamlist ')' tipo '::' IDENT ';' dec_f_paramlist 'END' 'FUNCTION' IDENT;
dec_f_paramlist:  tipo ',' 'INTENT' '(' 'IN' ')' IDENT ';' dec_f_paramlist | ;


//Zona de sentencias de programas
sent : IDENT '=' exp ';' | proc_call ';'
       | 'IF' '(' expcond ')' sent
       | 'IF' '(' expcond ')' 'THEN' sentlist 'ENDIF'
       | 'IF' '(' expcond ')' 'THEN' sentlist 'ELSE' sentlist 'ENDIF'
       | 'DO' 'WHILE' '(' expcond ')' sentlist 'ENDDO'
       | 'DO' IDENT '=' doval ',' doval ',' doval sentlist 'ENDDO'
       | 'SELECT' 'CASE' '(' exp ')' casos 'END' 'SELECT' ;

exp: factor exp_P;
exp_P: op factor exp_P| ; // factorizacion para que el siguiente de exp no incluya op
op : '+' | '-' | '*' | '/';
factor : simpvalue | '(' exp ')' | IDENT factor_P;
factor_P : '(' exp explist ')' | ; //explicar que factor prima se ha creado para satisfacer las condiciones de ll(1)
explist : ',' exp explist | ;
proc_call : 'CALL' IDENT subpparamlist;
subpparamlist: '(' exp explist ')' | ;

//Zona de implemetenacion de funciones
subproglist:  codproc subproglist | codfun subproglist | ; // vhsuivwhjui
codproc: 'SUBROUTINE' IDENT formal_paramlist dec_s_paramlist dcllist sentlist 'END' 'SUBROUTINE' IDENT;
codfun: 'FUNCTION' IDENT '(' nomparamlist ')' tipo '::' IDENT ';' dec_f_paramlist dcllist sentlist IDENT '=' exp ';' 'END' 'FUNCTION' IDENT;


//Constantes numericas
NUM_INT_CONST: '-'? [0-9]+;

//OPCIONAL NOTABLE
NUM_INT_CONST_B: 'b´'[01]+'´';
NUM_INT_CONST_O: 'o´'[0-7]+'´';
NUM_INT_CONST_H: 'z´'[0-9A-F]+'´';






//Numeros Reales
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


