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

    public void traducir(int nivel) {
        System.out.println(tabs(nivel) + "switch(" + expresion + "){");
        for (Caso c : casos) {
            c.traducir(nivel+1);
        }
        if (hasDefault) {
            System.out.println(tabs(nivel+1) + "default:");
            for (Sentencia s : sentenciasDefault) {
                s.traducir(nivel+2);
            }
        }
        System.out.println(tabs(nivel) + "}");
    }
}
