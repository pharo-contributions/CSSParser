Class {
	#name : #HtmlDTDMatchOR,
	#superclass : #HtmlDTDMatchGroup,
	#category : #'CSSParser-Validator'
}

{ #category : #matching }
HtmlDTDMatchOR >> isEnumeration [

	^true
]

{ #category : #accessing }
HtmlDTDMatchOR >> separator [

	^'|'
]

{ #category : #matching }
HtmlDTDMatchOR >> validateChildren: aStream ofNode: aNode [

	| position matched |

	position := aStream position.

	matched := expression detect:
	[:ea | 
		aStream position: position.		
		(ea validateChildren: aStream ofNode: aNode)
	] ifNone: [nil].
	^matched notNil
]
