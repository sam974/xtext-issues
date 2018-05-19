package org.xtext.example.mydsl.ui.tests

import com.google.inject.Inject
import com.google.inject.name.Named
import org.eclipse.xtext.parser.antlr.Lexer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.LexerUIBindings
import org.junit.runner.RunWith
import org.xtext.example.mydsl.tests.AbstractLexerTest

@RunWith(XtextRunner)
@InjectWith(ApiUiInjectorProvider)
class ApiHighlightingLexerTest extends AbstractLexerTest {
	
	@Inject @Named(LexerUIBindings.HIGHLIGHTING)
	Lexer lexer

	override lexer() {
		lexer
	}
}