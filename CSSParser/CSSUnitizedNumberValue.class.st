Class {
	#name : #CSSUnitizedNumberValue,
	#superclass : #CSSNumberValue,
	#instVars : [
		'units'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSUnitizedNumberValue class >> allowableUnits [

	^self new allowableUnits
]

{ #category : #'instance creation' }
CSSUnitizedNumberValue class >> readFrom: in [

	| out |
	out := WriteStream on: String new.
	in skipSeparators.
	('-+' includes: in peek) ifTrue: [out nextPut: in next].
	[in atEnd not and: [in peek isDigit]] whileTrue: [out nextPut: in next].
	(in peek = $.) ifTrue: 
	[
		out size = 0 ifTrue: [out nextPut: $0].
		out nextPut: in next.
		[in atEnd not and: [in peek isDigit]] whileTrue: [out nextPut: in next].
	].
	[in atEnd or: [in peek isSeparator or:[';/,' includes: in peek]]] 
		whileFalse: [out nextPut: in next].
	^out contents size > 0 ifTrue: [self new valueString: out contents] ifFalse: [nil]
]

{ #category : #accessing }
CSSUnitizedNumberValue >> allowableUnits [

	self subclassResponsibility
]

{ #category : #accessing }
CSSUnitizedNumberValue >> units [
	"Answer the value of units"

	^ units
]

{ #category : #accessing }
CSSUnitizedNumberValue >> units: anObject [
	"Set the value of units"

	units := anObject
]

{ #category : #accessing }
CSSUnitizedNumberValue >> valueString: aString [

	| lc |

	lc := aString asLowercase.
	units := (self allowableUnits
			detect: [:ea | lc endsWith: ea] ifNone: [nil]).
	valueString := units notNil 
		ifTrue: [aString first: (aString size - units size)] 
		ifFalse: [aString].

]
