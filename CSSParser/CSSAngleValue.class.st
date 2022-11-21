Class {
	#name : #CSSAngleValue,
	#superclass : #CSSUnitizedNumberValue,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSAngleValue >> allowableUnits [

	^#('deg' 'grad' 'rad')
]
