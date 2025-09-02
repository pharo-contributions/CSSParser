"
an entire HTML document.  It should have exactly two sub-entities when completed: a HEAD and a BODY
"
Class {
	#name : 'HtmlDocument',
	#superclass : 'HtmlDOMNode',
	#instVars : [
		'docType',
		'content',
		'requestUrl',
		'responseUrl',
		'dtdIsImplied',
		'loader'
	],
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'instance creation' }
HtmlDocument class >> emptyDocument [
	"return an empty document"
	^super new add: HtmlHead new; add: HtmlBody new
]

{ #category : 'access' }
HtmlDocument >> addToBody: anObject [
	"add an object to the Body entity of the receiver"
	self body add: anObject
]

{ #category : 'access' }
HtmlDocument >> addToHead: anObject [
	"add an object to the head entity of the receiver"
	self head add: anObject
]

{ #category : 'rendering' }
HtmlDocument >> addToHtmlMorph: aHtmlBlockMorph [
	self renderChildrenInto: aHtmlBlockMorph
]

{ #category : 'parsing' }
HtmlDocument >> allStyles [

	| rules |

	rules := OrderedCollection new.
	self stylesheets do: [:sheet | rules addAll: (sheet children select:[:ea | ea isStyleRule])].
	^rules asArray
]

{ #category : 'parsing' }
HtmlDocument >> applyStyles [

	"TODO: Optimize this based on information described at " 	"http://weblogs.mozillazine.org/hyatt/archives/2005_05.html#007507"

	| rules set |

	rules := self allStyles.
	rules do:[:ea | ea matchCount: 0].
	rules := rules reject:[:ea | ea selector isValid not].
	set := CSSRuleSet new.
	rules do: [:ea | ea addToRuleSet: set].

	self nodesDo:
	[:ea | 
		(ea tag = 'img' or: [ "workaround - let img ignore styles. TODO: fix display style on images"
		ea isCSS ])
			ifFalse: 
			[
				(set candidateRulesForNode: ea) do: 
				[:rule | 
					(rule selector matches: ea) 
						ifTrue: [ea addStyle: rule. rule matchCount: rule matchCount + 1]
				].
				(ea attributes includesKey: 'style') ifTrue: 
				[
					|  styleRule style |
					style := (ea attributes at: 'style').
					styleRule := (CSSNodeAttributeStyleRule new content: style).
					ea addStyle: styleRule.
				].
			]
	]. 
]

{ #category : 'accessing' }
HtmlDocument >> associatedForm [
	^ nil
]

{ #category : 'access' }
HtmlDocument >> body [
	^self contents at: 2
]

{ #category : 'accessing' }
HtmlDocument >> content [
	"Answer the value of content"

	^ content
]

{ #category : 'accessing' }
HtmlDocument >> content: anObject [
	"Set the value of content"

	content := anObject
]

{ #category : 'parsing' }
HtmlDocument >> createImpliedNodes [

	(self children detect: [:ea | ea tag = 'html'] ifNone:[nil]) ifNil: 
	[self children: 
		(Array with: 
			(HtmlHTMLNode new children: self children; 
				start: self start; 
				end: self end; 
				isImplied: true))
	].
	super createImpliedNodes.
]

{ #category : 'accessing' }
HtmlDocument >> docType [
	"Answer the value of docType"

	docType isNil ifTrue: [docType := Html401Strict docType].
	^docType
]

{ #category : 'accessing' }
HtmlDocument >> docType: anObject [
	"Set the value of docType"

	docType := anObject.
	self dtd: (HtmlDTD forDocType: anObject).
]

{ #category : 'accessing' }
HtmlDocument >> document [

	^self
]

{ #category : 'accessing' }
HtmlDocument >> dtd [

	^dtd isNil 
		ifTrue: [dtd:=HtmlDTD forDocType: self docType] 
		ifFalse: [dtd]
]

{ #category : 'accessing' }
HtmlDocument >> dtdIsImplied [
	"Answer the value of dtdIsImplied"

	^ dtdIsImplied
]

{ #category : 'accessing' }
HtmlDocument >> dtdIsImplied: anObject [
	"Set the value of dtdIsImplied"

	dtdIsImplied := anObject
]

{ #category : 'formatting' }
HtmlDocument >> formattedText [
	"return a version of this document as a formatted Text"
	| formatter |
	formatter := HtmlFormatter preferredFormatterClass new.
	self addToFormatter: formatter.
	^formatter text 
]

{ #category : 'formatting' }
HtmlDocument >> formattedTextForBrowser: browser  defaultBaseUrl: defaultBaseUrl [
	"return a version of this document as a formatted Text (which includes links and such)"
	| formatter text |

	"set up the formatter"
	formatter := HtmlFormatter preferredFormatterClass new.
	formatter browser: browser.
	formatter baseUrl: defaultBaseUrl.  "should check if the document specifies something else"

	"do the formatting"
	self addToFormatter: formatter.

	"get and return the result"
	text := formatter text.
	^text
]

{ #category : 'formatting' }
HtmlDocument >> formattedTextMorph [
	"return a version of this document as a formatted TextMorph (which includes links and such)"
	| formatter text textMorph |
	formatter := HtmlFormatter preferredFormatterClass new.
	self addToFormatter: formatter.
	text := formatter text .

	textMorph := TextMorph new initialize.
	textMorph contentsWrapped: text.

	^textMorph
]

{ #category : 'formatting' }
HtmlDocument >> formattedTextMorphForBrowser: browser  defaultBaseUrl: defaultBaseUrl [
	"return a version of this document as a formatted TextMorph (which includes links and such)"
	| formatter textMorph |

	"set up the formatter"
	formatter := HtmlFormatter preferredFormatterClass new.
	formatter browser: browser.
	formatter baseUrl: defaultBaseUrl.  "should check if the document specifies something else"

	"do the formatting"
	self addToFormatter: formatter.

	"get and return the result"
	textMorph := formatter textMorph .
	^textMorph
]

{ #category : 'access' }
HtmlDocument >> head [
	^self contents at: 1
]

{ #category : 'testing' }
HtmlDocument >> isDocument [

	^true
]

{ #category : 'accessing' }
HtmlDocument >> loader [
	"Answer the value of loader"

	^ loader isNil ifTrue: [loader := HtmlCache new] ifFalse: [loader]
]

{ #category : 'accessing' }
HtmlDocument >> loader: anObject [
	"Set the value of loader"

	loader := anObject
]

{ #category : 'testing' }
HtmlDocument >> mayContain: anElement [
	^true 	"not strictly true, but it makes the parser simpler"
]

{ #category : 'parsing' }
HtmlDocument >> mayContainTag: aTag [

	^true
]

{ #category : 'parsing' }
HtmlDocument >> parseContents: aStream [

	"tagParent: parent contents: aString stream: aStream"

	| s docTypeFound hasXMLDirective |

	docTypeFound := false.
	hasXMLDirective := false.

	self start: aStream position.

	content := aStream contents.

	[aStream atEnd not] whileTrue:
	[
		| p |
		p := aStream position.
		
		"If we skip separatos, we will be neglecting spaces WTF?!
		aStream skipSeparators."
		
		s := aStream upTo: $<.
		s size > 0 ifTrue: 
		[
			| pos |
			pos := aStream atEnd ifTrue: [aStream position] ifFalse: [aStream position-1].
			self addChild: 
				(HtmlCDATANode start: p 
								end: (pos max: p))
		].
		s := aStream upTo: $>.	

		(s size > 0 and:[s first = $! or: [(s first = $?) & (s last = $?)]]) ifTrue: 
		[
			s first = $? ifTrue:
			[
				hasXMLDirective := true.
				self parseProcessingDirective: s
			]
			ifFalse:
			[
				(s asUppercase beginsWith: '!DOCTYPE') ifTrue:
				[
					self docType: s.
					docTypeFound := true.
				]
				ifFalse:
				[
					| child |
					aStream skip: (s size+2)negated. 
					child := (HtmlCommentNode new) start: aStream position.
					self addChild: child.
					child parseContents: aStream.
				]
			]
		]
		ifFalse: "It is a tag"
		[
			(docType isNil and: [hasXMLDirective]) ifTrue:
			[
				self docType: XHtml1Transitional docType.
			]
			ifFalse:
			[
				docType isNil ifTrue: [self docType: Html401Strict docType].
			].
			s := s trimBoth.
			(s size > 0) ifTrue:
			[
				(s first = $/) ifTrue: "stray close tag I think"
				[
					| child |
					child := (HtmlDOMNode newForTag: s) 
							start: (aStream position - (s size) - 2); end: (aStream position).
					self addChild: child.
					child addError: (HtmlTagMissingStartError new 
							position: (aStream position - (s size) - 1); 
							tag: s).
				]
				ifFalse: "Nested Tag Found"
				[
					| child |
					child := (HtmlDOMNode tagContents: s) start: (aStream position - s size - 2).
					self addChild: child.
					child parseContents: aStream.
				]
			]
		]
	].
	self end: aStream position.
	"self createImpliedNodes."
	self dtdIsImplied: docTypeFound not.
	docTypeFound ifFalse: 
	[
		self dtdIsImplied: true.
		self addError: HtmlMissingDocTypeError new
	].
	

]

{ #category : 'parsing' }
HtmlDocument >> parseProcessingDirective: aString [

	| in |
	in := ReadStream on: aString.
	in upTo: $?.
	in skipSeparators.
	[Character separators includes: in peek] whileFalse: [in next].
	in skipSeparators.
	self parseAttributes: (in upTo: $?).	

]

{ #category : 'accessing' }
HtmlDocument >> requestUrl [
	"Answer the value of requestUrl"

	^ requestUrl
]

{ #category : 'accessing' }
HtmlDocument >> requestUrl: anObject [
	"Set the value of requestUrl"

	requestUrl := anObject
]

{ #category : 'accessing' }
HtmlDocument >> responseUrl [
	"Answer the value of responseUrl"

	^ responseUrl
]

{ #category : 'accessing' }
HtmlDocument >> responseUrl: anObject [
	"Set the value of responseUrl"

	responseUrl := anObject
]

{ #category : 'accessing' }
HtmlDocument >> stylesheets [

	| stylesheets |

	stylesheets := OrderedCollection new.

	self nodesDo:
	[:ea |
		((ea respondsTo: #stylesheet)and:[ea stylesheet notNil]) 
			ifTrue: [stylesheets add: ea stylesheet].
	].
	^stylesheets
	
]

{ #category : 'accessing' }
HtmlDocument >> tag [

	^'document'
]

{ #category : 'testing' }
HtmlDocument >> tagName [
	^'html'
]

{ #category : 'accessing' }
HtmlDocument >> uniqueId [

	^'D'
]

{ #category : 'accessing' }
HtmlDocument >> url [

	^self responseUrl
]
