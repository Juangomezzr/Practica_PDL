import java.util.List;

public class Caso {
    List<Etiqueta> etiquetas;
    List<Sentencia> sentencias;

    public Caso(List<Etiqueta> etiquetas, List<Sentencia> sentencias) {
        this.etiquetas = etiquetas;
        this.sentencias = sentencias;
    }

    public void traducir() {
        for (Etiqueta e : etiquetas) {
            System.out.println("\t\tcase " + e.traducir() + ":");
        }
        for (Sentencia s : sentencias) {
            System.out.print("\t\t\t");
            s.traducir();
        }
        System.out.println("\t\t\tbreak;");
    }
}
