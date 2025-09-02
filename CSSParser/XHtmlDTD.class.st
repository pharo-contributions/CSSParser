Class {
	#name : 'XHtmlDTD',
	#superclass : 'HtmlDTD',
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'private' }
XHtmlDTD >> isXML [

	^true
]

{ #category : 'private' }
XHtmlDTD >> objectifyElements [

	elements := elements collect: [:ea | XHtmlDTDElement fromParsedString: ea]
]

{ #category : 'private' }
XHtmlDTD >> tag: aTag canContainTag: anotherTag [

	| element |
		element := self elementForTag: aTag asLowercase.
		^element notNil 
			ifTrue: [element allowsTag: anotherTag asLowercase]
			ifFalse:[false]
		
]
