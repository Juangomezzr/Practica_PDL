import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class Programa {
    String ident;
    ArrayList<SentenciaAsignacion> Constlist = new ArrayList<>();
    ArrayList<Subprograma> SubProgList = new ArrayList<>();

    Subprograma main  =  new Subprograma();
    public Programa(){
        main.identificador = "main";
        main.returnType = "void";
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

        //Declaraciones variables
        for(SentenciaAsignacion s : main.parametros){
            System.out.print("\t");
            s.traducir();
            System.out.println(";");
        }

        //Cuerpo
        for (Sentencia s: main.sentlist){
            System.out.print("\t");
            s.traducir();
        }

        System.out.println("}");

        // Print funcion
        for(int i = 0; i < SubProgList.size(); i++) {
            SubProgList.get(i).traducirFuncion();

        }
    }
    public String procesarParametrosLlamada(String nombreProc, String argsString) {
        // 1. Buscamos el subprograma
        Subprograma sp = null;
        for (Subprograma s : SubProgList) {
            if (s.identificador.equals(nombreProc)) {
                sp = s;
                break;
            }
        }

        if (sp == null) {
            // Devolvemos el string tal cual, SIN paréntesis extra
            return argsString;
        }

        if (argsString == null || argsString.trim().isEmpty()) {
            // Si no hay parámetros, devolvemos cadena vacía
            return "";
        }

        // 2. Separamos los argumentos respetando posibles paréntesis anidados
        ArrayList<String> argumentos = separarArgumentos(argsString);

        // Empezamos vacío, SIN el "(" inicial
        StringBuilder sb = new StringBuilder();

        // 3. Comprobamos uno a uno contra los parámetros definidos
        for (int i = 0; i < argumentos.size(); i++) {
            String arg = argumentos.get(i).trim();

            // Si el parámetro en esta posición tiene un '*' en su ident, necesita '&' en C
            if (i < sp.parametros.size() && sp.parametros.get(i).ident.contains("*")) {
                sb.append("&").append(arg);
            } else {
                sb.append(arg);
            }

            if (i < argumentos.size() - 1) {
                sb.append(", ");
            }
        }

        // Devolvemos directamente, ya no hacemos sb.append(")")
        return sb.toString();
    }
    // Método auxiliar para dividir el string por comas ignorando las interiores de los paréntesis
    private ArrayList<String> separarArgumentos(String str) {
        ArrayList<String> list = new ArrayList<>();
        int parens = 0;
        StringBuilder actual = new StringBuilder();

        for (char c : str.toCharArray()) {
            if (c == '(') parens++;
            else if (c == ')') parens--;

            // Solo cortamos si encontramos una coma y no estamos dentro de un paréntesis
            if (c == ',' && parens == 0) {
                list.add(actual.toString());
                actual.setLength(0);
            } else {
                actual.append(c);
            }
        }
        if (actual.length() > 0) {
            list.add(actual.toString());
        }
        return list;
    }
}
