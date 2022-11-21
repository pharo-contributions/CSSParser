Class {
	#name : #CSSBorderWidthValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSBorderWidthValue >> isValid [

	| val |
	val := self valueString trimBoth.
	^(#( 'thin' 'medium' 'thick' ) includes: val) or: [(CSSLengthValue fromString: val) isValid]
]
