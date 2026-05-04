import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

public class Subprograma {
    String identificador;
    String returnType;
    ArrayList<SentenciaAsignacion> parametros = new ArrayList<>();
    ArrayList<Sentencia> sentlist = new ArrayList<>();

    void traducirCabecera(){
        System.out.print(returnType + " ");
        System.out.print(identificador);
        System.out.print("( ");
        for (SentenciaAsignacion s: parametros){
            s.traduciParam();
        }
        System.out.println(");");
    }

    void traducirFuncion(){
        System.out.print("\n" + returnType + " ");
        System.out.print(identificador);
        System.out.print("( ");
        for (SentenciaAsignacion s: parametros){
            s.traduciParam();
        }
        System.out.println(") {");

        Iterator<Sentencia> it = sentlist.iterator();
        while(it.hasNext()){
            Sentencia s = it.next();
            System.out.print("\t");

            if (!returnType.equals("void") && !it.hasNext()) {
                System.out.println("return " + s.getExp() + ";");
            }else {
                s.traducir();
            }
        }

        System.out.println("}");
    }
}
