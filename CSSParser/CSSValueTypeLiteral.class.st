Class {
	#name : #CSSValueTypeLiteral,
	#superclass : #CSSValueType,
	#instVars : [
		'literal'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSValueTypeLiteral class >> readFrom: in [

	| out val |

	out := WriteStream on: String new.
	in peek isAlphaNumeric 
		ifTrue: 
		[ 
			out nextPut: in next.
			[in atEnd not and:[in peek isAlphaNumeric or: ['_-' includes: in peek]]] 
			whileTrue: [out nextPut: in next].
		] 
		ifFalse: 
		[
			('/,' includes: in peek) ifTrue: [out nextPut: in next]. 
		].
	val := self new literal: out contents.
	(CSSValueTypeConstraint allTypes includes: in peek) ifTrue:
	[
		val := (CSSValueTypeConstraint readFrom: in) type: val.
	].
	^val
]

{ #category : #testing }
CSSValueTypeLiteral >> addValues: aCollection fromStream: in [

	| pos s out |

	pos := in position.
	in skipSeparators.
	out := WriteStream on: String new.
	[in atEnd not and: [literal includes: in peek]] 
		whileTrue: [out nextPut: in next].
	s := out contents.
	^(s asLowercase = literal) 
		ifFalse: [in position: pos. false] 
		ifTrue: [aCollection add: (CSSIdentifierValue new valueString: self literal). true]
]

{ #category : #testing }
CSSValueTypeLiteral >> isValueValid: anObject [

	^anObject isString and: [self literal = anObject]
]

{ #category : #accessing }
CSSValueTypeLiteral >> literal [
	"Answer the value of literal"

	^ literal
]

{ #category : #accessing }
CSSValueTypeLiteral >> literal: anObject [
	"Set the value of literal"

	literal := anObject
]

{ #category : #printing }
CSSValueTypeLiteral >> printOn: aStream [

	aStream nextPutAll: self literal
]
