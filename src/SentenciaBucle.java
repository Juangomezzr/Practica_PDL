import java.util.ArrayList;
import java.util.List;

public class SentenciaBucle extends Sentencia{
    String condicion;
    String varControl;
    String inicio, fin, paso;
    boolean isFor;
    List<Sentencia> sentencias;

    public SentenciaBucle(String condicion){
        this.condicion = condicion;
        this.isFor = false;
        sentencias = new ArrayList<>();
    }

    public SentenciaBucle(String varControl, String inicio, String fin, String paso){
        this.varControl = varControl;
        this.inicio = inicio;
        this.fin = fin;
        this.paso = paso;
        this.isFor = true;
        sentencias = new ArrayList<>();
    }

    public void traducir(){
        if(isFor){
            System.out.println("for(" + varControl + " = " + inicio + "; "
                    + varControl + " != " + fin + "; "
                    + varControl + " = " + varControl + " + " + paso + "){");
        } else {
            System.out.println("while(" + condicion + "){");
        }
        for(Sentencia s : sentencias){
            System.out.print("\t\t");
            s.traducir();
        }
        System.out.println("\t}");
    }
}
