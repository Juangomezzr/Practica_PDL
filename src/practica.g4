grammar practica;

axioma: (NUM_REAL_CONST|NUM_INT_CONST|IDENT|STRING_CONSTANT|COMMENT)* EOF;

/*
    prg ::= "PROGRAM" IDENT ";"
            dcllist cabecera sentlist "END"
            "PROGRAM" IDENT subproglist
    dcllist ::= ʎ | dcl dcllist


    cabecera ::= ʎ | "INTERFACE" cablist "END" "INTERFACE"
    cablist ::= decproc decsubprog | decfun decsubprog
    decsubprog ::= ʎ | decproc decsubprog | decfun decsubprog
    sentlist ::= sent | sentlist sent



X -> Xa | b

x -> bX'
x' -> aX' | ;





*/


cabecera: 'cabecera';









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


