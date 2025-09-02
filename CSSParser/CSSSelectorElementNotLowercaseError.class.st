Class {
	#name : 'CSSSelectorElementNotLowercaseError',
	#superclass : 'CSSSelectorError',
	#instVars : [
		'element'
	],
	#category : 'CSSParser-CSS-Errors',
	#package : 'CSSParser',
	#tag : 'CSS-Errors'
}

{ #category : 'accessing' }
CSSSelectorElementNotLowercaseError >> element [
	"Answer the value of element"

	^ element
]

{ #category : 'accessing' }
CSSSelectorElementNotLowercaseError >> element: anObject [
	"Set the value of element"

	element := anObject
]
