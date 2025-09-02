Class {
	#name : 'HtmlDTDAttribute',
	#superclass : 'HtmlDTDConstruct',
	#instVars : [
		'attribute',
		'type',
		'isRequired'
	],
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'accessing' }
HtmlDTDAttribute >> allowsValue: aValue [
	
	self type isNil ifTrue:[^true].
	^self type isEnumeration
			ifFalse: [true]
			ifTrue: [self type allowsItem: aValue]
]

{ #category : 'accessing' }
HtmlDTDAttribute >> attribute [
	"Answer the value of attribute"

	^ attribute
]

{ #category : 'accessing' }
HtmlDTDAttribute >> attribute: anObject [
	"Set the value of attribute"

	attribute := anObject
]

{ #category : 'accessing' }
HtmlDTDAttribute >> isRequired [
	"Answer the value of isRequired"

	^ isRequired = '#REQUIRED'
]

{ #category : 'accessing' }
HtmlDTDAttribute >> isRequired: anObject [
	"Set the value of isRequired"

	isRequired := anObject
]

{ #category : 'accessing' }
HtmlDTDAttribute >> printOn: aStream [

	aStream nextPut: $@; nextPut:$(.
	attribute printOn: aStream.
	aStream space.
	type printOn: aStream.
	aStream space.
	isRequired printOn: aStream.
	aStream nextPut:$).
]

{ #category : 'accessing' }
HtmlDTDAttribute >> type [
	"Answer the value of type"

	^ type
]

{ #category : 'accessing' }
HtmlDTDAttribute >> type: anObject [
	"Set the value of type"

	type := HtmlDTDMatchExpression on: anObject
]
