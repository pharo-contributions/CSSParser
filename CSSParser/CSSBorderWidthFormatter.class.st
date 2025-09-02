Class {
	#name : 'CSSBorderWidthFormatter',
	#superclass : 'CSSDistanceFormatter',
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'constants' }
CSSBorderWidthFormatter class >> attributePrefix [

	^ 'border'
]

{ #category : 'constants' }
CSSBorderWidthFormatter class >> attributeSuffix [

	^ '-width'
]
