Class {
	#name : #CSSSelectorError,
	#superclass : #CSSError,
	#category : #'CSSParser-CSS-Errors'
}

{ #category : #printing }
CSSSelectorError >> printOn: aStream [

	super printOn: aStream.
	self parent selector printOn: aStream.
]
