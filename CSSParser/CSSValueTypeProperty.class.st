Class {
	#name : #CSSValueTypeProperty,
	#superclass : #CSSValueType,
	#instVars : [
		'propertyName',
		'valueType'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSValueTypeProperty class >> readFrom: in [

	| s val | 
	in skipSeparators.
	in peek = $' ifFalse: [self error: 'CSSValueTypeProperty must begin with "''"'].
	in next.
	s := in upTo: $'.
	val := self new propertyName: s.
	(CSSValueTypeConstraint allTypes includes: in peek) ifTrue:
	[
		val := (CSSValueTypeConstraint readFrom: in) type: val.
	].
	^val
]

{ #category : #accessing }
CSSValueTypeProperty >> addValues: aCollection fromStream: in [

	| returnValue size |
	size := aCollection size.
	returnValue := self valueType addValues: aCollection fromStream: in.
	returnValue ifTrue:
	[
		| vals newSize |
		
		newSize := aCollection size.
		vals := aCollection last: newSize - size.
		[aCollection size > size ] whileTrue: [aCollection removeLast].
		aCollection add: 
			(((CSSProperty propertyNamed: self propertyName)
				isDerived: true) propertyValue: vals).
	].
	^returnValue
]

{ #category : #accessing }
CSSValueTypeProperty >> isValueValid: anObject [

	^self valueType isValueValid: anObject
]

{ #category : #printing }
CSSValueTypeProperty >> printOn: aStream [

	"self propertyName printOn: aStream"
	self valueType printOn: aStream
]

{ #category : #accessing }
CSSValueTypeProperty >> propertyName [
	"Answer the value of propertyName"

	^ propertyName
]

{ #category : #accessing }
CSSValueTypeProperty >> propertyName: anObject [
	"Set the value of propertyName"

	propertyName := anObject
]

{ #category : #accessing }
CSSValueTypeProperty >> valueType [

	valueType isNil 
		ifTrue: [valueType := (CSSPropertyDefinition named: self propertyName) valueType].
	^valueType
]
