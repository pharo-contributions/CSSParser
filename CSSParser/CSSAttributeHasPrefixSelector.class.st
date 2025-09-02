Class {
	#name : 'CSSAttributeHasPrefixSelector',
	#superclass : 'CSSAttributeSelector',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'testing' }
CSSAttributeHasPrefixSelector >> isCSS3 [

	^true
]

{ #category : 'testing' }
CSSAttributeHasPrefixSelector >> matches: aNode [

	| attr |

	attr := self privateAttributeKeyInNode: aNode.

	^attr isNil 
		ifTrue: [false]
		ifFalse: 
		[
			(aNode attributes at: attr) beginsWith: self value unquoted
		]
]
