Class {
	#name : 'HtmlTagError',
	#superclass : 'HtmlError',
	#category : 'CSSParser-DOM-Errors',
	#package : 'CSSParser',
	#tag : 'DOM-Errors'
}

{ #category : 'testing' }
HtmlTagError >> isTagError [

	^true
]

{ #category : 'printing' }
HtmlTagError >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: (' Tag: ', self tag)
]
