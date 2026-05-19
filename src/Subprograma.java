import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;
import java.util.stream.Collectors;

public class Subprograma {
    String identificador;
    String returnType;
    ArrayList<SentenciaAsignacion> parametros = new ArrayList<>();
    ArrayList<Sentencia> sentlist = new ArrayList<>();
    String returnExp;

    void traducirCabecera(){
        System.out.print(returnType + " ");
        System.out.print(identificador);
        System.out.print("(");

        Iterator<SentenciaAsignacion> it = parametros.iterator();
        while (it.hasNext()) {
            SentenciaAsignacion s = it.next();
            s.traduciParam();
            if (it.hasNext()) {
                System.out.print(", ");
            }
        }

        System.out.println(");");
    }

    void traducirFuncion(){
        System.out.print("\n" + returnType + " ");
        System.out.print(identificador);
        System.out.print("(");


        Iterator<SentenciaAsignacion> it = parametros.iterator();
        while (it.hasNext()) {
            SentenciaAsignacion s = it.next();
            s.traduciParam();
            if (it.hasNext()) {
                System.out.print(", ");
            }
        }

        System.out.println(") {");


        Set<String> punteros = parametros.stream()
                .filter(p -> p.ident.contains("*")) // 1. Filtramos: solo pasan los que tienen "*"
                .map(p -> p.ident)                  // 2. Extraemos: nos quedamos solo con el string 'ident'
                .collect(Collectors.toSet());


        for(Sentencia s: sentlist){
            if(s instanceof SentExp && punteros.contains("*" + s.getIdent())){
                s.traducir(1, true);  // true = es puntero
            } else {
                s.traducir(1);
            }
        }
        if (!returnType.equals("void")) {
            System.out.println("\t"+"return "  +returnExp+ ";");
        }

        System.out.println("}");
    }
}
