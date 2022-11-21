Class {
	#name : #HtmlDTDMatchCDATA,
	#superclass : #HtmlDTDMatchExpression,
	#classVars : [
		'CData'
	],
	#category : #'CSSParser-Validator'
}

{ #category : #accessing }
HtmlDTDMatchCDATA class >> cdata [

	^CData isNil ifTrue: [CData := self new] ifFalse: [CData]
]

{ #category : #accessing }
HtmlDTDMatchCDATA >> allowedElements [

	^#()
]

{ #category : #matching }
HtmlDTDMatchCDATA >> allowsItem: aTag [

	^(aTag asUppercase findString: 'CDATA') > 0
]

{ #category : #'initialize-release' }
HtmlDTDMatchCDATA >> initialize [

	super initialize.
	expression := '#CDATA'
]

{ #category : #printing }
HtmlDTDMatchCDATA >> printOn: aStream [

	aStream nextPutAll: expression
]

{ #category : #matching }
HtmlDTDMatchCDATA >> validateChildren: aStream ofNode: aNode [

	^(aStream atEnd not and: [self allowsItem: aStream peek dtdTag]) 
		ifTrue: [aStream next. true] 
		ifFalse: [false]

]
