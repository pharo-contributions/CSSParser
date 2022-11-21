Class {
	#name : #HtmlTagUnknownError,
	#superclass : #HtmlTagError,
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #printing }
HtmlTagUnknownError >> printOn: aStream [

	self parent tag printOn: aStream.
	aStream nextPutAll: ' is not valid within this doctype.  It can probably be replaced with a span and CSS style.'

	
]
