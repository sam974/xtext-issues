package org.xtext.example.mydsl.tests

import org.antlr.runtime.ANTLRStringStream
import org.antlr.runtime.Lexer
import org.antlr.runtime.Token
import org.junit.Test

abstract class AbstractLexerTest {
	
	@Test(timeout = 2000) def test001() { "USETYPES".lex }
	@Test(timeout = 2000) def test002() { "USETYPES$".lex }
	
	private def lex(CharSequence text) {
		lexer.setCharStream(new ANTLRStringStream(text.toString))
		while (true) {
			val token = lexer.nextToken
			if (token == Token.EOF_TOKEN)
				return
		}
	}

	def protected abstract Lexer lexer()
}