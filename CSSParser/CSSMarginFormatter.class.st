Class {
	#name : #CSSMarginFormatter,
	#superclass : #CSSDistanceFormatter,
	#category : #'CSSParser-Formatter'
}

{ #category : #constants }
CSSMarginFormatter class >> attributePrefix [

	^ 'margin'
]

{ #category : #constants }
CSSMarginFormatter class >> attributeSuffix [

	^ ''
]
