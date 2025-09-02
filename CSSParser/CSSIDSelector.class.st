Class {
	#name : 'CSSIDSelector',
	#superclass : 'CSSAttributeEqualsSelector',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSIDSelector class >> readFrom: in [

	| out | 
	
	out := WriteStream on: String new.
	in peek = $# ifTrue: [in next].
	[in atEnd not and:[in peek isAlphaNumeric or:['-_' includes: in peek]]] 
		whileTrue: [out nextPut: in next].
	^self new value: out contents
]

{ #category : 'initialize-release' }
CSSIDSelector >> initialize [

	super initialize.
	self attribute: 'id'
]

{ #category : 'accessing' }
CSSIDSelector >> printOn:aStream [

	aStream nextPut: $#.
	aStream nextPutAll: self value.
]
