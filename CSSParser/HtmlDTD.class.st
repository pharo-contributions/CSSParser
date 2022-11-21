"
I represent the knowledge in a DTD document regarding valid attributes and tag combinations.

After working with this format for awhile, I can honestly say the inventors of DVD have been taking way too much crack.
"
Class {
	#name : #HtmlDTD,
	#superclass : #Object,
	#instVars : [
		'url',
		'document',
		'errors',
		'dom',
		'content',
		'comments',
		'elements',
		'attLists',
		'entities'
	],
	#classVars : [
		'Cache'
	],
	#category : #'CSSParser-Validator'
}

{ #category : #accessing }
HtmlDTD class >> default [

	^self forDocType: self docType
]

{ #category : #accessing }
HtmlDTD class >> defaultUrl [

	self subclassResponsibility
]

{ #category : #accessing }
HtmlDTD class >> docType [

	^'abstract'
]

{ #category : #'instance creation' }
HtmlDTD class >> forDocType: aDocType [

	| dt delims |

	delims := (Character separators copyWith: $<) copyWith: $>.

	dt := aDocType copyWithoutAll: delims.

	Cache isNil ifTrue: [Cache := Dictionary new].

	^Cache at: dt ifAbsentPut: 
	[ 
		(self allSubclasses
			detect: [:ea | (ea docType copyWithoutAll: delims) = dt] 
			ifNone: [Html401Strict]) new.
	]
]

{ #category : #'instance creation' }
HtmlDTD class >> on: aString [

	^self new content: aString
]

{ #category : #'instance creation' }
HtmlDTD class >> onUrl: aStringOrUrl [

	^self new url: aStringOrUrl asUrl 
]

{ #category : #accessing }
HtmlDTD class >> resetCache [

	"HtmlDTD resetCache"
	Cache := nil
]

{ #category : #accessing }
HtmlDTD class >> updateFromWeb [

	self compileSilently: ('dtd',(Character cr asString), '^',(self defaultUrl retrieveContents contents printString)) classified: 'resources'  
]

{ #category : #accessing }
HtmlDTD >> addToAttLists: anAttList [

	self attLists: (self attLists copyWith: anAttList)
]

{ #category : #accessing }
HtmlDTD >> addToComments: aComment [

	self comments: (self comments copyWith: aComment)
]

{ #category : #accessing }
HtmlDTD >> addToElements: anElement [

	self elements: (self elements copyWith: anElement)
]

{ #category : #accessing }
HtmlDTD >> addToEntities: anEntity [

	self entities: (self entities copyWith: anEntity)
]

{ #category : #accessing }
HtmlDTD >> attLists [
	"Answer the value of attLists"

	^ attLists isNil 
		ifTrue:[#()]
		ifFalse:[attLists]
]

{ #category : #accessing }
HtmlDTD >> attLists: anObject [
	"Set the value of attLists"

	attLists := anObject
]

{ #category : #testing }
HtmlDTD >> attrListForTag: aTag [

	^attLists detect:[:ea | ea tagMatches: aTag] ifNone:[nil]
]

{ #category : #accessing }
HtmlDTD >> comments [

	^comments isNil 
		ifTrue: [#()]
		ifFalse: [comments]
]

{ #category : #accessing }
HtmlDTD >> comments: anArray [

	comments := anArray
]

{ #category : #accessing }
HtmlDTD >> content [
	"Answer the value of content"

	^ content isNil 
		ifFalse: [content]
		ifTrue: 
		[
			(self respondsTo: #dtd) 
				ifTrue: [content := self dtd]
				ifFalse: [content := self document content]
		]
	
]

{ #category : #accessing }
HtmlDTD >> content: anObject [
	"Set the value of content"

	content := anObject
]

{ #category : #accessing }
HtmlDTD >> defaultUrl [

	^self class defaultUrl
]

{ #category : #accessing }
HtmlDTD >> document [
	"Answer the value of document"

	^ document isNil 
		ifFalse: [document]
		ifTrue: [url isNil ifFalse: [document := url asUrl retrieveContents] ifTrue: [nil]] 
]

{ #category : #accessing }
HtmlDTD >> document: anObject [
	"Set the value of document"

	document := anObject
]

{ #category : #accessing }
HtmlDTD >> dom [
	"Answer the value of dom"

	^ dom
]

{ #category : #accessing }
HtmlDTD >> dom: anObject [
	"Set the value of dom"

	dom := anObject
]

{ #category : #testing }
HtmlDTD >> elementForTag: aTag [

	^elements detect:[:ea | ea tagMatches: aTag] ifNone:[nil]
]

{ #category : #accessing }
HtmlDTD >> elements [
	"Answer the value of elements"

	^ elements isNil 
		ifTrue:[#()]
		ifFalse:[elements]
]

{ #category : #accessing }
HtmlDTD >> elements: anObject [
	"Set the value of elements"

	elements := anObject
]

{ #category : #accessing }
HtmlDTD >> entities [
	"Answer the value of entities"

	^ entities isNil 
		ifTrue:[#()]
		ifFalse: [entities]
]

{ #category : #accessing }
HtmlDTD >> entities: anObject [
	"Set the value of entities"

	entities := anObject
]

{ #category : #accessing }
HtmlDTD >> errors [
	"Answer the value of errors"

	^ errors
]

{ #category : #accessing }
HtmlDTD >> errors: anObject [
	"Set the value of errors"

	errors := anObject
]

{ #category : #private }
HtmlDTD >> expandAllTokens [

	self expandElementTokens.
	self expandAttListTokens.
]

{ #category : #private }
HtmlDTD >> expandAttListTokens [

	| expanded changed |

	changed := true.
	expanded := attLists.

	[changed] whileTrue:
	[
		changed := false.
		expanded := expanded collect:
		[:item |
			item collect: 
			[:ea |
				| s |
				s := self expandTokensInLine: ea.
				s = ea ifFalse: [changed := true].
				s
			]
		]
	].
	^attLists := expanded
]

{ #category : #private }
HtmlDTD >> expandElementTokens [

	| expanded changed |

	changed := true.
	expanded := elements.

	[changed] whileTrue:
	[
		changed := false.
		expanded := expanded collect:
		[:ea |
			| s |
			s := self expandTokensInLine: ea.
			s = ea ifFalse: [changed := true].
			s
		]
	].
	^elements := expanded
]

{ #category : #private }
HtmlDTD >> expandTokensInLine: aString [

	| in out s |

	in := ReadStream on: aString.
	out := WriteStream on: (String new: 20).
	[in atEnd] whileFalse:
	[
		s := in upTo: $%.
		out nextPutAll: s.
		in atEnd 
			ifFalse: 
			[ 
				out nextPutAll: 
					(((self tokenDefinition: 
						(in upTo: $;)) findTokens: ' ')joinOn: ' ') 
			]
	].
	^out contents
]

{ #category : #'initialize-release' }
HtmlDTD >> initialize [

	super initialize.

]

{ #category : #testing }
HtmlDTD >> isXML [

	^false
]

{ #category : #private }
HtmlDTD >> objectifyAttLists [

	attLists := attLists collect: [:ea | HtmlDTDAttrList fromParsedArray: ea]
]

{ #category : #private }
HtmlDTD >> objectifyElements [

	elements := elements collect: [:ea | HtmlDTDElement fromParsedString: ea].
	elements do: [:ea | ea cacheAllowedElementsForDTD: self].
]

{ #category : #actions }
HtmlDTD >> parse [

	| in s |
	
	self reset.
	in := ReadStream on: self content.

	[in atEnd] whileFalse:
	[
		in skipSeparators.
		in upTo: $<.
		s := in upTo: $ .
		(s beginsWith: '!--') 
		ifTrue: [self readComment: in]
		ifFalse:
		[
			(s beginsWith: '!ELEMENT') 
			ifTrue: [self readElement: in]
			ifFalse:
			[
				(s beginsWith: '!ATTLIST')
				ifTrue: [self readAttList: in]
				ifFalse:
				[
					(s beginsWith: '!ENTITY')
					ifTrue:[self readEntity: in]
					ifFalse:
					[
						(s beginsWith: '![')
						ifTrue:[self readConditionalElement: in]
						ifFalse:[s trimBoth size > 0 ifTrue: [self halt]]
					] 
				] 
			]
		]
	].

	self expandAllTokens.
	self objectifyAttLists.
	self objectifyElements.
	
	
]

{ #category : #actions }
HtmlDTD >> readAttList: aStream [

	| s list |

	list := OrderedCollection new.
	s := (aStream upTo: $>) trimBoth findTokens: Character separators.

	list add: s first.
	s := s copyWithoutFirst joinOn: ' '.
	list add: (self stripCommentsFrom: s).
	self addToAttLists: list asArray.
]

{ #category : #actions }
HtmlDTD >> readComment: aStream [

	| s |

	s := aStream upTo: $>.
	[s endsWith: '--'] whileFalse: [s:= (s, '>',(aStream upTo: $>))].
	self addToComments: s.
]

{ #category : #actions }
HtmlDTD >> readConditionalElement: aStream [

	| s |

	s := aStream upTo: $>.
	[s endsWith: ']]'] whileFalse: [s:= (s, '>',(aStream upTo: $>))].

]

{ #category : #actions }
HtmlDTD >> readElement: aStream [

	| s |

	s := aStream upTo: $>.
	self addToElements: (self stripCommentsFrom: s) trimBoth.
]

{ #category : #actions }
HtmlDTD >> readEntity: aStream [

	| s in out |

	out := WriteStream on: (String new: 100).

	s := (self stripCommentsFrom: (aStream upTo: $>)) trimBoth.

	in := ReadStream on: s.
	in upTo: $%.
	out nextPutAll: '% '.

	in skipSeparators.
	[in peek isSeparator]whileFalse:[out nextPut: in next].

	in skipSeparators.
	out nextPut: $ .
	out nextPutAll: in upToEnd.
	self addToEntities: out contents trimBoth.
	
]

{ #category : #actions }
HtmlDTD >> reset [

	entities := attributes := comments := elements := attLists := nil
]

{ #category : #private }
HtmlDTD >> stripCommentsFrom: aString [

	| in out |

	in := ReadStream on: aString.
	out := WriteStream on: (String new: aString size).

	[in atEnd] whileFalse:
	[
		out nextPutAll: (in upToAll: '--').
		in upToAll: '--'.
	].
	^out contents
]

{ #category : #testing }
HtmlDTD >> tag: aTag allowsAttribute: anAttribute [

	| a |
	a := (self attrListForTag: aTag).
	^a isNil 
		ifFalse: [(a attributeNamed: anAttribute) notNil] 
		ifTrue:[false]
]

{ #category : #testing }
HtmlDTD >> tag: aTag attribute: anAttribute hasValidValue: aValue [

	| a adef |
	a := (self attrListForTag: aTag).
	^a isNil 
		ifTrue:[false]
		ifFalse: 
		[
			adef := a attributeNamed: anAttribute.
			adef isNil 
				ifTrue:[false]
				ifFalse:
				[
					adef type isString 
						ifTrue: [true]
						ifFalse: [adef type allowsItem: aValue]
				]
		] 

]

{ #category : #testing }
HtmlDTD >> tag: aTag canContainTag: anotherTag [

	| element |
		element := self elementForTag: aTag asUppercase.
		^element notNil 
			ifTrue: [element allowsTag: anotherTag asUppercase]
			ifFalse:[false]
		
]

{ #category : #testing }
HtmlDTD >> tagCloseIsOptional: aTag [

	| element |

	element := self elementForTag: aTag.
	^element isNil 
		ifTrue:[false] 
		ifFalse:[element endIsOptional]
]

{ #category : #testing }
HtmlDTD >> tagIsEmpty: aTag [

	| e |

	e := elements detect: [:ea | ea tagMatches: aTag] ifNone: [nil].
	^e notNil ifTrue: [e isEmpty] ifFalse: [false]
]

{ #category : #testing }
HtmlDTD >> tagIsOptional: aTag [

	| decl |
	decl := (self elements detect: [:ea | ea beginsWith: (aTag asUppercase)]).
	^((decl splitOn: ' ') at: 2) = 'O'
]

{ #category : #testing }
HtmlDTD >> tagIsReal: aTag [

	^(self elementForTag: aTag) notNil
]

{ #category : #private }
HtmlDTD >> tokenDefinition: aToken [

	| def fmt s in |

	fmt := (aToken copyWithout: $%)	copyWithout: $;.
	fmt := ('% ',fmt, ' ').
	def := entities detect: [:ea | ea beginsWith: fmt] ifNone: ['"', aToken, '"'].
	in := ReadStream on: def.
	in upTo: $".
	s := in upTo: $".
	^s	
]

{ #category : #accessing }
HtmlDTD >> url [
	"Answer the value of url"

	^ url isNil ifTrue: [url := self defaultUrl]
]

{ #category : #accessing }
HtmlDTD >> url: anObject [
	"Set the value of url"

	url := anObject.

]

{ #category : #actions }
HtmlDTD >> validateAttributesOfNode: aNode [

	aNode attributes copy keysAndValuesDo:
	[:k :v || attList lck |
		attList := self attrListForTag: aNode dtdTag.
		lck := k asLowercase.
		(attList includesAttribute: lck) ifFalse:
		[
			aNode addError: (HtmlAttributeUnknownError new attribute: k).
		]
		ifTrue:
		[
			(k = lck) 
			ifFalse: 
			[
				aNode addError: (HtmlAttributeNotLowerCaseError new attribute: k).
				aNode attributes at: lck put: v.
				aNode attributes removeKey: k.
			].
			v isNil ifTrue:
			[
				(self isXML or: [((attList attributeNamed: lck) allowsValue: lck) not]) ifTrue:
				[
					aNode addError: (HtmlAttributeValueMissingError new attribute: k).
				]
			]
			ifFalse:
			[
				((attList attributeNamed: lck) allowsValue: v) ifFalse:
				[
					aNode addError: (HtmlAttributeValueNotValidError new attribute: k).
				]
			]
		]					
	]

]

{ #category : #actions }
HtmlDTD >> validateChildrenOfNode: aNode [

	| element children stream |

	(aNode isComment or: [aNode isCDATA]) ifTrue: [^self].
	element := self elementForTag: aNode dtdTag.
	children := aNode children reject: [:ea | ea isComment].	

	stream := ReadStream on: children.
	(element contentRule validateChildren: stream ofNode: aNode)  
		ifTrue:[]	
		ifFalse:
		[
			stream atEnd ifFalse: 
			[
				(self tag: aNode dtdTag canContainTag: stream peek dtdTag) ifFalse:
				[
					stream peek addError: (HtmlTagImproperlyNestedError new)
				]
			].
		]

]
