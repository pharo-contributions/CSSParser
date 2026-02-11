Class {
	#name : 'HtmlDOMNode',
	#superclass : 'HtmlParseNode',
	#instVars : [
		'attributes',
		'hasTrailingSlash',
		'isImplied',
		'dtd',
		'endTagMissing',
		'styles',
		'id',
		'classes',
		'htmlMorph',
		'associatedForm',
		'computedStyles',
		'isRenderedInline'
	],
	#classVars : [
		'DefaultRules',
		'HTML401'
	],
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'instance creation' }
HtmlDOMNode class >> fromStream: aStream [

	| s doctype html |

	doctype := nil.
	aStream skipSeparators.
	s := aStream upTo: $<.
	s := aStream upTo: $>.
	s size = 0 ifTrue: [aStream reset. ^nil].
	(s asUppercase beginsWith: '!DOCTYPE') ifTrue:
	[
		doctype := s.		
		s := aStream upTo: $<.
		s := aStream upTo: $>.
	].
	
	html := (self tagContents: s) start: (aStream position - s size - 2); parseContents: aStream.			
	^html docType: doctype
]

{ #category : 'instance creation' }
HtmlDOMNode class >> newForTag: aTag [ 

	| node className cls tag |

	tag := aTag trimBoth.
	node := nil.

	className := ('Html',tag asUppercase,'Node') asSymbol.

	cls := Smalltalk at: className ifAbsent: [HtmlDOMNode].

	node := cls new tag: tag;
			hasTrailingSlash: false; 
			attributes: Dictionary new.

	tag asLowercase = tag ifFalse: 
	[
		node addError: (HtmlTagNotLowerCaseError new tag: tag).
	].

	^node

]

{ #category : 'instance creation' }
HtmlDOMNode class >> tagContents: aTag [ 

	| node className cls tag in out trimmedTag endsWithSlash |

	trimmedTag := aTag trimBoth.
	node := nil.
	in := ReadStream on: aTag.
	out := WriteStream on: (String new:20).

	in skipSeparators.
	[in atEnd not and: [in peek isAlphaNumeric]] whileTrue: [out nextPut: in next].

	tag := out contents.

	className := ('Html',tag asUppercase,'Node') asSymbol.

	cls := Smalltalk at: className ifAbsent: [HtmlDOMNode].

	endsWithSlash := (trimmedTag last = $/) ifTrue:
	[
		(trimmedTag detect:[:ea | ea isSeparator] ifNone: [nil]) isNil or:
			[(trimmedTag at: ((trimmedTag size -1))) isSeparator]
	]
	ifFalse: [false ].

	node := cls new tag: tag;
			hasTrailingSlash: endsWithSlash; 
			parseAttributes: (trimmedTag last: (trimmedTag size - tag size)).

	tag asLowercase = tag ifFalse: 
	[
		node addError: (HtmlTagNotLowerCaseError new tag: tag).
	].

	^node

]

{ #category : 'initialize-release' }
HtmlDOMNode >> addDefaultStyle [
	"Do nothing"
]

{ #category : 'accessing' }
HtmlDOMNode >> addStyle: aStyleRule [

	
	self styles: (self styles copyWith: aStyleRule)
]

{ #category : 'accessing' }
HtmlDOMNode >> associatedForm [
	^ associatedForm ifNil: [ associatedForm := self parent associatedForm ]
]

{ #category : 'accessing' }
HtmlDOMNode >> attributes [
	"Answer the value of attributes"

	^ attributes ifNil: [attributes:=Dictionary new]
]

{ #category : 'accessing' }
HtmlDOMNode >> attributes: anObject [
	"Set the value of attributes"

	| cstr |
	
	attributes := Dictionary new.
	anObject keysAndValuesDo: 
		[ :eachKey :eachValue | attributes at: eachKey asLowercase put: 
			(eachValue 
				ifNotNil: [:value | value asUnHtml] 
				ifNil: [nil])].
	id := (attributes at: 'id' ifAbsent: [nil]).
	cstr := attributes at: 'class' ifAbsent: [nil].
	classes := cstr isNil ifTrue: [#()] ifFalse: [cstr findTokens: ' ']
]

{ #category : 'accessing' }
HtmlDOMNode >> boxType [

	^ ((CSSStyleResolver for: self) getStyle: #display) ifNil: [ #inline ]
]

{ #category : 'accessing' }
HtmlDOMNode >> childDTDTags [

	^((self children collect: [:ea | ea dtdTag]) reject:[:ea | ea = 'COMMENT']) asArray
]

{ #category : 'accessing' }
HtmlDOMNode >> childTags [

	^((self children collect: [:ea | ea tag]) reject:[:ea | ea = 'comment']) asArray
]

{ #category : 'accessing' }
HtmlDOMNode >> classes [
	
	^classes isNil ifTrue: [#()] ifFalse: [classes]
]

{ #category : 'accessing' }
HtmlDOMNode >> closeTagIsOptional [

	^self dtd tagCloseIsOptional: self dtdTag
]

{ #category : 'accessing' }
HtmlDOMNode >> closeTagMissing [
	

	^self endTagMissing
]

{ #category : 'accessing' }
HtmlDOMNode >> computedStyles [

	^ computedStyles
]

{ #category : 'accessing' }
HtmlDOMNode >> computedStyles: anObject [

	computedStyles := anObject
]

{ #category : 'accessing' }
HtmlDOMNode >> content [

	^self parent content
]

{ #category : 'parsing' }
HtmlDOMNode >> createImpliedNodes [

	self children do:[:ea | ea createImpliedNodes]
]

{ #category : 'accessing' }
HtmlDOMNode >> dtd [

	dtd isNil ifTrue: [self parent notNil ifTrue: [dtd := self parent dtd]].
	dtd isNil ifTrue: [self halt].
	^dtd
]

{ #category : 'accessing' }
HtmlDOMNode >> dtd: aDTD [

	dtd := aDTD
]

{ #category : 'accessing' }
HtmlDOMNode >> dtdTag [

	^self dtd isXML ifFalse: [self tag asUppercase] ifTrue: [self tag]
]

{ #category : 'accessing' }
HtmlDOMNode >> endTagMissing [
	"Answer the value of endTagMissing"

	^self hasTrailingSlash 
		ifTrue:[false] 
		ifFalse:
		[
			endTagMissing isNil ifTrue: [endTagMissing := false].
			endTagMissing
		]
]

{ #category : 'accessing' }
HtmlDOMNode >> endTagMissing: anObject [
	"Set the value of endTagMissing"

	endTagMissing := anObject
]

{ #category : 'accessing' }
HtmlDOMNode >> hasTrailingSlash [

	^hasTrailingSlash isNil ifTrue: [false] ifFalse: [hasTrailingSlash] 
]

{ #category : 'accessing' }
HtmlDOMNode >> hasTrailingSlash: anObject [
	"Set the value of hasTrailingSlash"

	hasTrailingSlash := anObject
]

{ #category : 'accessing' }
HtmlDOMNode >> id [

	^id
]

{ #category : 'initialize-release' }
HtmlDOMNode >> initialize [
	super initialize.
	self addDefaultStyle
]

{ #category : 'testing' }
HtmlDOMNode >> isCDATA [

	^false
]

{ #category : 'testing' }
HtmlDOMNode >> isCSS [

	^false
]

{ #category : 'testing' }
HtmlDOMNode >> isComment [

	^false
]

{ #category : 'testing' }
HtmlDOMNode >> isDocument [

	^false
]

{ #category : 'accessing' }
HtmlDOMNode >> isImplied [
	
	^isImplied isNil ifTrue: [^false] ifFalse: [isImplied]
]

{ #category : 'accessing' }
HtmlDOMNode >> isImplied: trueOrFalse [
	
	isImplied := trueOrFalse
]

{ #category : 'accessing' }
HtmlDOMNode >> isRenderedInline [
	
	| boxType |
	isRenderedInline ifNotNil: [ :value | ^ value ].
	
	boxType := self boxType.
	boxType == #inlineBlock
		ifTrue: [ ^ isRenderedInline := true ].

	boxType == #inline
		ifFalse: [ ^ isRenderedInline := false ].
	
	self children
		ifEmpty: [ ^ isRenderedInline := true ]
		ifNotEmpty: [ ^ isRenderedInline := self children allSatisfy: [ :child | child isRenderedInline ]]
]

{ #category : 'accessing' }
HtmlDOMNode >> isSelfContained [

	^self hasTrailingSlash or: [self dtd tagIsEmpty: self dtdTag]
]

{ #category : 'testing' }
HtmlDOMNode >> isStyleSheet [

	^false
]

{ #category : 'accessing' }
HtmlDOMNode >> loader [

	^self document loader
]

{ #category : 'parsing' }
HtmlDOMNode >> mayContainTag: aTag [

	^self isComment 
		ifTrue:[false] 
		ifFalse:[self dtd tag: self dtdTag canContainTag: aTag]
]

{ #category : 'parsing' }
HtmlDOMNode >> parseAttributes: attrString [

	| attrs in s |
	attrs := Dictionary new. 

	s := attrString trimBoth.
	(s endsWith: '/') ifTrue: [ s:= s first: (s size-1) ].

	in := ReadStream on: s trimBoth.

	[in atEnd] whileFalse:
	[
		| k v pos |
		in skipSeparators.
		pos := in position.
		v := nil.
		k := in upTo: $=.
		k := k trimBoth.
		(k includes: $ ) ifTrue: "Looks like there is no value. "
		[			
			in position: pos. 
			k:= in upTo: $ . 
		]
		ifFalse:
		[
			in skipSeparators.
			in atEnd ifFalse:
			[
				(in next = $") ifTrue: [v := in upTo: $"]
				ifFalse:
				[
					in back.
					(in next = $') ifTrue: [v := in upTo: $']
					ifFalse:
					[
						in back.
						v := in upTo: $ .
						self addError: (HtmlAttributeValueNotQuotedError new attribute: k).
					]
				]		 
			]
		].

		attrs at: k ifPresent:
		[:val | 
			self addError: (HtmlAttributeMultiplySpecifiedError new 
				attribute: k; value: v value: val).
		].
		attrs at: k put: v.
	].
	self attributes: attrs.
]

{ #category : 'parsing' }
HtmlDOMNode >> parseContents: aStream [

	"tagParent: parent contents: aString stream: aStream"

	| s |

	self isSelfContained ifTrue: [^self end: aStream position; endTagMissing: true].

	[self end isNil and:[aStream atEnd not]] whileTrue:
	[
		aStream skipSeparators.

		s := aStream upTo: $<.
		s size > 0 ifTrue: 
		[
			self addChild: (HtmlCDATANode start: self startForNextElement 
								end: (aStream atEnd ifFalse:[aStream position-1] ifTrue: [aStream position]))

		].

		s := aStream upTo: $>.	

		(s size > 0 and:[s first = $! or: [(s first = $?) & (s last = $?)]]) ifTrue: 
		[
			s first = $? ifTrue:
			[
				"blow off the processing directive"
				"aStream skip: (s size+2)negated. 
				self addChild: (HtmlDOMNode parseProcessingDirective: aStream)."
			]
			ifFalse:
			[
				| child |
				aStream skip: (s size+2)negated. 
				(self dtd isXML and: [s beginsWith: '<![CDATA[']) ifFalse:
				[
					child := (HtmlCommentNode new) start: aStream position.
				]
				ifTrue:
				[
					child := (HtmlXMLCDataNode new) start: aStream position.
				].
				self addChild: child.
				child parseContents: aStream.
			]
		]
		ifFalse: "It is a tag"
		[
			(s includes: $<) ifTrue: [s := self recoverFromLTIn: s stream: aStream]. 			
			(s trimBoth beginsWith: '/') ifTrue: 
			[
				| closeTag |
				closeTag := (s findTokens: ('/',Character separators)) first asLowercase.
				closeTag = self tag ifTrue: 
				[
					self end: aStream position; endTagMissing: false.
					^self
				]
				ifFalse:
				[
					(self hasAncestor: closeTag) ifTrue:
					[
						self addError: (HtmlTagMissingEndError new).
						aStream skip: (s size + 2) negated.
						^self end: (aStream position); endTagMissing: true
					]
					ifFalse:
					[
						| child |
						child := (HtmlDOMNode newForTag: s) 
							start: (aStream position - (s size) - 2); end: (aStream position).
							self addChild: child.
							child addError: (HtmlTagMissingStartError new 
								position: (aStream position - (s size) - 1); 
								tag: s).
					]
				]
			]
			ifFalse: "Nested Tag Found"
			[
				"Does the new tag imply termination?"
				| short |
				short := (s findTokens: ('/',Character separators)).
				short := short size > 0 ifTrue: [short first] ifFalse: [short].
				"The above hack and aStream atEnd guards against input underflow"
				(aStream atEnd or:[((self mayContainTag: short) not 
					and: [self closeTagIsOptional])
					and:
					[
						| likelyParent |
						likelyParent := self detectAncestor:[:p | p mayContainTag: short]. 
						(likelyParent level > 0 and: [(self level - likelyParent level) < 3])
							or: [short = self tag] "siblings"
					]
				])
				ifTrue:
				"Fake a termination"
				[
					self end: (aStream atEnd ifFalse: [aStream position - s size - 2] ifTrue: [aStream position]); 
						endTagMissing: true.
					aStream atEnd ifFalse: [aStream skip: (s size + 2) negated].
					^self
				]
				ifFalse:
				[
					(short size > 0 and: [short first isLetter]) ifTrue:
					[
						| child |
						child := (HtmlDOMNode tagContents: s) start: (aStream position - s size - 2).
						self addChild: child.
						child parseContents: aStream.
					]
					ifFalse:
					[
						self addChild: (HtmlCDATANode start: self startForNextElement 
								end: aStream position)
					]
				]
			]
		]
	].
	(aStream atEnd and:[end isNil]) ifTrue: 
	[
		self end: aStream position.
		self endTagMissing: true.
	].

]

{ #category : 'accessing' }
HtmlDOMNode >> rawTag [

	^tag
]

{ #category : 'parsing' }
HtmlDOMNode >> recoverFromLTIn: aString stream: in [

	| s  |

	in skip: (aString size - (aString lastIndexOf: $<)) negated-1.

	((self children isEmpty not) and: [self children last isCDATA]) ifTrue:
	[
		self children last end: in position -1.
	]
	ifFalse: 
	[
		self addChild:
				(HtmlCDATANode start: self startForNextElement
								end: in position-1)		
	].
	s := in upTo: $>.
	^s
]

{ #category : 'accessing' }
HtmlDOMNode >> styles [

	^styles isNil ifTrue: [#()] ifFalse: [styles]
]

{ #category : 'accessing' }
HtmlDOMNode >> styles: anArray [

	
	styles := anArray
]

{ #category : 'accessing' }
HtmlDOMNode >> tag [
	"Answer the value of tag"

	^ tag isNil ifFalse: [tag asLowercase] ifTrue: [tag]
]

{ #category : 'accessing' }
HtmlDOMNode >> tag: anObject [
	"Set the value of tag"

	tag := anObject.
]

{ #category : 'accessing' }
HtmlDOMNode >> tagsNamed: aName [

	^self nodesSelect:[:ea | ea tag = aName]
]

{ #category : 'accessing' }
HtmlDOMNode >> uniqueId [

	^(self parent uniqueId, '.', ((self parent children indexOf: self) asString))
]
