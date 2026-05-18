public class SentCall extends Sentencia{
    String ident;
    String parametros;
    public SentCall(String ident, String parametros){
        this.ident = ident;
        this.parametros = parametros;
    }
    public void traducir(int nivel){
        System.out.println(tabs(nivel) + ident + "(" + parametros + ");");
    }
}
