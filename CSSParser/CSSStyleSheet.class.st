"
I represent a collection of CSS style rules
"
Class {
	#name : #CSSStyleSheet,
	#superclass : #CSSElement,
	#instVars : [
		'imports',
		'content',
		'url'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #'class initialization' }
CSSStyleSheet class >> fromFile: aStringOrFileRef [

	
	| doc url |
	url := aStringOrFileRef asFileReference.
	doc := url contents.
	^ doc isString
		  ifFalse: [ "life is good"
			  self new
				  content: doc content;
				  start: 0;
				  end: doc content size;
				  url: url ]
		  ifTrue: [ 
			  self new
				  content: doc;
				  start: 0;
				  end: doc size;
				  url: nil ]
]

{ #category : #'class initialization' }
CSSStyleSheet class >> fromUrl: aStringOrUrl [

	| doc url |

	url := aStringOrUrl asString.

	doc := HTTPSocket httpGetDocument: url args: nil accept: 'text/css' request: ''.
	^doc isString ifFalse: "life is good"
	[
		self new content: doc content; start: 0; end: doc content size; url: url		
	]
	ifTrue:
	[
		nil
	]


]

{ #category : #'class initialization' }
CSSStyleSheet class >> fromUrl: aStringOrUrl parent: aDOMNode [

	| doc href url |

	href := aStringOrUrl asString.
	((href beginsWith: 'http:') or: [(href beginsWith: 'https:') or:[href beginsWith: 'ftp:']]) 
	ifFalse:
	[
		url := (Url combine: aDOMNode document responseUrl asString withRelative: href).
	]
	ifTrue: [url := href].

	doc := HTTPSocket httpGetDocument: url args: nil accept: 'text/css' request: ''.
	^doc isString ifFalse: "life is good"
	[
		self new 
			content: doc content; 
			start: 0; end: doc content size; 
			parent: aDOMNode; 
			url: url;
			parseContents: (ReadStream on: doc content)		
	]
	ifTrue:
	[
		nil
	]


]

{ #category : #accessing }
CSSStyleSheet >> absoluteUrl [
	^self url asUrlRelativeTo: self document requestUrl asUrl
]

{ #category : #accessing }
CSSStyleSheet >> addImportedStyleSheet: anObject [
	"Set the value of imports"

	self imports: (self imports copyWith: anObject)
]

{ #category : #accessing }
CSSStyleSheet >> addImportedUrl: aUrl [

	| doc ss |

	doc := aUrl asUrl retrieveContents.
	ss := CSSStyleSheet new content: doc content; start: 0; end: doc content size.
	self addImportedStyleSheet: ss.
	ss parseContents: (ReadStream on: ss content).
]

{ #category : #accessing }
CSSStyleSheet >> content [
	"Answer the value of content"

	^content isNil 
		ifTrue: [self document content] 
		ifFalse: [content]
]

{ #category : #accessing }
CSSStyleSheet >> content: anObject [
	"Set the value of content"

	content := anObject
]

{ #category : #accessing }
CSSStyleSheet >> docType [

	^'Content-Type: text/css'
]

{ #category : #accessing }
CSSStyleSheet >> endTagMissing [

	^false
]

{ #category : #accessing }
CSSStyleSheet >> imports [
	"Answer the value of imports"

	imports isNil ifTrue:[imports := #()].
	^ imports
]

{ #category : #accessing }
CSSStyleSheet >> imports: anObject [
	"Set the value of imports"

	imports := anObject
]

{ #category : #testing }
CSSStyleSheet >> isComment [

	^false
]

{ #category : #testing }
CSSStyleSheet >> isInline [

	^url isNil
]

{ #category : #testing }
CSSStyleSheet >> isStyleSheet [

	^true
]

{ #category : #accessing }
CSSStyleSheet >> loadStyles [

	| doc |

	doc := self absoluteUrl retrieveContents.
	self 
		content: doc content; 
		start: 0; 
		end: doc content size.
	self parseContents: (ReadStream on: self content).
]

{ #category : #accessing }
CSSStyleSheet >> media [
	self parent isNil ifTrue:[^nil].
	^(self parent attributes at: 'media' ifAbsent: ['all']) findTokens: ', '
]

{ #category : #parsing }
CSSStyleSheet >> parseAtRule: aStream media: anArray [

	| label child s |
	label := WriteStream on: String new.
	aStream peek = $@ 
	ifFalse:[self halt]
	ifTrue:
	[
		s := aStream position.
		aStream next.
		aStream skipSeparators.

		[aStream peek isLetter or: [aStream peek isDigit or:['-_' includes: aStream peek]]] 
			whileTrue: [label nextPut: aStream next].

		label contents asLowercase = 'media' ifTrue:
		[
			| media array |

			media := aStream upTo: ${.
			array := (media findTokens: ', ') asArray.
			self parseStyles: aStream media: array.
		]
		ifFalse:
		[
			child := (CSSAtRule named: label contents) start: s; media: anArray.		
			self addChild: child.
			child parseContents: aStream.
		]
	]
]

{ #category : #parsing }
CSSStyleSheet >> parseContents: aStream [

	| in  |
	
	aStream upToAll: '<!--'.
	aStream position >= self end 
		ifTrue: 
		[
			in := ReadStream on: (aStream reset next: self end).
			in position: self start.
		]
		ifFalse: 
		[
			| styleEnd |
			aStream position: self end-1. 
			[(aStream position > start) and: [aStream peek ~= $>]] whileTrue: [aStream back].
			((aStream position > start) and: [aStream peek = $>]) ifTrue: [aStream back].
			[(aStream position > start) and: [aStream peek = $-]] whileTrue: [aStream back].
			styleEnd := aStream position.
			in := ReadStream on: (aStream reset next: styleEnd).
			in position: self start.
			in upToAll: '<!--'.			
		].
	
	in skipSeparators. 
	self parseStyles: in media: self media.
	
]

{ #category : #parsing }
CSSStyleSheet >> parseStyles: aStream media: anArray [

	aStream skipSeparators.
	[aStream atEnd] whileFalse: 
	[
		aStream skipSeparators.
		aStream peek = $} ifTrue: [aStream next. ^self]. "End of media block"
		(aStream peek = $/ and: [aStream next. aStream peek = $*]) 
		ifTrue: 
		[
			| child |
			aStream back. 
			child := CSSComment new start: aStream position.
			self addChild: child.
			child parseContents: aStream.
		]
		ifFalse:
		[	
			(aStream peek = $@) 
			ifTrue: "Read the imports"
			[
				self parseAtRule: aStream media: anArray.
			]
			ifFalse:
			[
				aStream atEnd ifFalse:
				[
					| child |

					child := CSSStyleRule new start: aStream position; media: anArray.
					self addChild: child.
					child parseContents: aStream.
				]
			]
		]
	]
]

{ #category : #accessing }
CSSStyleSheet >> stylesheetDocument [
	^ self
]

{ #category : #accessing }
CSSStyleSheet >> tag [

	^'css-stylesheet'
]

{ #category : #accessing }
CSSStyleSheet >> url [
	"Answer the value of url"

	^ url isNil ifTrue: [self document url] ifFalse: [url]
]

{ #category : #accessing }
CSSStyleSheet >> url: anObject [
	"Set the value of url"

	url := anObject
]
