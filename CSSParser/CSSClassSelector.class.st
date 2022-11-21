Class {
	#name : #CSSClassSelector,
	#superclass : #CSSAttributeIncludesSelector,
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSClassSelector class >> readFrom: in [

	| out | 
	
	out := WriteStream on: String new.
	in peek = $. ifTrue: [in next].
	[in atEnd not and: [in peek isAlphaNumeric or:['-_' includes: in peek]]] 
		whileTrue: [out nextPut: in next].
	^self new value: out contents unquoted
]

{ #category : #'initialize-release' }
CSSClassSelector >> initialize [

	super initialize.
	self attribute: 'class'
]

{ #category : #testing }
CSSClassSelector >> matches: aNode [

	^aNode classes includes: self value
]

{ #category : #accessing }
CSSClassSelector >> printOn:aStream [

	aStream nextPut: $..
	aStream nextPutAll: self value.
]
