Class {
	#name : 'CSSMarginFormatter',
	#superclass : 'CSSDistanceFormatter',
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'constants' }
CSSMarginFormatter class >> attributePrefix [

	^ 'margin'
]

{ #category : 'constants' }
CSSMarginFormatter class >> attributeSuffix [

	^ ''
]
