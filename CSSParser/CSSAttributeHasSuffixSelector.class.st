Class {
	#name : #CSSAttributeHasSuffixSelector,
	#superclass : #CSSAttributeSelector,
	#category : #'CSSParser-CSS'
}

{ #category : #testing }
CSSAttributeHasSuffixSelector >> isCSS3 [

	^true
]

{ #category : #testing }
CSSAttributeHasSuffixSelector >> matches: aNode [

	| attr |

	attr := self privateAttributeKeyInNode: aNode.

	^attr isNil 
		ifTrue: [false]
		ifFalse: 
		[
			(aNode attributes at: attr) endsWith: self value unquoted
		]
]
