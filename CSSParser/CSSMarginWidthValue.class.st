Class {
	#name : 'CSSMarginWidthValue',
	#superclass : 'CSSValue',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSMarginWidthValue >> isValid [

	| s | 
	s := self valueString trimBoth.
	s = 'auto' ifTrue: [^true].
	(CSSLengthValue fromString: s) isValid ifTrue: [^true].
	(CSSPercentageValue fromString: s) isValid ifTrue: [^true].
	^false
]
