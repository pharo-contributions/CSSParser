Class {
	#name : 'CSSSelector',
	#superclass : 'Object',
	#instVars : [
		'isValid'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSSelector class >> fromString: aString [

	(aString includes: $,) 
	ifTrue:
	[
		| in list |
		in := ReadStream on: (aString, ' ').
		list := OrderedCollection new.
		[in atEnd] whileFalse:
		[
			| sel |
			sel := CSSSelector oneSelectorFromString: (in upTo: $,).
			sel isNil ifTrue: [^CSSInvalidSelector new selectorString: aString].
			list add: sel.
		].
			
		^CSSOrSelector new selectors: list asArray
	]
	ifFalse:
	[
		| sel |
		sel := CSSSelector oneSelectorFromString: aString.
		^sel isNil ifTrue: [CSSInvalidSelector new selectorString: aString] ifFalse: [sel]
	]
]

{ #category : 'instance creation' }
CSSSelector class >> oneSelectorFromString: aString [

	| in sel lastOperator pos operators |
	operators := CSSRelationshipSelector operators.
	in := ReadStream on: aString.
	sel := nil.
	lastOperator := ' '.
	in skipSeparators.
	pos := -5.
	[in atEnd] whileFalse:
	[
		| c |
		in position = pos ifTrue: [^CSSInvalidSelector new selectorString: aString]. "Infinite loop detection"
		pos := in position.
		c := in peek.
		('.[*#:' includes: c) 
			ifTrue: 
			[
				sel isNil 
					ifTrue: [sel := (CSSUniversalSelector readFrom: in)]
					ifFalse: 
					[
						sel isRelationshipSelector ifFalse:
						[
							sel := (CSSRelationshipSelector selectorForOperator: lastOperator) 
								addSelector: sel.
							sel addSelector: (CSSUniversalSelector readFrom: in)
						]
						ifTrue:
						[ 
							lastOperator = sel operator ifFalse:
							[
								| last comb | 		
								last := sel removeLastSelector.
								comb := CSSRelationshipSelector selectorForOperator: lastOperator.
								comb addSelector: last.
								sel selectors isEmpty 
									ifFalse: [sel addSelector: comb] 
									ifTrue: [sel := comb]. 
								comb addSelector: (self oneSelectorFromString: in upToEnd).
							]
							ifTrue:
							[
								sel addSelector: (CSSUniversalSelector readFrom: in).
							]
						]
					]
			]
			ifFalse:
			[
				((operators includes:c) and:[sel notNil]) ifTrue: 
				[
					lastOperator := in next asString.
					sel isRelationshipSelector ifFalse:
					[
						sel := (CSSRelationshipSelector selectorForOperator: lastOperator)
							addSelector: sel.
					]
					ifTrue:
					[
						sel operator = lastOperator ifFalse:
						[
							| last comb | 		
							last := sel removeLastSelector.
							comb := CSSRelationshipSelector selectorForOperator: lastOperator.
							comb addSelector: last.
							sel selectors isEmpty 
								ifFalse: [sel addSelector: comb] 
								ifTrue: [sel := comb]. 
							in atEnd ifFalse: 
								[comb addSelector: (self oneSelectorFromString: in upToEnd)].
						]
					]
				]
				ifFalse:
				[
					c isLetter ifTrue:
					[
						sel isNil ifTrue: 
						[
							sel := (CSSTypeSelector readFrom: in).
						]
						ifFalse:
						[
							sel isRelationshipSelector ifFalse:
							[
								sel := (CSSRelationshipSelector selectorForOperator: lastOperator) 
									addSelector: sel.
								sel addSelector: (CSSTypeSelector readFrom: in)
							]
							ifTrue:
							[ 
								lastOperator = sel operator ifFalse:
								[
									| last comb | 		
									last := sel removeLastSelector.
									comb := CSSRelationshipSelector selectorForOperator: lastOperator.
									comb addSelector: last.
									sel selectors isEmpty 
										ifFalse: [sel addSelector: comb] 
										ifTrue: [sel := comb]. 
									comb addSelector: (self oneSelectorFromString: in upToEnd).
								]
								ifTrue:
								[
									sel addSelector: (CSSTypeSelector readFrom: in).
								]
							]
						]
					]
					ifFalse: 
					[
						(c = $/) ifTrue:
						[
							in next. 
							in peek = $* ifTrue:
							[
								in back.
								CSSComment new parseContents: in.
							]
							ifFalse:
							[
								in back.
							]
						]
					].
				] 
		].
	].
	^sel
]

{ #category : 'testing' }
CSSSelector >> isAdjacentSelector [

	^false
]

{ #category : 'testing' }
CSSSelector >> isAttributeSelector [

	^false
]

{ #category : 'testing' }
CSSSelector >> isCSS3 [

	^false
]

{ #category : 'testing' }
CSSSelector >> isChildSelector [

	^false
]

{ #category : 'testing' }
CSSSelector >> isDescendantSelector [

	^false
]

{ #category : 'testing' }
CSSSelector >> isRelationshipSelector [

	^false
]

{ #category : 'testing' }
CSSSelector >> isSimple [

	^false
]

{ #category : 'testing' }
CSSSelector >> isTypeSelector [

	^false
]

{ #category : 'accessing' }
CSSSelector >> isValid [
	"Answer the value of isValid"

	^ isValid isNil or: [isValid]
]

{ #category : 'accessing' }
CSSSelector >> isValid: anObject [
	"Set the value of isValid"

	isValid := anObject
]

{ #category : 'accessing' }
CSSSelector >> keySelectors [

	^#()
]

{ #category : 'testing' }
CSSSelector >> matches: aNode [

	self subclassResponsibility
]

{ #category : 'accessing' }
CSSSelector >> printOn: aStream [

	self subclassResponsibility
]

{ #category : 'testing' }
CSSSelector >> selectorsMatching: aBlock [

	^(aBlock value: self) ifTrue: [Array with: self] ifFalse: [#()]
]

{ #category : 'testing' }
CSSSelector >> typeSelectors [

	^self selectorsMatching: [:ea | ea isTypeSelector]
]
