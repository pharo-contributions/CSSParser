Class {
	#name : #CSSAttrXValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSAttrXValue class >> readFrom: in [

	|  pos |
	in skipSeparators.
	pos := in position.
	(in match: 'attr(') ifFalse: [in position: pos. ^nil].
	^self new valueString: (in upTo: $)) trimBoth
	
	
]

{ #category : #accessing }
CSSAttrXValue >> isValid [

	^(self valueString beginsWith: 'attr(') and: [self valueString endsWith: ')']
]
