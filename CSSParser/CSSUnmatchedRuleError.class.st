Class {
	#name : #CSSUnmatchedRuleError,
	#superclass : #CSSError,
	#category : #'CSSParser-CSS-Errors'
}

{ #category : #printing }
CSSUnmatchedRuleError >> printOn: aStream [

	super printOn: aStream.
	self parent printOn: aStream.
]
