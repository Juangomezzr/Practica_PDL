public class SentenciaAsignacion extends Sentencia{
    String ident;
    String tipo;
    String exp;
    public void traducirConst(){
        System.out.println(ident + " " + exp );
    }
    public void traduciParam(){
        System.out.print(tipo + "  " + ident + " " );
    }
    public SentenciaAsignacion(String ident, String tipo, String exp){
        this.ident = ident;
        this.tipo = tipo;
        this.exp = exp;
    }

}
