import java.util.List;

public class Caso {
    List<String> etiquetas;
    List<Sentencia> sentencias;

    public Caso(List<String> etiquetas, List<Sentencia> sentencias) {
        this.etiquetas = etiquetas;
        this.sentencias = sentencias;
    }

    public void traducir() {
        for (String etiqueta : etiquetas) {
            System.out.println("\t\tcase " + etiqueta + ":");
        }
        for (Sentencia s : sentencias) {
            System.out.print("\t\t\t");
            s.traducir();
        }
        System.out.println("\t\t\tbreak;");
    }
}
