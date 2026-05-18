import java.util.List;

public class Caso {
    List<Etiqueta> etiquetas;
    List<Sentencia> sentencias;

    public Caso(List<Etiqueta> etiquetas, List<Sentencia> sentencias) {
        this.etiquetas = etiquetas;
        this.sentencias = sentencias;
    }

    public void traducir(int nivel) {
        for (Etiqueta e : etiquetas) {
            System.out.println(tabs(nivel) + "case " + e.traducir() + ":");
        }
        for (Sentencia s : sentencias) {
            s.traducir(nivel+1);
        }
        System.out.println(tabs(nivel) + "break;");
    }

    private String tabs(int nivel) {
        String t = "";
        for (int i = 0; i < nivel; i++) t += "\t";
        return t;
    }
}
