Class {
	#name : #CSSAttributeSelector,
	#superclass : #CSSSelector,
	#instVars : [
		'attribute',
		'value'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSAttributeSelector class >> readFrom: in [

	| out |
	in peek = $[ ifFalse: [self halt].
	in next.
	out := WriteStream on: String new.
	[in atEnd not and: [in peek isLetter or: [in peek isDigit or:['-_' includes: in peek]]]] 
		whileTrue:[out nextPut: in next].

	in skipSeparators.
	in peek = $] ifTrue:
	[
		in next.
		^CSSAttributeExistsSelector new attribute: out contents
	]
	ifFalse:
	[
		| sel val |
		sel := nil.
		in peek = $= ifTrue: [sel := CSSAttributeEqualsSelector new attribute: out contents]
		ifFalse: 
		[
		 	(in peek = $~ and: [in next. in peek = $=]) 
			ifTrue: [sel := CSSAttributeIncludesSelector new attribute: out contents]
			ifFalse: 
			[
				(in peek = $| and: [in next. in peek = $=]) 
				ifTrue:[sel := CSSAttributeBeginsWithSelector new attribute: out contents]
				ifFalse:
				[
					(in peek = $^ and: [in next. in peek = $=]) ifTrue:
					[sel := CSSAttributeHasPrefixSelector new attribute: out contents]
					ifFalse:
					[
						(in peek = $$ and: [in next. in peek = $=]) ifTrue:
						[
							sel := CSSAttributeHasSuffixSelector new attribute: out contents
						]
						ifFalse:
						[
							(in peek = $* and: [in next. in peek = $=]) ifTrue:
							[
								sel := CSSAttributeHasSubstringSelector new 
									attribute: out contents
							]
							ifFalse:
							[
								in upTo: $].
								^CSSInvalidAttributeSelector new attribute: out contents
							]
						]
					]
				]
			]
		].
		in next. "Skip ="
		in skipSeparators.
		in peek = $" 
			ifTrue:[in next. val := in upTo: $"]
			ifFalse:
			[
				in peek = $' 
					ifTrue:[in next. val := in upTo: $']
					ifFalse:
					[
						out := WriteStream on: String new.
						[in peek isLetter or: [in peek isDigit or: ['-.' includes: in peek]]]
						whileTrue: [out nextPut: in next].
						val := out contents.
					]
			].
		in next. "Consume the last ]"
		^sel value: val
	]
	
]

{ #category : #comparing }
CSSAttributeSelector >> = anObject [

	^anObject class == self class and: 
		[anObject attribute = self attribute and: 
			[anObject value = self value]
		]
]

{ #category : #accessing }
CSSAttributeSelector >> attribute [
	"Answer the value of attribute"

	^ attribute
]

{ #category : #accessing }
CSSAttributeSelector >> attribute: anObject [
	"Set the value of attribute"

	attribute := anObject asLowercase asSymbol
]

{ #category : #comparing }
CSSAttributeSelector >> hash [

	^self class hash + self attribute hash + self value hash
]

{ #category : #testing }
CSSAttributeSelector >> isAttributeSelector [

	^true
]

{ #category : #accessing }
CSSAttributeSelector >> privateAttributeKeyInNode: aNode [

	^(aNode dtd isXML 
		ifTrue: 
		[
			(aNode attributes includesKey: self attribute) 
				ifFalse: [nil] 
				ifTrue:[self attribute]
		] 
		ifFalse: 
		[
			(aNode attributes includesKey: self attribute asLowercase) 
				ifFalse: [nil] 
				ifTrue:[self attribute]
		])

]

{ #category : #accessing }
CSSAttributeSelector >> value [

	^value
]

{ #category : #accessing }
CSSAttributeSelector >> value: anObject [
	"Set the value of value"

	value := anObject
]
