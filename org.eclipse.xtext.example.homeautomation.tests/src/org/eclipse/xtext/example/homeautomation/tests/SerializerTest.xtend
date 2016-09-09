package org.eclipse.xtext.example.homeautomation.tests

import java.io.StringWriter
import javax.inject.Inject
import org.eclipse.xtext.example.homeautomation.ruleEngine.Device
import org.eclipse.xtext.example.homeautomation.ruleEngine.Model
import org.eclipse.xtext.example.homeautomation.ruleEngine.RuleEngineFactory
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.resource.SaveOptions
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.xbase.XbaseFactory
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import javax.inject.Provider
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.emf.common.util.URI

@RunWith(XtextRunner)
@InjectWith(RuleEngineInjectorProvider)
class SerializerTest extends Assert {
	@Inject extension ParseHelper<Model>
	@Inject extension ValidationTestHelper
	@Inject ISerializer serializer
	RuleEngineFactory factory = RuleEngineFactory.eINSTANCE
	XbaseFactory xbase = XbaseFactory.eINSTANCE
	@Inject Provider<XtextResourceSet> rsProvider
	
	@Test
	def test() {
		
		val model = factory.createModel
		val rs = rsProvider.get
		
		model.declarations += factory.createDevice => [
			name = "Window"
			states += #["open","closed"].map[s|factory.createState => [name=s]]
		]
		
		model.declarations += factory.createDevice => [
			name = "Heater"
			states += #["on","off"].map[s|factory.createState => [name=s]]
		]
		
		model.declarations += factory.createRule => [
			description = "Save energy"
			deviceState = (model.declarations.head as Device).states.head
			thenPart = xbase.createXBlockExpression => [
				expressions += xbase.createXVariableDeclaration => [
					name = "msg"
					right = xbase.createXStringLiteral => [ value = "Another penny to the piggy bank!" ]
				]
				expressions += xbase.createXVariableDeclaration => [
					name = "x"
					right = xbase.createXNumberLiteral => [ value = "1" ]
				]
			]
		]
		
		val resource = rs.createResource(URI.createURI("heater.rules"))
		resource.contents += model
		
		val sw = new StringWriter
		serializer.serialize(model, sw, SaveOptions.newBuilder.format.options)
		assertEquals('''
			Device Window can be open, closed
			Device Heater can be on, off
			Rule "Save energy" when Window.open then
				val msg = "Another penny to the piggy bank!"
				val x = 1
		'''.toString, sw.toString)
	}
	
}