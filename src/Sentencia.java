public abstract class Sentencia {
    String ident;
    String exp;

    public void traducir() { traducir(1); }
    public void traducir(int nivel) {}

    public String getIdent() { return ident; }
    public String getExp() { return exp; }

    protected String tabs(int nivel) {
        String t = "";
        for (int i = 0; i < nivel; i++) t += "\t";
        return t;
    }
}

