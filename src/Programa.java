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

        // Print cabeceras
        System.out.print("\n");
        for(int i = 0; i < SubProgList.size(); i++) {
            SubProgList.get(i).traducirCabecera();
        }

        // Print main
        System.out.print("\nvoid ");
        System.out.print(main.identificador);
        System.out.print(" ( void ) ");
        System.out.println("{");

        // Definicion de programa


        System.out.println("\n}");

        // Print funcion
        System.out.print("\n");
        for(int i = 0; i < SubProgList.size(); i++) {
            SubProgList.get(i).traducirFuncion();
        }
    }
}
