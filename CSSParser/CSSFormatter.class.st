Class {
	#name : 'CSSFormatter',
	#superclass : 'Object',
	#instVars : [
		'attributeMap',
		'parentResolver'
	],
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'size-conversion' }
CSSFormatter >> absoluteSizeToPx: aString defaultSize: aNumber [
	| value |
	aString ifNil: [^aNumber].
	value := (self isNumber: aString) ifTrue: [ aString asNumber] ifFalse: [nil].
	value ifNil: [^aNumber].
	
	(aString endsWith: 'cm') ifTrue: [ ^self inToPx: (self cmToIn: value) ].
	(aString endsWith: 'mm') ifTrue: [ ^self inToPx: (self mmToIn: value) ].
	(aString endsWith: 'in') ifTrue: [ ^self inToPx: value ].
	(aString endsWith: 'pt') ifTrue: [ ^self inToPx: (self ptToIn: value) ].
	(aString endsWith: 'pc') ifTrue: [ ^self inToPx: (self pcToIn: value) ].
	(aString endsWith: 'px') ifTrue: [ ^value ].
	^aNumber
]

{ #category : 'accessing' }
CSSFormatter >> attributeMap [

	self subclassResponsibility
]

{ #category : 'size-conversion' }
CSSFormatter >> cmToIn: cmValue [
	^cmValue / 2.54
]

{ #category : 'size-conversion' }
CSSFormatter >> inToPx: inValue [
	^inValue * TextStyle pixelsPerInch
]

{ #category : 'size-conversion' }
CSSFormatter >> isAbsoluteSize: aString [
	^aString endsWithAnyOf: {'cm' . 'mm'. 'in' . 'pt' . 'pc' . 'px'}
]

{ #category : 'size-conversion' }
CSSFormatter >> isAbsoluteSize: aString ifTrue: aBlock [
	(self isAbsoluteSize: aString) ifTrue: [^aBlock value].
	^false
]

{ #category : 'size-conversion' }
CSSFormatter >> isNumber: aString [

	(aString notEmpty and: [aString first isDigit])
		ifTrue: [ ^ true ].
		
	(aString size > 1 and: [[aString first = $-] and: [aString second isDigit]])
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : 'size-conversion' }
CSSFormatter >> isRelativeSize: aString [
	^aString endsWithAnyOf: {'em' . 'ex'. '%' . 'larger' . 'smaller'}
]

{ #category : 'size-conversion' }
CSSFormatter >> isRelativeSize: aString ifTrue: aBlock [
	(self isRelativeSize: aString) ifTrue: [^aBlock value].
	^false
]

{ #category : 'size-conversion' }
CSSFormatter >> mmToIn: mmValue [
	^mmValue / 25.4
]

{ #category : 'accessing' }
CSSFormatter >> parentResolver [
	^ parentResolver ifNil: [ [:v | nil] ]
]

{ #category : 'accessing' }
CSSFormatter >> parentResolver: anObject [

	parentResolver := anObject
]

{ #category : 'parsing' }
CSSFormatter >> parseTextAttributesFrom: aCSSProperty into: aContext [

	(self attributeMap at: aCSSProperty propertyName ifAbsent: [nil])
		ifNotNil: [	:process | process value: aCSSProperty value: aContext ]
]

{ #category : 'parsing' }
CSSFormatter >> parseTextAttributesFrom: styles into: aContext withParentAttributeResolver: aParentResolver [
	self parentResolver: aParentResolver;
		parseTextAttributesFrom: styles into: aContext
]

{ #category : 'size-conversion' }
CSSFormatter >> pcToIn: pcValue [
	^pcValue / 6
]

{ #category : 'size-conversion' }
CSSFormatter >> ptToIn: ptValue [
	^ptValue / 72
]

{ #category : 'parsing' }
CSSFormatter >> put: aPropertyValue at: anAttribute to: aContext [

	"TODO: isValid for all formatter"
	aContext at: anAttribute put: aPropertyValue
]

{ #category : 'size-conversion' }
CSSFormatter >> relativeSizeToPx: aString parentAndDefaultSize: aNumber [
	| value |
	aString ifNil: [^aNumber].
	(aString endsWith: 'larger') ifTrue: [ ^aNumber * 1.3].
	(aString endsWith: 'smaller') ifTrue: [ ^aNumber * 0.7].
	value := aString asNumber.
	value ifNil: [^aNumber].
	
	(aString endsWithAnyOf: {'em' . 'ex'}) ifTrue: [ ^value * aNumber ].
	(aString endsWith: '%') ifTrue: [ ^value / 100 * aNumber ].
	
	^aNumber
]

{ #category : 'constants' }
CSSFormatter >> rootValueForEm [ 
	^20

]
