import java.util.ArrayList;
import java.util.List;

public class SentSwitch extends Sentencia{
    String expresion;
    List<Caso> casos;
    List<Sentencia> sentenciasDefault;
    boolean hasDefault = false;

    public SentSwitch(String expresion) {
        this.expresion = expresion;
        this.casos = new ArrayList<>();
        this.sentenciasDefault = new ArrayList<>();
    }

    public void addCaso(Caso c) {
        casos.add(c);
    }

    public void setDefault(List<Sentencia> sentencias) {
        this.sentenciasDefault = sentencias;
        this.hasDefault = true;
    }

    public void traducir() {
        System.out.println("switch(" + expresion + "){");
        for (Caso c : casos) {
            c.traducir();
        }
        if (hasDefault) {
            System.out.println("\t\tdefault:");
            for (Sentencia s : sentenciasDefault) {
                System.out.print("\t\t\t");
                s.traducir();
            }
            System.out.println("\t\t\tbreak;");
        }
        System.out.println("\t\t}");
    }
}
