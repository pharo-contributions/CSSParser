Class {
	#name : #CSSProperty,
	#superclass : #CSSElement,
	#instVars : [
		'propertyName',
		'propertyValue',
		'propertyString',
		'definition',
		'important',
		'isDerived'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSProperty class >> propertyNamed: aString [

	^self new propertyName: aString
]

{ #category : #accessing }
CSSProperty >> definition [

	definition isNil ifTrue: 
	[
		definition := CSSPropertyDefinition named: 
			self propertyName asLowercase trimBoth
	].
	^definition
]

{ #category : #accessing }
CSSProperty >> definition: anObject [
	"Set the value of definition"

	definition := anObject
]

{ #category : #accessing }
CSSProperty >> important [
	"Answer the value of important"

	^ important
]

{ #category : #accessing }
CSSProperty >> important: anObject [
	"Set the value of important"

	important := anObject
]

{ #category : #accessing }
CSSProperty >> isDerived [
	"Answer the value of isDerived"

	isDerived isNil ifTrue: [isDerived := false].
	^ isDerived
]

{ #category : #accessing }
CSSProperty >> isDerived: anObject [
	"Set the value of isDerived"

	isDerived := anObject
]

{ #category : #testing }
CSSProperty >> isProperty [

	^true
]

{ #category : #accessing }
CSSProperty >> parseContents: aStream [

	| s pos in |
	aStream skipSeparators.
	pos := aStream position.
	s := aStream upTo: $;.
	(s includes: $}) ifTrue: 
	[
		aStream position: pos. 
		s := aStream upTo: $}.  
		self addError: CSSUnterminatedPropertyError new.
	].
	in := ReadStream on: s.
	self propertyString: (in upTo: $!).
	self important: (in match: 'important').
]

{ #category : #accessing }
CSSProperty >> prefix [

	^self isDerived ifTrue: 
	[
		| out |
		out := WriteStream on: String new.
		out nextPutAll: '<<';
			nextPutAll: self propertyName;
			nextPutAll: '>>';
			nextPut: $:;
			nextPut: $ .
		self propertyValue do:[:ea | out nextPut: $ ; nextPutAll: ea valueString].
		out nextPut: $;.
		out contents
	]
	ifFalse:
	[
		super prefix
	]
]

{ #category : #accessing }
CSSProperty >> printOn: aStream [

	aStream nextPutAll: self prefix
]

{ #category : #accessing }
CSSProperty >> propertyName [
	"Answer the value of propertyName"

	^ propertyName
]

{ #category : #accessing }
CSSProperty >> propertyName: anObject [
	"Set the value of propertyName"

	propertyName := anObject
]

{ #category : #accessing }
CSSProperty >> propertyString [
	"Answer the value of propertyString"

	^ propertyString
]

{ #category : #accessing }
CSSProperty >> propertyString: anObject [
	"Set the value of propertyString"

	propertyString := anObject trimBoth
]

{ #category : #accessing }
CSSProperty >> propertyValue [
	"Answer the value of propertyValue"

	^ propertyValue
]

{ #category : #accessing }
CSSProperty >> propertyValue: anObject [
	"Set the value of propertyValue"

	propertyValue := anObject
]

{ #category : #accessing }
CSSProperty >> tag [

	^propertyName
]

{ #category : #accessing }
CSSProperty >> valueIsValid [

	"self propertyName = 'font-family' ifTrue: [self halt]."
	^self definition isNil ifTrue: [false]
	ifFalse: 
	[
		propertyValue isNil ifTrue:
		[
			| list in |
			in := ReadStream on: self propertyString.
			list := OrderedCollection new.
			((self definition valueType addValues: list fromStream: in) and: 
				[in skipSeparators atEnd]) 
			ifTrue: 
			[
				self propertyValue: list.
				list do: [:ea | (ea isString not and: [ea isProperty]) ifTrue: [self parent addProperty: (ea start: self start; end: self end)]]. 
				true
			]
			ifFalse: [false]
		]
		ifFalse: [true]
	]
	
]
