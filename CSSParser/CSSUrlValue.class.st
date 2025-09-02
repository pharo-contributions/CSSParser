Class {
	#name : 'CSSUrlValue',
	#superclass : 'CSSValue',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSUrlValue class >> readFrom: aStream [

	| s pos |
	aStream skipSeparators.
	pos := aStream position.
	(aStream match: 'url(' ) ifTrue: [s := aStream upTo: $)]
	ifFalse:
	[
		aStream position: pos.
		aStream peek = $' ifTrue: [aStream next. s:= aStream upTo: $']
		ifFalse: 
		[
			aStream peek = $" ifTrue: [aStream next. s:= aStream upTo: $"]
			ifFalse:
			[
				^nil 
			]
		]
	].
	^self new valueString: s unquoted
	
]

{ #category : 'accessing' }
CSSUrlValue >> isValid [

	^true
]

{ #category : 'accessing' }
CSSUrlValue >> value [

	| s |

	s := valueString trimBoth.

	^self isValid ifTrue:
	[
		(s beginsWith: 'url(') ifTrue:
		[
			s := s last: s size - 4.
			s := s first: s size - 1.
			s := s trimBoth unquoted.
		]
		ifFalse: [ s unquoted ]
	]
	ifFalse: ['']
]
