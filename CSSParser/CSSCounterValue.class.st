Class {
	#name : 'CSSCounterValue',
	#superclass : 'CSSValue',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSCounterValue >> isValid [

	| s |
	s := self valueString trimBoth.
	((s beginsWith: 'counter(') and: [s endsWith: ')' ]) ifTrue:
	[
		| args |
		args := (s findTokens: '(,) ') copyWithoutFirst.
		^args size = 1 or:[args size = 2 and: [self isValidStyle: args last]]
	]
	ifFalse:
	[
		((s beginsWith: 'counters(') and: [s endsWith: ')']) ifTrue:
		[
			| args |
			args := (s findTokens: '(,) ') copyWithoutFirst.
			^args size = 2 or:[args size = 3 and: [self isValidStyle: args last]]
			
		]
	].
	^false
]

{ #category : 'accessing' }
CSSCounterValue >> isValidStyle: aString [

	^(CSSPropertyDefinition named: 'list-style-type') valueType isValidValue: aString
]
