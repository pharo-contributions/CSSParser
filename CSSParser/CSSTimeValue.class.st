Class {
	#name : #CSSTimeValue,
	#superclass : #CSSUnitizedNumberValue,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSTimeValue >> allowableUnits [

	^#( 's' 'ms')
]

{ #category : #accessing }
CSSTimeValue >> isValid [

	^super isValid and: [valueString asNumber >= 0]
]
