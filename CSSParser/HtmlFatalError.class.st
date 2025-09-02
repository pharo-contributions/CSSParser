Class {
	#name : 'HtmlFatalError',
	#superclass : 'HtmlError',
	#category : 'CSSParser-DOM-Errors',
	#package : 'CSSParser',
	#tag : 'DOM-Errors'
}

{ #category : 'testing' }
HtmlFatalError >> isFatal [

	^true
]

{ #category : 'printing' }
HtmlFatalError >> printOn: aStream [

	super printOn: aStream.
	'ERROR!  This page is much too broken to parse.' printOn: aStream.
]
