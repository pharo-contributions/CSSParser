Class {
	#name : #CSSGenericFamilyValue,
	#superclass : #CSSValue,
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSGenericFamilyValue class >> readFrom: in [

	| out pos |
	
	pos := in position.
	out := WriteStream on: String new.
	in skipSeparators.
	(in peek = $') ifTrue: 
	[
		in next.
		[in peek = $'] whileFalse: 
		[
			in peek = $\ ifTrue: [in next].
			out nextPut: in next
		]
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
			]
		]
		ifFalse:
		[
			| seps |
			seps := (Character separators, ',;/').
			[in atEnd or: [seps includes: in peek]]whileFalse: [out nextPut: in next]
		]
	].

	^out contents size > 0 
		ifTrue: [self new valueString: out contents] 
		ifFalse: [in position: pos. nil]
]

{ #category : #accessing }
CSSGenericFamilyValue >> isValid [

	^#( 'serif' 'sans-serif' 'cursive' 'fantasy' 'monospace' ) includes: self valueString trimBoth
]
