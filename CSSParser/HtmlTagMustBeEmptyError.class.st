Class {
	#name : 'HtmlTagMustBeEmptyError',
	#superclass : 'HtmlTagStructureError',
	#category : 'CSSParser-DOM-Errors',
	#package : 'CSSParser',
	#tag : 'DOM-Errors'
}

{ #category : 'printing' }
HtmlTagMustBeEmptyError >> printOn: aStream [

	self parent tag printOn: aStream.
	aStream nextPutAll: ' must be empty.'
]
