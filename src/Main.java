import java.io.*;
import org.antlr.v4.runtime.*;

public class Main {
    public static void main(String[] args) {
        try {
            // Construir nombre del fichero de salida
            String inputPath = args[0];
            String outputPath;
            int dotIndex = inputPath.lastIndexOf('.');
            if (dotIndex != -1) {
                outputPath = inputPath.substring(0, dotIndex) + ".c";
            } else {
                outputPath = inputPath + ".c";
            }

            // Redirigir System.out al fichero .c
            PrintStream fileOut = new PrintStream(new FileOutputStream(outputPath));
            System.setOut(fileOut);

            // Preparar el fichero de entrada
            CharStream input = CharStreams.fromFileName(inputPath);
            practicaLexer analex = new practicaLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(analex);
            practicaParser anasint = new practicaParser(tokens);

            anasint.removeErrorListeners();
            anasint.addErrorListener(new ErrorListenerES());
            anasint.prg();

            fileOut.close();

        } catch (IOException e) {
            System.err.println("IO " + e.getMessage());
        } catch (java.lang.RuntimeException e) {
            System.err.println("RUN " + e.getMessage());
        }
    }
}