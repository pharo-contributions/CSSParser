Class {
	#name : 'CSSSelectorElementNotValidError',
	#superclass : 'CSSSelectorError',
	#instVars : [
		'element'
	],
	#category : 'CSSParser-CSS-Errors',
	#package : 'CSSParser',
	#tag : 'CSS-Errors'
}

{ #category : 'accessing' }
CSSSelectorElementNotValidError >> element [
	"Answer the value of element"

	^ element
]

{ #category : 'accessing' }
CSSSelectorElementNotValidError >> element: anObject [
	"Set the value of element"

	element := anObject
]

{ #category : 'accessing' }
CSSSelectorElementNotValidError >> printOn: aStream [

	self class printOn: aStream.
	aStream nextPut: $ ; nextPutAll: element; nextPut: $ .
	self parent printOn: aStream.
]
