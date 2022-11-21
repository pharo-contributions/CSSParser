Class {
	#name : #HtmlDTDMatchAllow,
	#superclass : #HtmlDTDMatchExpression,
	#category : #'CSSParser-Validator'
}

{ #category : #'instance creation' }
HtmlDTDMatchAllow class >> on: anObject [

	| in | 

	in := anObject isStream 
		ifTrue:[anObject] 
		ifFalse: [ReadStream on: anObject].

	in next = $+ ifFalse: [self error: 'HtmlDTDMatchDeny called with invalid stream state'].

	^self new expression: (HtmlDTDMatchExpression on: in)
]

{ #category : #accessing }
HtmlDTDMatchAllow >> allowedElements [

	^expression allowedElements
]

{ #category : #matching }
HtmlDTDMatchAllow >> allowsItem: anItem [

	^self expression allowsItem: anItem
]

{ #category : #printing }
HtmlDTDMatchAllow >> printOn: aStream [

	aStream nextPut: $+.
	expression printOn: aStream.


]

{ #category : #matching }
HtmlDTDMatchAllow >> validateChildren: aStream ofNode: aNode [

	^expression validateChildren: aStream ofNode: aNode
]
