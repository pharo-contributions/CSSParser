Class {
	#name : #CSSInvalidSelector,
	#superclass : #CSSSelector,
	#instVars : [
		'selectorString'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSInvalidSelector >> isValid [

	^false
]

{ #category : #printing }
CSSInvalidSelector >> printOn: aStream [

	aStream nextPutAll: 'INVALID: '; nextPutAll: self selectorString
]

{ #category : #accessing }
CSSInvalidSelector >> selectorString [
	"Answer the value of selectorString"

	^ selectorString
]

{ #category : #accessing }
CSSInvalidSelector >> selectorString: anObject [
	"Set the value of selectorString"

	selectorString := anObject
]
