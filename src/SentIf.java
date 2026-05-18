import java.util.ArrayList;
import java.util.List;

public class SentIf extends Sentencia{
    String condicion;
    List<Sentencia> sentencias;
    List<Sentencia> sentenciasElse;
    boolean isElse = false;

    public SentIf(String condicion) {
        this.condicion = condicion;
        sentencias = new ArrayList<>();
        sentenciasElse = new ArrayList<>();
    }

    public boolean isElse() {
        return isElse;
    }

    public void setElse(boolean anElse) {
        isElse = anElse;
    }

    public void traducir(int nivel){
        System.out.println(tabs(nivel) + "if("+condicion+"){");
        for(Sentencia s: sentencias){
            s.traducir(nivel+1);
        }
        if(!isElse){
            System.out.println(tabs(nivel) + "}");
        }else{
            System.out.println(tabs(nivel) + "} else {");
            for(Sentencia s: sentenciasElse){
                s.traducir(nivel+1);
            }
            System.out.println(tabs(nivel) + "}");

        }

    }

}
