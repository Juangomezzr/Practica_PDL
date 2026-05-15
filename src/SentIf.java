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

    public void traducir(){
        System.out.println("if("+condicion+"){");
        for(Sentencia s: sentencias){
            System.out.print("\t\t");
            s.traducir();
        }
        System.out.print("\t} ");
        if(!isElse){
            System.out.println(" ");
        }else{
            System.out.println("else {");
            for(Sentencia s: sentenciasElse){
                System.out.print("\t\t");
                s.traducir();
            }
            System.out.println("\t}");

        }

    }

}
