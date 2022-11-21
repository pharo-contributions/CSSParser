Class {
	#name : #CSSAttributeHasSubstringSelector,
	#superclass : #CSSAttributeSelector,
	#category : #'CSSParser-CSS'
}

{ #category : #testing }
CSSAttributeHasSubstringSelector >> isCSS3 [

	^true
]

{ #category : #testing }
CSSAttributeHasSubstringSelector >> matches: aNode [

	| attr |

	attr := self privateAttributeKeyInNode: aNode.

	^attr isNil 
		ifTrue: [false]
		ifFalse: 
		[
			((aNode attributes at: attr) findString: self value unquoted) > 0
		]
]
