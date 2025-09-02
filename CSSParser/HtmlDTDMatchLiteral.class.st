Class {
	#name : 'HtmlDTDMatchLiteral',
	#superclass : 'HtmlDTDMatchExpression',
	#classVars : [
		'LiteralsByTagAsSymbol'
	],
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'instance creation' }
HtmlDTDMatchLiteral class >> expression: aTag [

	LiteralsByTagAsSymbol isNil ifTrue: [LiteralsByTagAsSymbol := WeakValueDictionary new].

	^LiteralsByTagAsSymbol at: aTag asSymbol ifAbsentPut: [self new expression: aTag]	
]

{ #category : 'instance creation' }
HtmlDTDMatchLiteral class >> on: aStringOrStream [

	| in out delims s |

	in := aStringOrStream isStream 
		ifFalse: [ReadStream on: aStringOrStream]
		ifTrue:[aStringOrStream].

	delims := ' ()|*?+-,&'.
	out := WriteStream on: String new.

	in skipSeparators.
	[in atEnd or: [delims includes: in peek]] whileFalse: [out nextPut: in next].
	s := out contents.
	^s = 'EMPTY' 
		ifTrue: [HtmlDTDMatchEmpty empty]	
		ifFalse: 
		[
			(s asUppercase findString: 'CDATA') > 0 
			ifTrue:[HtmlDTDMatchCDATA cdata]
			ifFalse:[HtmlDTDMatchLiteral new expression: s]
		]
]

{ #category : 'accessing' }
HtmlDTDMatchLiteral >> allowedElements [

	^ Array with: self
]

{ #category : 'matching' }
HtmlDTDMatchLiteral >> allowsItem: aTag [

	^expression = aTag
]

{ #category : 'accessing' }
HtmlDTDMatchLiteral >> consumeStream: in [

	expression = in peek ifTrue:[in next]
]

{ #category : 'matching' }
HtmlDTDMatchLiteral >> isLiteral [

	^true
]

{ #category : 'printing' }
HtmlDTDMatchLiteral >> printOn: aStream [

	aStream nextPut: $"; nextPutAll: expression; nextPut:$".
	
]

{ #category : 'matching' }
HtmlDTDMatchLiteral >> validateChildren: aStream ofNode: aNode [

	^(aStream atEnd not and: [expression = aStream peek dtdTag]) 
		ifTrue: [aStream next. true] 
		ifFalse: [false]

]
