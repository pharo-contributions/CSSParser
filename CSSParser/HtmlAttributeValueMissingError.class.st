Class {
	#name : #HtmlAttributeValueMissingError,
	#superclass : #HtmlAttributeError,
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #printing }
HtmlAttributeValueMissingError >> printOn: aStream [

	aStream nextPutAll: 'Value missing for: '.
	self attribute printOn: aStream.
	aStream nextPutAll: ' in '.
	self parent prefix printOn: aStream.
	aStream nextPutAll: '.'.
]
