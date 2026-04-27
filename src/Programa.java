import java.util.ArrayList;

public class Programa {
    String ident;
    ArrayList<SentenciaAsignacion> Constlist = new ArrayList<>();
    ArrayList<Subprograma> SubProgList = new ArrayList<>();
    Subprograma main  =  new Subprograma();
    public void traducir(){

        main.identificador = "main";

        System.out.println("Program " + ident + ";");

        for(int i = 0; i < Constlist.size(); i++){
            System.out.print("#define ");
            Constlist.get(i).traducirConst();
        }

        main.traducir();

        for(int i = 0; i < SubProgList.size(); i++) {
            SubProgList.get(i).traducir();

        }
    }
}
