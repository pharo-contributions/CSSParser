Class {
	#name : #CSSPropertyError,
	#superclass : #CSSError,
	#instVars : [
		'propertyName'
	],
	#category : #'CSSParser-CSS-Errors'
}

{ #category : #accessing }
CSSPropertyError >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $ ; nextPutAll: self propertyName; nextPut: $ .
	self parent printOn: aStream.
]

{ #category : #accessing }
CSSPropertyError >> propertyName [
	"Answer the value of propertyName"

	^ propertyName
]

{ #category : #accessing }
CSSPropertyError >> propertyName: anObject [
	"Set the value of propertyName"

	propertyName := anObject
]
