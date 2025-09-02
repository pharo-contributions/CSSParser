Class {
	#name : 'CSSAttributeExistsSelector',
	#superclass : 'CSSAttributeSelector',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'testing' }
CSSAttributeExistsSelector >> matches: aNode [

	^(self privateAttributeKeyInNode: aNode) notNil
]
