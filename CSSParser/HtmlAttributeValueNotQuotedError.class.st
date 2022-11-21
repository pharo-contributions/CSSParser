Class {
	#name : #HtmlAttributeValueNotQuotedError,
	#superclass : #HtmlAttributeError,
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #testing }
HtmlAttributeValueNotQuotedError >> isSyntaxError [

	^true
]

{ #category : #printing }
HtmlAttributeValueNotQuotedError >> printOn: aStream [

	aStream nextPutAll: 'Value of: '.
	self attribute printOn: aStream.
	aStream nextPutAll: ' in '.
	self parent prefix printOn: aStream.
	aStream nextPutAll: ' should be quoted.'.
]
