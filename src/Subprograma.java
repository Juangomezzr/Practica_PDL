import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

public class Subprograma {
    String identificador;
    String returnType;
    ArrayList<SentenciaAsignacion> parametros = new ArrayList<>();
    ArrayList<Sentencia> sentlist = new ArrayList<>();
    String returnExp;

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


        for(Sentencia s: sentlist){
            System.out.print("\t");
            s.traducir();
        }
        if (!returnType.equals("void")) {
            System.out.println("\t"+"return "  +returnExp+ ";");
        }

        System.out.println("}");
    }
}
