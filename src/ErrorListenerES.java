import org.antlr.v4.runtime.*;

public class ErrorListenerES extends BaseErrorListener {

    @Override
    public void syntaxError(
            Recognizer<?, ?> recognizer,
            Object offendingSymbol,
            int line,
            int charPositionInLine,
            String msg,
            RecognitionException e
    ) {
        String encontrado;
        if (offendingSymbol instanceof Token) {
            Token token = (Token) offendingSymbol;
            encontrado = token.getText();
        } else {
            encontrado = "desconocido";
        }

        String esperado;
        if (e != null) {
            Vocabulary vocab = recognizer.getVocabulary();
            esperado = e.getExpectedTokens().toString(vocab);
        } else {
            esperado = "símbolos válidos";
        }

        String causa = determinarCausa(encontrado, esperado);

        System.err.println(
                "\nError sintáctico en línea " + line +
                        ", columna " + charPositionInLine + ".\n" +
                        "Se esperaba " + esperado +
                        " y se encontró '" + encontrado + "'." +
                        "\nPosible causa: " + causa
        );
    }

    private String determinarCausa(String encontrado, String esperado) {
        if (encontrado.equals("<EOF>")) {
            return "El programa está incompleto, fin de fichero inesperado.";
        }
        if (esperado.contains("';'")) {
            return "Falta el punto y coma al final de la sentencia.";
        }
        if (esperado.contains("'END'")) {
            return "Falta la palabra END para cerrar un bloque.";
        }
        if (esperado.contains("'ENDIF'")) {
            return "Falta ENDIF/ELSE para cerrar un bloque IF.";
        }
        if (esperado.contains("'ENDDO'")) {
            return "Falta ENDDO para cerrar un bloque DO.";
        }
        if (esperado.contains("')'")) {
            return "Falta el paréntesis de cierre.";
        }
        if (esperado.contains("'('")) {
            return "Falta el paréntesis de apertura.";
        }
        if (esperado.contains("'::'")) {
            return "Falta '::' en la declaración de variable o constante.";
        }
        if (esperado.contains("'='")) {
            return "Falta el operador de asignación '='.";
        }
        if (esperado.contains("IDENT")) {
            return "Se esperaba un identificador.";
        }
        if (esperado.contains("NUM_INT_CONST") || esperado.contains("NUM_REAL_CONST")) {
            return "Se esperaba una constante numérica.";
        }
        return "Construcción sintáctica no reconocida.";
    }
}