Class {
	#name : #CSSValueTypeRelation,
	#superclass : #CSSValueType,
	#instVars : [
		'types'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSValueTypeRelation >> addType: anObject [

	self types: (self types copyWith: anObject)
]

{ #category : #accessing }
CSSValueTypeRelation >> operator [

	self subclassResponsibility
]

{ #category : #accessing }
CSSValueTypeRelation >> types [
	"Answer the value of types"

	^ types isNil ifTrue: [#()] ifFalse: [types]
]

{ #category : #accessing }
CSSValueTypeRelation >> types: anObject [
	"Set the value of types"

	types := anObject
]
