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

        System.err.println(
                "Error sintáctico en línea " + line +
                        ", columna " + charPositionInLine + ".\n" +
                        "Se esperaba " + esperado +
                        " y se encontró '" + encontrado + "'."
        );
    }
}