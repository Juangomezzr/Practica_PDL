// Generated from E:/VSCode/Procesadores_de_lenguaje/Practica_PDL/src/practica.g4 by ANTLR 4.13.2
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link practicaParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface practicaVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link practicaParser#axioma}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAxioma(practicaParser.AxiomaContext ctx);
}