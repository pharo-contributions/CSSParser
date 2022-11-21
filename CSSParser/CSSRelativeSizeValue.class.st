Class {
	#name : #CSSRelativeSizeValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSRelativeSizeValue >> isValid [

	^#( 'smaller' 'larger' ) includes: self valueString trimBoth
]
