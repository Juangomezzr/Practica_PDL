import java.util.ArrayList;

public class Subprograma {
    String identificador;
    String returnType;
    ArrayList<SentenciaAsignacion> parametros = new ArrayList<>();
    ArrayList<Sentencia> sentlist = new ArrayList<>();

    void traducir(){
        System.out.print(returnType + " ");
        System.out.print(identificador);
        System.out.print("( ");
        for (SentenciaAsignacion s: parametros){
            s.traduciParam();
        }
        System.out.println(");");
    }


}
