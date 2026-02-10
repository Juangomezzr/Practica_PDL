grammar practica;

axioma: (NUM_REAL_CONST|NUM_INT_CONST|IDENT)+;



//Constantes numericas
NUM_INT_CONST: '-'? [0-9]+;

NUM_REAL_CONST:  NUM_INT_CONST '.' [0-9]+ //Punto fijo
                | NUM_INT_CONST ('e'|'E') NUM_INT_CONST// Exponencial
                | NUM_INT_CONST '.' [0-9]+  ('e'|'E') NUM_INT_CONST; // Mixto
//Identifecadores
IDENT: [a-zA-Z]+ [a-zA-Z0-9_]* ~[ñÑçÇ];



OTHER: . -> skip;


