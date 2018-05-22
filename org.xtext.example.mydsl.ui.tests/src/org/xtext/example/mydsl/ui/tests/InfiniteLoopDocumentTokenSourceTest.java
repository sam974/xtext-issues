/*******************************************************************************
 * Copyright (c) 2010 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.xtext.example.mydsl.ui.tests;

import java.util.ArrayList;

import org.eclipse.jface.text.Document;
import org.eclipse.jface.text.DocumentEvent;
import org.eclipse.jface.text.IDocumentListener;
import org.eclipse.jface.text.IRegion;
import org.eclipse.xtext.parser.antlr.Lexer;
import org.eclipse.xtext.ui.editor.model.DocumentTokenSource;
import org.eclipse.xtext.ui.editor.model.ILexerTokenRegion;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.xtext.example.mydsl.parser.antlr.internal.InternalApiLexer;

import com.google.common.collect.Lists;
import com.google.inject.Provider;

/**
 * @author Samuel Judith - Initial contribution and API
 */
public class InfiniteLoopDocumentTokenSourceTest extends Assert {
	
	
	private DocumentTokenSource tokenSource;
	private Document document;
	
	@Before
	public void setUp() throws Exception {
		tokenSource = new DocumentTokenSource();
		tokenSource.setLexer(new Provider<Lexer>() {
			@Override
			public Lexer get() {
				return new InternalApiLexer();
			}
		});
		document = new Document("");
		document.addDocumentListener(new IDocumentListener() {
			
			@Override
			public void documentChanged(DocumentEvent event) {
				tokenSource.updateStructure(event);
			}
			
			@Override
			public void documentAboutToBeChanged(DocumentEvent event) {
			}
		});
	}
	
	
	@Test
	// https://github.com/eclipse/xtext-eclipse/issues/678
	public void testFrozenInfiniteLoop() throws Exception {
		document.set("USETYPES   ");
		IRegion region = tokenSource.getLastDamagedRegion();
		ArrayList<ILexerTokenRegion> list = Lists.newArrayList(tokenSource.getTokenInfos());
		document.replace(9, 1, "$");
		IRegion region2 = tokenSource.getLastDamagedRegion();
		
		System.err.println("################# This line is neved reached!! ################");
		
		assertTrue(!region.equals(region2));
		ArrayList<ILexerTokenRegion> list2 = Lists.newArrayList(tokenSource.getTokenInfos());
		assertTrue(!list.equals(list2));
	}
	
	@Test
	// https://github.com/eclipse/xtext-eclipse/issues/678
	public void testNoInfiniteLoop() throws Exception {
		document.set("USETYPES   ");
		IRegion region = tokenSource.getLastDamagedRegion();
		ArrayList<ILexerTokenRegion> list = Lists.newArrayList(tokenSource.getTokenInfos());
		document.replace(9, 1, "${foo}/bar");
		IRegion region2 = tokenSource.getLastDamagedRegion();
		assertTrue(!region.equals(region2));
		ArrayList<ILexerTokenRegion> list2 = Lists.newArrayList(tokenSource.getTokenInfos());
		assertTrue(!list.equals(list2));
	}

}
