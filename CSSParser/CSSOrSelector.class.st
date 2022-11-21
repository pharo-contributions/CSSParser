Class {
	#name : #CSSOrSelector,
	#superclass : #CSSRelationshipSelector,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSOrSelector class >> operator [

	^''
]

{ #category : #comparing }
CSSOrSelector >> = anObject [

	^self class = anObject class and: [self selectors asSet = anObject selectors asSet]
]

{ #category : #comparing }
CSSOrSelector >> hash [

	^(self class hash) + (self selectors asSet hash)
]

{ #category : #accessing }
CSSOrSelector >> keySelectors [

	| list |

	list := OrderedCollection new.
	self selectors do: [:ea | list addAll: ea keySelectors].
	^list
]

{ #category : #testing }
CSSOrSelector >> matches: aNode [

	^(selectors detect:[:ea | ea matches: aNode] ifNone:[nil]) notNil
]

{ #category : #testing }
CSSOrSelector >> printOn: aStream [

	self selectors do: [:ea | ea printOn: aStream. self selectors last == ea ifFalse: [aStream nextPutAll: ', ']]
]
