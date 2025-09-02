Class {
	#name : 'CSSPercentageValue',
	#superclass : 'CSSUnitizedNumberValue',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSPercentageValue >> allowableUnits [

	^#( '%' )
]

{ #category : 'accessing' }
CSSPercentageValue >> isValid [

	^super isValid and: [valueString asNumber >= 0]
]
