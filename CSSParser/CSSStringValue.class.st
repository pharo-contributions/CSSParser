Class {
	#name : #CSSStringValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSStringValue class >> readFrom: in [

	| out |
	out := WriteStream on: String new.
	(in peek = $') ifTrue: 
	[
		in next.
		[in peek = $'] whileFalse: 
		[
			in peek = $\ ifTrue: [in next].
			out nextPut: in next
		].
		in next.
	] 
	ifFalse: "better be a double quote"
	[
		in peek = $" ifTrue:
		[
			in next.
			[in peek = $"] whileFalse: 
			[
				in peek = $\ ifTrue: [in next].
				out nextPut: in next
			].
			in next. "Read last quote"
		]
	].
	^out contents size > 0 ifTrue: [self new valueString: out contents] ifFalse: [nil]
]

{ #category : #testing }
CSSStringValue >> isValid [

	| s |

	s := valueString trimBoth.
	^s size > 0
]

{ #category : #accessing }
CSSStringValue >> value [

	^self valueString unquoted
]
