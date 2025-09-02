Class {
	#name : 'CSSValueTypeOR',
	#superclass : 'CSSValueTypeRelation',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'testing' }
CSSValueTypeOR >> addValues: aCollection fromStream: in [

	| pos |
	pos := in position.
	self types do:
	[:ea |
		(ea addValues: aCollection fromStream: in) ifTrue: [^true].
		in position: pos.
	].
	^false
]

{ #category : 'testing' }
CSSValueTypeOR >> isTypeOR [

	^true
]

{ #category : 'testing' }
CSSValueTypeOR >> isValueValid: anObject [

	^(self types detect: [:ea | ea isValueValid: anObject] ifNone: [nil]) notNil
]

{ #category : 'testing' }
CSSValueTypeOR >> operator [

	^'|'
]

{ #category : 'printing' }
CSSValueTypeOR >> printOn: aStream [

	aStream nextPut: $[.
	self types do: [:ea | ea printOn: aStream.  ea == types last ifFalse: [ aStream nextPutAll: ' | ']].
	aStream nextPut: $]
]
