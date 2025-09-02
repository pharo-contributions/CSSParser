Class {
	#name : 'CSSValueTypeAND',
	#superclass : 'CSSValueTypeRelation',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'testing' }
CSSValueTypeAND >> addValues: aCollection fromStream: in [

	| pos sz |
	pos := in position.
	sz := aCollection size.
	self types do: 	
	[:ea |
		(ea addValues: aCollection fromStream: in) ifFalse: 
		[
			in position: pos.
			[aCollection size > sz] whileTrue: [aCollection removeLast].
			^false
		]
	].
	^true
]

{ #category : 'testing' }
CSSValueTypeAND >> isTypeAND [

	^true
]

{ #category : 'testing' }
CSSValueTypeAND >> operator [

	^' '
]

{ #category : 'printing' }
CSSValueTypeAND >> printOn: aStream [

	aStream nextPut: $[.
	self types do: [:ea | ea printOn: aStream.  ea == types last ifFalse: [ aStream nextPutAll: ' ']].
	aStream nextPut: $]
]
