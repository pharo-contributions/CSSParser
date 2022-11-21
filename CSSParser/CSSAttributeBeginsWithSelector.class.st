Class {
	#name : #CSSAttributeBeginsWithSelector,
	#superclass : #CSSAttributeSelector,
	#category : #'CSSParser-CSS'
}

{ #category : #testing }
CSSAttributeBeginsWithSelector >> matches: aNode [

	| attr |

	attr := self privateAttributeKeyInNode: aNode.

	^attr isNil 
		ifTrue: [false]
		ifFalse: 
		[
			((aNode attributes at: attr) findTokens: '-') 
				first = self value unquoted
		]
]
