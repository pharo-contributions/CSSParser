Class {
	#name : #CSSAttributeExistsSelector,
	#superclass : #CSSAttributeSelector,
	#category : #'CSSParser-CSS'
}

{ #category : #testing }
CSSAttributeExistsSelector >> matches: aNode [

	^(self privateAttributeKeyInNode: aNode) notNil
]
