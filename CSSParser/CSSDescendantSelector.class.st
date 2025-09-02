Class {
	#name : 'CSSDescendantSelector',
	#superclass : 'CSSRelationshipSelector',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSDescendantSelector class >> operator [

	^' '
]

{ #category : 'testing' }
CSSDescendantSelector >> isDescendantSelector [

	^true
]

{ #category : 'testing' }
CSSDescendantSelector >> matches: aNode [

	| node |

	(selectors last matches: aNode) ifFalse: [^false].

	node := aNode parent.
	selectors size -1 to: 1 by: -1 do:
	[:idx |
		| sel | 
		node isNil ifTrue:[^false].
		sel := selectors at: idx.
		[node isNil or: [sel matches: node]] whileFalse:[node := node parent]. 
	].
	^node notNil
]

{ #category : 'testing' }
CSSDescendantSelector >> printOn: aStream [

	self selectors do: [:ea | ea printOn: aStream. aStream nextPut: $ ]
]
