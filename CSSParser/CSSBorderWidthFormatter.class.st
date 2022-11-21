Class {
	#name : #CSSBorderWidthFormatter,
	#superclass : #CSSDistanceFormatter,
	#category : #'CSSParser-Formatter'
}

{ #category : #constants }
CSSBorderWidthFormatter class >> attributePrefix [

	^ 'border'
]

{ #category : #constants }
CSSBorderWidthFormatter class >> attributeSuffix [

	^ '-width'
]
