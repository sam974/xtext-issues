package org.xtext.example.mydsl.ui.tests

import com.google.inject.Inject
import com.google.inject.name.Named
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.Lexer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.LexerUIBindings
import org.junit.runner.RunWith
import org.xtext.example.mydsl.tests.AbstractLexerTest

@RunWith(XtextRunner)
@InjectWith(ApiUiInjectorProvider)
class ApiContentAssistLexerTest extends AbstractLexerTest {
	
	@Inject @Named(LexerUIBindings.CONTENT_ASSIST)
	Lexer lexer

	override lexer() {
		lexer
	}
}