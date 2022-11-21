Class {
	#name : #HtmlDTDMatchOneOrMore,
	#superclass : #HtmlDTDMatchConstraint,
	#category : #'CSSParser-Validator'
}

{ #category : #printing }
HtmlDTDMatchOneOrMore >> printOn: aStream [

	expression printOn: aStream.
	aStream nextPut: $+

	
]

{ #category : #matching }
HtmlDTDMatchOneOrMore >> validateChildren: aStream ofNode: aNode [

	| matchedOne |
	matchedOne := false.
	[expression validateChildren: aStream ofNode: aNode] whileTrue:[matchedOne := true].
	^matchedOne
]
