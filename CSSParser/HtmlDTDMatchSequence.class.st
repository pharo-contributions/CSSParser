Class {
	#name : #HtmlDTDMatchSequence,
	#superclass : #HtmlDTDMatchGroup,
	#category : #'CSSParser-Validator'
}

{ #category : #accessing }
HtmlDTDMatchSequence >> separator [

	^','
]

{ #category : #matching }
HtmlDTDMatchSequence >> validateChildren: aStream ofNode: aNode [

	expression do:
	[:ea | 
		
		(ea validateChildren: aStream ofNode: aNode) ifFalse: [^false]
	].
	^true
]
