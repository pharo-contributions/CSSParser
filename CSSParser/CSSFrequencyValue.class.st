Class {
	#name : 'CSSFrequencyValue',
	#superclass : 'CSSUnitizedNumberValue',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSFrequencyValue >> allowableUnits [

	^#( 'hz' 'khz')
]

{ #category : 'accessing' }
CSSFrequencyValue >> isValid [

	^super isValid and: [valueString asNumber >= 0]
]
