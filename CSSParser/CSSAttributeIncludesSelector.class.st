Class {
	#name : 'CSSAttributeIncludesSelector',
	#superclass : 'CSSAttributeSelector',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'testing' }
CSSAttributeIncludesSelector >> matches: aNode [

	| attr |

	attr := self privateAttributeKeyInNode: aNode.

	^attr isNil 
		ifTrue: [false]
		ifFalse: 
		[
			(((aNode attributes at: attr) findTokens: ' ') 
				collect: [:ea | ea unquoted])
					includes: self value unquoted
		]
]
