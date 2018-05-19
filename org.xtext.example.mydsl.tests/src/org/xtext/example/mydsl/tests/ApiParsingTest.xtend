/*
 * generated by Xtext 2.14.0-SNAPSHOT
 */
package org.xtext.example.mydsl.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.xtext.example.mydsl.api.ApiFile

@RunWith(XtextRunner)
@InjectWith(ApiInjectorProvider)
class ApiParsingTest {
	@Inject
	ParseHelper<ApiFile> parseHelper
	
	@Test
	def void loadModel() {
		val result = parseHelper.parse('''
			USETYPES 'test' ;
		''')
		Assert.assertNotNull(result)
		val errors = result.eResource.errors
		Assert.assertTrue('''Unexpected errors: �errors.join(", ")�''', errors.isEmpty)
	}
}
