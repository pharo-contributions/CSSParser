Class {
	#name : 'HtmlDTDMatchGroup',
	#superclass : 'HtmlDTDMatchExpression',
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'instance creation' }
HtmlDTDMatchGroup class >> on: aStringOrStream [

	| seq in seps | 
	
	in := aStringOrStream isStream
		ifFalse: [ReadStream on: aStringOrStream] 
		ifTrue: [aStringOrStream].

	in skipSeparators.
	seq := OrderedCollection new.
	seps := #().
	(in peek = $() ifFalse: [self error: 'Groups start with $('].

	in next; skipSeparators.

	[in peek = $)] whileFalse:
	[
		in skipSeparators.
		seq add: (HtmlDTDMatchExpression on: in).
		in skipSeparators.
		('|&,' includes: in peek) ifTrue: [seps:= seps copyWith: in next. in skipSeparators]
			ifFalse: [in peek = $) ifFalse: [self error: 'Huh?']]
	].
	in next.
	
	^(seps isEmpty) ifTrue: [seq last]
		ifFalse: [(seps first = $|) ifTrue: [HtmlDTDMatchOR new expression: seq]
		ifFalse:[(seps first = $&) ifTrue: [HtmlDTDMatchAND new expression: seq]
			ifFalse:[(seps first = $,) ifTrue: [HtmlDTDMatchSequence new expression: seq]
				ifFalse:[self error: 'Invalid group separator']]]]
	
]

{ #category : 'accessing' }
HtmlDTDMatchGroup >> allowedElements [

	| collection |

	collection := OrderedCollection new.

	expression do: [:ea | collection addAll: ea allowedElements].

	^collection asArray
]

{ #category : 'matching' }
HtmlDTDMatchGroup >> allowsItem: anItem [

	^(expression detect:[:ea| ea allowsItem: anItem] ifNone: [nil]) notNil
]

{ #category : 'accessing' }
HtmlDTDMatchGroup >> expression: aCollection [

	super expression: aCollection asArray
]

{ #category : 'printing' }
HtmlDTDMatchGroup >> printOn: aStream [

	aStream nextPut: $(.
	aStream nextPutAll: (expression joinOn: (' ',(self separator asString),' ')).
	aStream nextPut: $)

]

{ #category : 'accessing' }
HtmlDTDMatchGroup >> separator [

	self subclassResponsibility 
]
