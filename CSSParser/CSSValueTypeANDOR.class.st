Class {
	#name : #CSSValueTypeANDOR,
	#superclass : #CSSValueTypeRelation,
	#category : #'CSSParser-CSS'
}

{ #category : #testing }
CSSValueTypeANDOR >> addValues: aCollection fromStream: in [

	| oneWorked gotOne |

	oneWorked := false.
	gotOne := false.
	[
		self types do:
		[:ea |
			(ea addValues: aCollection fromStream: in) 
				ifTrue: [gotOne := oneWorked := true]
		].
	(gotOne and: [in atEnd not])
	] whileTrue: [ gotOne := false ].

	^oneWorked
]

{ #category : #testing }
CSSValueTypeANDOR >> isTypeANDOR [

	^true
]

{ #category : #testing }
CSSValueTypeANDOR >> operator [

	^'||'
]

{ #category : #printing }
CSSValueTypeANDOR >> printOn: aStream [

	aStream nextPut: $[.
	self types do: [:ea | ea printOn: aStream.  ea == types last ifFalse: [ aStream nextPutAll: ' || ']].
	aStream nextPut: $]
]
