Class {
	#name : #CSSValueTypeValue,
	#superclass : #CSSValueType,
	#instVars : [
		'valueClass'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSValueTypeValue class >> readFrom: in [

	| str vt val |

	in peek = $< ifFalse: [self error: 'CSSValueType must begin with ''<'''].

	str := (in upTo: $>),'>'.
	vt := CSSValue forType: str.
	val := vt notNil 
		ifTrue: [self new valueClass: vt] 
		ifFalse: [self error: ('Unknown CSS value type ',str)].
	in skipSeparators.
	(CSSValueTypeConstraint allTypes includes: in peek) ifTrue:
	[
		val := (CSSValueTypeConstraint readFrom: in) type: val.
	].
	^val
]

{ #category : #testing }
CSSValueTypeValue >> addValues: aCollection fromStream: in [

	| pos val |
	pos := in position.
	val := self valueClass readFrom: in.
	^(val notNil and: [val isValid]) 
		ifTrue: [aCollection add: val. true] 
		ifFalse: [in position: pos. false]
	
]

{ #category : #testing }
CSSValueTypeValue >> isValueValid: anObject [

	^(self valueClass new valueString: anObject asString) isValid
]

{ #category : #printing }
CSSValueTypeValue >> printOn: aStream [

	aStream nextPutAll: self valueClass type
]

{ #category : #accessing }
CSSValueTypeValue >> valueClass [
	"Answer the value of valueClass"

	^ valueClass
]

{ #category : #accessing }
CSSValueTypeValue >> valueClass: anObject [
	"Set the value of valueClass"

	valueClass := anObject
]
