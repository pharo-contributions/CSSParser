Class {
	#name : 'HtmlNodeDefaultStyleTest',
	#superclass : 'TestCase',
	#instVars : [
		'htmlFormatter',
		'styleResolver'
	],
	#category : 'CSSParser-Tests-HTML-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'HTML-Tests'
}

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> htmlFormatter [

	^ htmlFormatter
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> htmlFormatter: anObject [

	htmlFormatter := anObject
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> setUp [
	self timeout: 300.
	self htmlFormatter: DHtmlFormatter new.
	self styleResolver: CSSStyleResolver new
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> styleResolver [

	^ styleResolver
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> styleResolver: anObject [

	styleResolver := anObject
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test01EmphasizedTextShouldBeItalic [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<em>emphasized text</em>').
	node := document children first.
	self assert: (self styleResolver getStyle: #italic for: node) equals: true.
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test02StrongTextShouldBeBold [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<strong>strong text</strong>').
	node := document children first.
	self assert: (self styleResolver getStyle: #bold for: node) equals: true.
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test03DefinitionShouldBeItalicAndTimes [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<dfn>definition</dfn>').
	node := document children first.
	self assert: (self styleResolver getStyle: #italic for: node) equals: true.
	self assert: (self styleResolver getStyle: #fontFamily for: node) 
		equals: (TextStyle named: 'NimbusRomanNo9L').
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test04CodeShouldBeCourierNew [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<code>computer code</code>').
	node := document children first.
	self assert: (self styleResolver getStyle: #fontFamily for: node) 
		equals: (TextStyle named: 'NimbusMonoL').
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test05OutputShouldBeGeorgia [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<samp>sample output</samp>').
	node := document children first.
	self assert: (self styleResolver getStyle: #fontFamily for: node) 
		equals: (TextStyle named: 'Georgia').
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test06InputShouldBeTrebuchetMS [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<kbd>sample input</kbd>').
	node := document children first.
	self assert: (self styleResolver getStyle: #fontFamily for: node) 
		equals: (TextStyle named: 'TrebuchetMS').
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test07TeletypeShouldBeTrebuchetMS [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<tt>teletype text</tt>').
	node := document children first.
	self assert: (self styleResolver getStyle: #fontFamily for: node) 
		equals: (TextStyle named: 'TrebuchetMS').
]

{ #category : 'accessing' }
HtmlNodeDefaultStyleTest >> test08VariableShouldBeCourierNew [
	| document node |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<var>sample variable</var>').
	node := document children first.
	self assert: (self styleResolver getStyle: #fontFamily for: node) 
		equals: (TextStyle named: 'NimbusMonoL').
]
