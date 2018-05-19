package org.xtext.example.mydsl.tests

import com.google.inject.Inject
import com.google.inject.name.Named
import org.eclipse.xtext.parser.antlr.Lexer
import org.eclipse.xtext.parser.antlr.LexerBindings
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(ApiInjectorProvider)
class ApiLexerTest extends AbstractLexerTest {
	
	@Inject @Named(LexerBindings.RUNTIME)
	Lexer lexer
	
	override lexer() {
		lexer
	}

}