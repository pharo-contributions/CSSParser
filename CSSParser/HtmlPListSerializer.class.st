Class {
	#name : #HtmlPListSerializer,
	#superclass : #Object,
	#instVars : [
		'stream',
		'arrayItemsPerLine',
		'dictionaryItemsPerLine',
		'indentLevel'
	],
	#classVars : [
		'ReadTranslations',
		'WriteTranslations'
	],
	#category : #'CSSParser-PList'
}

{ #category : #'class initialization' }
HtmlPListSerializer class >> initialize [
	"comment stating purpose of message"
	| dict |

	ReadTranslations notNil ifTrue: [^self].

	dict := Dictionary new.
			dict at: $" put: $".
			dict at: $' put: $'.
			dict at: $\ put: $\.
			dict at: $n put: (Character cr).
			dict at: $r put: (Character cr).
			dict at: $t put: (Character tab).
	ReadTranslations := dict.

	dict := Dictionary new.
			dict at: Character tab put: '\t'.
			dict at: Character cr put: '\n'.
			dict at: $" put: '\"'.
			dict at: $' put: ('\', ($' asString)).
			dict at: $\ put: '\\'.
	WriteTranslations := dict

]

{ #category : #'instance creation' }
HtmlPListSerializer class >> on: aStream [ 
	"Answer an instance of me initialized on a stream."

	self initialize.
	^self basicNew on: aStream
]

{ #category : #initialize }
HtmlPListSerializer >> close [

	stream close.
	stream := nil.
]

{ #category : #reading }
HtmlPListSerializer >> next [
	^self read
]

{ #category : #reading }
HtmlPListSerializer >> nextPut: anObject [

	self write: anObject
]

{ #category : #initialize }
HtmlPListSerializer >> on: aStream [
	"Initialize myself with a stream"

	stream := aStream.
	(stream respondsTo: #ascii) ifTrue: [stream ascii].
	arrayItemsPerLine := 5.
	dictionaryItemsPerLine := 3.
	indentLevel := 0
]

{ #category : #reading }
HtmlPListSerializer >> read [
	"read a complete plist object assembly from the stream and return it"

	| c |

	self skipWhitespace.
	c := stream peek.
		
	 ^(c = ${)  ifTrue: [ self readDictionary ]
		ifFalse: 
		[
			( c = $( ) ifTrue: [ self readArray ]
			ifFalse: 
			[
				( c = $" ) ifTrue: [ self readQuotedString ] 
				ifFalse: [(self readString)]
			]
		]
]

{ #category : #reading }
HtmlPListSerializer >> readArray [
	"read an array"

	| item list |

	self skipWhitespace.

	( stream peek = $( ) 
		ifTrue:
		[
			stream next.
			self skipWhitespace.
			list := OrderedCollection new.
			[stream peek = $) ] whileFalse:
			[
				item := self read.
				list add: item.
				self skipWhitespace.
				(stream peek = $,) ifTrue: [stream next. self skipWhitespace].
			].
			stream next. "consume the trailing paren"
		]
		ifFalse:
		[ 
			"error of some sort here"
		].
		^list
]

{ #category : #reading }
HtmlPListSerializer >> readDictionary [
	"read a dictionary - assumes leading { has already been read"

	| c key value dict |

	self skipWhitespace.

	c := stream next.
	( c = ${ ) 
		ifTrue:
		[
			dict := Dictionary new.
			self skipWhitespace.
			[stream peek = $} ] whileFalse:
			[
				key := self read.
				self skipWhitespace.
				c := stream next.
				( c = $=) ifFalse: [ self error: 'expected = here' ].
				value := self read.
				self skipWhitespace.
				c := stream next.
				( c = $;) ifFalse: [ self error: 'expected ; here' ].
				self skipWhitespace.
				dict at: key put: value.
			].
			stream next.
		]
		ifFalse:
		[ 
			self error: 'not a dictionary'
		].
		^dict
]

{ #category : #reading }
HtmlPListSerializer >> readQuotedString [
	"read a complete plist object assembly from the stream and return it"
	| out c |
	out := WriteStream on: String new.
	self skipWhitespace.
	stream peek = $"
		ifTrue: [stream next.
			[stream peek = $" & stream peek notNil]
				whileFalse: [c := stream next.
					c = $\
						ifTrue: [c := stream next.
							out
								nextPut: (ReadTranslations at: c)]
						ifFalse: [out nextPut: c]].
			stream next].
	^ out contents
]

{ #category : #reading }
HtmlPListSerializer >> readString [
	"read a complete plist object assembly from the stream and return it"

	| out c |

	out := WriteStream on: String new.

	self skipWhitespace.
	[c := stream peek.
		c isAlphaNumeric | ('-_.' includes: c)] whileTrue: [ out nextPut: stream next ].
		
	^out contents
]

{ #category : #reading }
HtmlPListSerializer >> skipWhitespace [
	"read a dictionary - assumes leading { has already been read"

	[
		| c |
		c := stream peek.
		(c notNil) and: [c isSeparator]
	] whileTrue: [ stream next].

]

{ #category : #writing }
HtmlPListSerializer >> write: object [
	"write a serialized version of object - either an ordered collection, a dictionary, or something we can convert to a string"

	object isString 
		ifFalse: [ self writeCollection: object]
		ifTrue: [ self writeString: object asString] 
]

{ #category : #writing }
HtmlPListSerializer >> writeArray: aCollection [
	"write a serialized version of the ordered collection"

	| itemsPerLine | 

	itemsPerLine := 0.
	stream nextPutAll: '( '.
	indentLevel := indentLevel + 1.
	aCollection do: 
		[:x | 
			self write: x. 
			stream nextPutAll: ', '. 
			itemsPerLine := itemsPerLine + 1.
			itemsPerLine = arrayItemsPerLine ifTrue:[stream cr. itemsPerLine := 0] 
		].
	indentLevel := indentLevel - 1.
	aCollection isEmpty ifFalse: [ stream position: (stream position-2) ]. "Trim last comma space"
	stream nextPutAll: ')'.
]

{ #category : #writing }
HtmlPListSerializer >> writeCollection: aCollection [
	"write a serialized version of the collection"

	aCollection isSequenceable 
		ifTrue: [ self writeArray: aCollection]
		ifFalse: [ self writeDictionary: aCollection] 
]

{ #category : #writing }
HtmlPListSerializer >> writeDictionary: aCollection [
	"write a serialized version of the ordered collection"

	stream nextPutAll: '{ '; nextPut: Character lf.
	indentLevel := indentLevel + 1.
	aCollection keysAndValuesDo: [:key :value | 
		0 to: indentLevel do: [:ea | stream nextPut: $ ].
		self write: key. 
		stream nextPutAll: ' = '. 
		self write: value.
		stream nextPutAll: '; '; nextPut: Character lf].
	indentLevel := -1.
	stream nextPutAll: '}'.
]

{ #category : #writing }
HtmlPListSerializer >> writeIndent [
	"write the indent"

	0 to: indentLevel do: [:x | stream nextPutAll: '    '] 
]

{ #category : #writing }
HtmlPListSerializer >> writeString: aString [
	"write a string to the stream - quoting and escaping if necessary"

	(aString detect: [:c | ((c isAlphaNumeric) | ('_-.' includes: c)) not] ifNone: [ nil ])
	ifNil: [ stream nextPutAll: aString ]
	ifNotNil: [ stream nextPut: $". 
		aString do: [:c | stream nextPutAll: (WriteTranslations at: c ifAbsent: [ c asString] )]. stream nextPutAll: '" ']
]
