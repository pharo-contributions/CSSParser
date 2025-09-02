Class {
	#name : 'CSSPaddingWidthValue',
	#superclass : 'CSSLengthValue',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSPaddingWidthValue >> allowableUnits [

	^super allowableUnits copyWith: '%'
]
