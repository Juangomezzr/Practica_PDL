public class Etiqueta {
    String inicio;
    String fin;      // null si no es rango
    boolean esRango;

    // Valor simple
    public Etiqueta(String valor) {
        this.inicio = valor;
        this.esRango = false;
    }

    // Rango
    public Etiqueta(String inicio, String fin) {
        this.inicio = inicio;
        this.fin = fin;
        this.esRango = true;
    }

    public String traducir() {
        if (esRango) {
            if (inicio == null && fin == null) return "";        // : sin nada
            if (inicio == null) return "< " + fin;             // : valor
            if (fin == null || fin.isEmpty()) return "> " + inicio;  // valor :
            return inicio + " to " + fin;                       // valor : valor
        }
        return inicio;
    }
}