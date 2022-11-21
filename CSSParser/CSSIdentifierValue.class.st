Class {
	#name : #CSSIdentifierValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #testing }
CSSIdentifierValue >> isValid [

	| s |
	s := self valueString trimBoth.
	s first isLetter ifFalse:[^false].
	^(s detect:[:ea | (ea isAlphaNumeric or: ['_-' includes: ea]) not] ifNone: [nil]) isNil
]
