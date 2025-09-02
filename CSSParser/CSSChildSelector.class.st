Class {
	#name : 'CSSChildSelector',
	#superclass : 'CSSRelationshipSelector',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSChildSelector class >> operator [

	^'>'
]

{ #category : 'testing' }
CSSChildSelector >> isChildSelector [

	^true
]

{ #category : 'testing' }
CSSChildSelector >> matches: aNode [

	| node |

	node := aNode.
	selectors reverseDo: [ :ea |
		node ifNil: [^false].
		(ea matches: node) ifFalse: [^false].
		node := node parent.
	].
	^true
]
