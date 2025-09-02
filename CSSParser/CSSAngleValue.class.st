Class {
	#name : 'CSSAngleValue',
	#superclass : 'CSSUnitizedNumberValue',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSAngleValue >> allowableUnits [

	^#('deg' 'grad' 'rad')
]
