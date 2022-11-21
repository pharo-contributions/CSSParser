Class {
	#name : #CSSGenericVoiceValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSGenericVoiceValue >> isValid [

	^#( 'male' 'female' 'child' ) includes: self valueString trimBoth
]
