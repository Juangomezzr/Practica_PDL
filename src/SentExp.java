import java.util.Objects;

public class SentExp extends Sentencia{
    private String ident;
    private String exp;

    public SentExp(String ident, String exp){
        this.ident = ident;
        this.exp = exp;
    }
    public void traducir(){
        System.out.println(ident + " = " + exp + ";");
    }

    public String getIdent() {
        return ident;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        SentExp sentExp = (SentExp) o;
        return Objects.equals(ident, sentExp.ident) && Objects.equals(exp, sentExp.exp);
    }

    @Override
    public int hashCode() {
        return Objects.hash(ident, exp);
    }

    public void setIdent(String ident) {
        this.ident = ident;
    }

    public String getExp() {
        return exp;
    }

    public void setExp(String exp) {
        this.exp = exp;
    }
}
