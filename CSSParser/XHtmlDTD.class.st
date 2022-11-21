Class {
	#name : #XHtmlDTD,
	#superclass : #HtmlDTD,
	#category : #'CSSParser-Validator'
}

{ #category : #private }
XHtmlDTD >> isXML [

	^true
]

{ #category : #private }
XHtmlDTD >> objectifyElements [

	elements := elements collect: [:ea | XHtmlDTDElement fromParsedString: ea]
]

{ #category : #private }
XHtmlDTD >> tag: aTag canContainTag: anotherTag [

	| element |
		element := self elementForTag: aTag asLowercase.
		^element notNil 
			ifTrue: [element allowsTag: anotherTag asLowercase]
			ifFalse:[false]
		
]
