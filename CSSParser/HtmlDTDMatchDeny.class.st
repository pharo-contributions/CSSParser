Class {
	#name : 'HtmlDTDMatchDeny',
	#superclass : 'HtmlDTDMatchExpression',
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'instance creation' }
HtmlDTDMatchDeny class >> on: anObject [

	| in | 

	in := anObject isStream 
		ifTrue:[anObject] 
		ifFalse: [ReadStream on: anObject].

	in next = $- ifFalse: [self error: 'HtmlDTDMatchDeny called with invalid stream state'].

	^self new expression: (HtmlDTDMatchExpression on: in)
]

{ #category : 'accessing' }
HtmlDTDMatchDeny >> allowedElements [

	^#()
]

{ #category : 'matching' }
HtmlDTDMatchDeny >> allowsItem: anItem [

	^(self expression allowsItem: anItem) not
]

{ #category : 'printing' }
HtmlDTDMatchDeny >> printOn: aStream [

	aStream nextPut: $-.
	expression printOn: aStream.

	
]

{ #category : 'matching' }
HtmlDTDMatchDeny >> validateChildren: aStream ofNode: aNode [

	^(expression validateChildren: aStream ofNode: aNode) not
]
