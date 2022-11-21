Class {
	#name : #HtmlDTDMatchAND,
	#superclass : #HtmlDTDMatchGroup,
	#category : #'CSSParser-Validator'
}

{ #category : #accessing }
HtmlDTDMatchAND >> separator [

	^'&'
]

{ #category : #matching }
HtmlDTDMatchAND >> validateChildren: aStream ofNode: aNode [

	| position matched subexpressions |

	position := aStream position.
	subexpressions := expression.

	[subexpressions isEmpty] whileFalse:
	[
		matched := subexpressions detect:
		[:ea | 
			aStream position: position.		
			(ea validateChildren: aStream ofNode: aNode)
		] ifNone: [nil].
		matched notNil 
			ifFalse: [^false]
			ifTrue: 
			[
				position := aStream position.
				subexpressions := subexpressions copyWithout: matched.
			]
	].
	^true
]
