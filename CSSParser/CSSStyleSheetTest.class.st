Class {
	#name : 'CSSStyleSheetTest',
	#superclass : 'TestCase',
	#instVars : [
		'memory'
	],
	#category : 'CSSParser-CSS-Tests',
	#package : 'CSSParser',
	#tag : 'CSS-Tests'
}

{ #category : 'running' }
CSSStyleSheetTest >> setUp [

	super setUp.
	memory := FileSystem memory.
	memory / 'css1' writeStreamDo: [ :stream | 
		stream nextPutAll: 'body {
  background-color: lightblue;
}

h1 {
  color: white;
  text-align: center;
}

p {
  font-family: verdana;
  font-size: 20px;
}' ]
]

{ #category : 'tests' }
CSSStyleSheetTest >> testParseWithoutErrorDummyCSS [

	| css |
	css := CSSStyleSheet fromFile: memory / 'css1'.
	self assert: css children size equals: 3
]
