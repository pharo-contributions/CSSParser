Class {
	#name : #HtmlHeadBodyNestingError,
	#superclass : #HtmlTagError,
	#instVars : [
		'nesting'
	],
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #testing }
HtmlHeadBodyNestingError >> isStructuralError [

	^true
]

{ #category : #accessing }
HtmlHeadBodyNestingError >> nesting [
	"Answer the value of nesting"

	^ nesting
]

{ #category : #accessing }
HtmlHeadBodyNestingError >> nesting: anObject [
	"Set the value of nesting"

	nesting := anObject
]

{ #category : #accessing }
HtmlHeadBodyNestingError >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $ .
	('Actual tag nesting order found in document is: ', self nesting asString) printOn: aStream.
]
