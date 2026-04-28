import java.util.ArrayList;

public class Programa {
    String ident;
    ArrayList<SentenciaAsignacion> Constlist = new ArrayList<>();
    ArrayList<Subprograma> SubProgList = new ArrayList<>();
    Subprograma main  =  new Subprograma();
    public Programa(){
        main.identificador = "main";
        main.returnType = "INT";
    }
    public void traducir(){

        System.out.println("Program " + ident + ";");

        for(int i = 0; i < Constlist.size(); i++){
            System.out.print("#define ");
            Constlist.get(i).traducirConst();
        }

        // Print main
        System.out.print(main.identificador);
        System.out.print("(");
        for (int i = 0; i < main.parametros.size(); i++){
            SentenciaAsignacion p = main.parametros.get(i);
            System.out.print(p.ident + " ");

        }
        System.out.println(");");
        for(int i = 0; i < SubProgList.size(); i++) {
            SubProgList.get(i).traducir();

        }
    }
}
