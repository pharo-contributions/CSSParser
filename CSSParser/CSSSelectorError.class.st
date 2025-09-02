Class {
	#name : 'CSSSelectorError',
	#superclass : 'CSSError',
	#category : 'CSSParser-CSS-Errors',
	#package : 'CSSParser',
	#tag : 'CSS-Errors'
}

{ #category : 'printing' }
CSSSelectorError >> printOn: aStream [

	super printOn: aStream.
	self parent selector printOn: aStream.
]
