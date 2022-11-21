Class {
	#name : #HtmlAttributeError,
	#superclass : #HtmlError,
	#instVars : [
		'attribute'
	],
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #accessing }
HtmlAttributeError >> attribute [
	"Answer the value of attribute"

	^ attribute
]

{ #category : #accessing }
HtmlAttributeError >> attribute: anObject [
	"Set the value of attribute"

	attribute := anObject
]

{ #category : #testing }
HtmlAttributeError >> isAttributeError [

	^true
]

{ #category : #accessing }
HtmlAttributeError >> position [

	^self parent start + (self parent prefix findString: self attribute)
]

{ #category : #printing }
HtmlAttributeError >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' Attribute: '.
	self attribute printOn: aStream.
	aStream space.
	self parent prefix printOn: aStream.
	aStream nextPut: $..
]
