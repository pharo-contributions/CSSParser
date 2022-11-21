Class {
	#name : #CSSAbsoluteSizeValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSAbsoluteSizeValue >> isValid [

	^#('xx-small' 'x-small' 'small' 'medium' 'large' 'x-large' 'xx-large') includes: self valueString trimBoth
]
