Class {
	#name : #CSSPaddingWidthValue,
	#superclass : #CSSLengthValue,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSPaddingWidthValue >> allowableUnits [

	^super allowableUnits copyWith: '%'
]
