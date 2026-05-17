grammar practica;

@parser::members{
private Subprograma subprog = new Subprograma();
private Programa program = new Programa();
}

prg: 'PROGRAM' IDENT{program.ident = $IDENT.text;}  ';'
    dcllist[1]
    cabecera
    sentlist {program.main.sentlist.addAll($sentlist.list);}
    'END' 'PROGRAM' IDENT
    subproglist[0]
    {program.traducir();};

//Partes programa
dcllist[int is_main]: | dcl[$is_main] dcllist[$is_main];
cabecera:  | 'INTERFACE' cablist 'END' 'INTERFACE';
cablist: decproc {program.SubProgList.add(subprog);subprog = new Subprograma();} decsubprog | decfun {program.SubProgList.add(subprog);subprog = new Subprograma();} decsubprog;
decsubprog: | decproc {program.SubProgList.add(subprog);subprog = new Subprograma();} decsubprog | decfun {program.SubProgList.add(subprog);subprog = new Subprograma();} decsubprog;

sentlist returns [ArrayList<Sentencia> list]: {$list = new ArrayList();} sent {$list.add($sent.value);} sentlist_P {$list.addAll($sentlist_P.list);};
sentlist_P returns [ArrayList<Sentencia> list]: {$list = new ArrayList();} sent {$list.add($sent.value);} tail=sentlist_P {$list.addAll($tail.list);}| {$list = new ArrayList();};

//Primera zona declaraciones

dcl[int is_main] : tipo def_P[$is_main,$tipo.text] ;
def_P[int is_main,String t]: defcte[$t]  | defvar[$is_main,$t];
defcte[String t]: ',' 'PARAMETER' '::' IDENT   '=' simpvalue {program.Constlist.add(new SentenciaAsignacion($IDENT.text,$t,$simpvalue.value));} ctelist[$t] ';' ;
ctelist[String t]:  | ',' IDENT  '=' simpvalue {program.Constlist.add(new SentenciaAsignacion($IDENT.text,$t,$simpvalue.value));} ctelist[$t]  ;
simpvalue returns[String value]:
    NUM_INT_CONST { $value = $NUM_INT_CONST.text;}
    |NUM_INT_CONST_B { $value = $NUM_INT_CONST_B.text;}
    |NUM_INT_CONST_H { $value = $NUM_INT_CONST_H.text;}
    |NUM_INT_CONST_O { $value = $NUM_INT_CONST_O.text;}
    |NUM_REAL_CONST { $value = $NUM_REAL_CONST.text;}
    |STRING_CONSTANT { $value = $STRING_CONSTANT.text.replace("'", "\"");};
defvar[int is_main,String t]: '::' varlist[$is_main,$t]  ';';
tipo returns[String text]: 'INTEGER' {$text = "int";} | 'REAL' {$text = "float";} | 'CHARACTER' {$text = "char";} charlength {$text += $charlength.value; } ;
charlength returns[String value]: {$value = "";} | '(' NUM_INT_CONST ')' {$value = "["+ $NUM_INT_CONST.text+"]";};
varlist[int is_main,String t]: IDENT  init {if(is_main == 1){program.main.parametros.add(new SentenciaAsignacion($IDENT.text,$t,$init.value));}}  varlist_P ;
varlist_P: ',' IDENT init varlist_P  | ;
init returns[String value]: | '=' simpvalue{$value = $simpvalue.value;};

//Segunda zona declaraciones
decproc:  'SUBROUTINE'{subprog.returnType = "void";}  IDENT {subprog.identificador = $IDENT.text;}  formal_paramlist dec_s_paramlist[0] 'END' 'SUBROUTINE' IDENT ;
formal_paramlist: | '(' nomparamlist ')';

nomparamlist: IDENT { subprog.parametros.add(new SentenciaAsignacion($IDENT.text)); } nomparamlist_P;
nomparamlist_P: | ',' nomparamlist;

dec_s_paramlist[int i]: | tipo {subprog.parametros.get(i).tipo = $tipo.text;} ',' 'INTENT' '(' tipoparam ')' IDENT ';' dec_s_paramlist[$i +1];
tipoparam : 'IN' | 'OUT' | 'INOUT';
decfun : 'FUNCTION'  IDENT {subprog.identificador = $IDENT.text;} '(' nomparamlist ')' tipo {subprog.returnType = $tipo.text;} '::' IDENT';' dec_f_paramlist[0] 'END' 'FUNCTION' IDENT;
dec_f_paramlist[int i]:  tipo {subprog.parametros.get(i).tipo = $tipo.text;} ',' 'INTENT' '(' 'IN' ')' IDENT ';' dec_f_paramlist[$i + 1] | ;


//Zona de sentencias de programas
sent returns[Sentencia value]:
        IDENT '=' exp ';' {$value = new SentExp($IDENT.text, $exp.value);}
       | proc_call ';' {$value = $proc_call.value;}
       | 'IF' '(' expcond ')' if_P[new SentIf($expcond.value)] {$value = $if_P.value;}
       | 'DO' do_P {$value = $do_P.value;}
       | 'SELECT' 'CASE' '(' exp ')' casos[new SentSwitch($exp.value)] 'END' 'SELECT' {$value = $casos.value;};

if_P[SentIf heredada] returns[SentIf value]:
        sent {$heredada.sentencias.add($sent.value); $value = $heredada;}
        | 'THEN' sentlist {$heredada.sentencias.addAll($sentlist.list);} if_PP[$heredada] {$value = $if_PP.value;};

if_PP[SentIf heredada] returns[SentIf value]:
    'ENDIF' {$value = $heredada;}
    | 'ELSE' {$heredada.setElse(true);} sentlist {$heredada.sentenciasElse.addAll($sentlist.list);} 'ENDIF' {$value = $heredada;};

do_P returns[SentenciaBucle value]:
    'WHILE' '(' expcond ')' {$value = new SentenciaBucle($expcond.value);} sentlist {$value.sentencias.addAll($sentlist.list);} 'ENDDO'
    | IDENT '=' i=doval ',' f=doval ',' s=doval  {$value = new SentenciaBucle($IDENT.text, $i.value, $f.value, $s.value);} sentlist {$value.sentencias.addAll($sentlist.list);} 'ENDDO';

expcond returns[String value]:
    factorcond expcond_P {$value = $factorcond.value + $expcond_P.value;};

expcond_P returns[String value]:
    oplog factorcond expcond_P {$value = $oplog.value + $factorcond.value + $expcond_P.value;}
    | {$value = "";};

oplog returns[String value] :
    '.OR.' {$value = " || ";}
    | '.AND.' {$value = " && ";}
    | '.EQV.' {$value = " !^ " ;}
    | '.NEQV.' {$value = " ^ ";};

factorcond returns[String value] :
    id1=exp opcomp id2=exp {$value = $id1.value + $opcomp.value + $id2.value;}
    | '(' expcond ')' {$value = "(" + $expcond.value + ")";}
    | '.NOT.' factorcond {$value= "!" + $factorcond.value;}
    | '.TRUE.' {$value = "1";}
    |'.FALSE.' {$value= "0";};

opcomp returns[String value]: '<' {$value = " < ";}
    | '>' {$value = " > ";}
    | '<=' {$value = " <= ";}
    | '>=' {$value = " >= ";}
    | '==' {$value = " == ";}
    | '/=' {$value = " != ";};

doval returns[String value] :
      NUM_INT_CONST {$value = $NUM_INT_CONST.text;}
      | IDENT {$value = $IDENT.text;};

casos[SentSwitch heredada] returns[SentSwitch value]:
    'CASE' casos_P[$heredada] {$value = $casos_P.value;};

casos_P[SentSwitch heredada] returns[SentSwitch value]:
    '(' etiquetas ')' sentlist {$heredada.addCaso(new Caso($etiquetas.list, $sentlist.list));} casos_PP[$heredada] {$value = $casos_PP.value;}
    | 'DEFAULT' sentlist {$heredada.setDefault($sentlist.list); $value = $heredada;}
    | {$value = $heredada;};

casos_PP[SentSwitch heredada] returns[SentSwitch value]:
    'CASE' casos_P[$heredada] {$value = $casos_P.value;}
    | {$value = $heredada;};

etiquetas returns[ArrayList<String> list]:
    {$list = new ArrayList<>();} simpvalue {$list.add($simpvalue.value);} etiquetas_P[$list] {$list = $etiquetas_P.list;}
    | ':' simpvalue {$list.add("<= " + $simpvalue.value);};

etiquetas_P[ArrayList<String> heredada] returns[ArrayList<String> list]:
    listaetiqetas[$heredada] {$list = $listaetiqetas.list;}
    | ':' etiquetas_PP {$heredada.set(0, $heredada.get(0) + " .. " + $etiquetas_PP.value); $list = $heredada;}
    | {$list = $heredada;};

etiquetas_PP returns[String value]:
    simpvalue {$value = $simpvalue.value;}
    | {$value = "";};

listaetiqetas[ArrayList<String> heredada] returns[ArrayList<String> list]:
    ',' simpvalue {$heredada.add($simpvalue.value);} listaetiqetas[$heredada] {$list = $listaetiqetas.list;}
    | {$list = $heredada;};

exp returns[String value] : factor exp_P {$value = $factor.value + $exp_P.value;};

exp_P returns[String value]:
     op factor exp_P {$value = $op.value + $factor.value + $exp_P.value;}
     | {$value = "";} ;

op returns[String value]:
    '+'{$value = " + ";}
    | '-' {$value = " - ";}
    | '*' {$value = " * ";}
    | '/' {$value = " / ";};

factor returns[String value]:
    simpvalue {$value = $simpvalue.value;}
    | '(' exp ')'{$value = "(" + $exp.value + ")";}
    | IDENT factor_P {$value = $IDENT.text + $factor_P.value;};

factor_P returns[String value] :
    '(' exp explist ')'{$value = "(" + $exp.value + $explist.value + ")";}
    |{$value = "" ;} ;


explist returns[String value] :
    ',' exp explist {$value = "," + $exp.value + $explist.value;}
    |{$value = "";} ;


proc_call returns[Sentencia value]: 'CALL' IDENT subpparamlist {$value = new SentCall($IDENT.text, $subpparamlist.value);};
subpparamlist returns[String value]:
    '(' exp explist ')' {$value = $exp.value + $explist.value;}
    | {$value = "";};

//Zona de implemetenacion de funciones
subproglist[int i]:  codproc[i] subproglist[i+1] | codfun[i] subproglist[i+1] | ;
codproc[int i]:  'SUBROUTINE' IDENT formal_paramlist dec_s_paramlist[0] dcllist[0] sentlist {program.SubProgList.get($i).sentlist = $sentlist.list;}   'END' 'SUBROUTINE' IDENT;
codfun[int i]: 'FUNCTION' IDENT '(' nomparamlist ')' tipo '::' IDENT ';'dec_f_paramlist[0] dcllist[0] sentlist{program.SubProgList.get($i).sentlist = $sentlist.list;}  IDENT '=' exp {program.SubProgList.get($i).returnExp = $exp.value;}';' 'END' 'FUNCTION' IDENT;


//Constantes numericas
NUM_INT_CONST: '-'? [0-9]+ ;

//OPCIONAL NOTABLE
NUM_INT_CONST_B: 'b´'[01]+'´';
NUM_INT_CONST_O: 'o´'[0-7]+'´';
NUM_INT_CONST_H: 'z´'[0-9A-F]+'´';


//Numeros Reales
NUM_REAL_CONST:  NUM_INT_CONST '.' [0-9]+ //Punto fijo
                | NUM_INT_CONST ('e'|'E') NUM_INT_CONST// Exponencial
                | NUM_INT_CONST '.' [0-9]+  ('e'|'E') NUM_INT_CONST; // Mixto
//Comentarios
COMMENT: '!' ~[\n\r]* ('\n' | '\r') -> skip;

//Identifecadores
IDENT: [a-zA-Z]+ [a-zA-Z0-9_]*;

//Strings
STRING_CONSTANT: '\''   (~['\n\r] | '\'\'' )* '\''
                |'"'  (~["\n\r] | '""' )* '"';

OTHER: . -> skip;