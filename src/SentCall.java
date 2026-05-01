public class SentCall extends Sentencia{
    String ident;
    String parametros;
    public SentCall(String ident, String parametros){
        this.ident = ident;
        this.parametros = parametros;
    }
    public void traducir(){
        System.out.println(ident + "(" + parametros + ");");
    }
}
