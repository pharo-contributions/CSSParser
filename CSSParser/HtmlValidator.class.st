"
I validate html for correctness.  I am the usual entry point into this library.  Typical usage for simply obtaining a DOM of a webpage might be (HtmlValidator onUrl: 'http://www.amazon.com' asUrl) dom.  If you want the DOM decorated with errors, then call validate.  

Author: Todd Blanchard, 2006.  tblanchard@mac.com

Free for any use that does not involve providing QA software packages or services for websites on a commercial or non-commercial basis.
"
Class {
	#name : 'HtmlValidator',
	#superclass : 'Object',
	#instVars : [
		'url',
		'document',
		'errors',
		'dom',
		'content',
		'loader'
	],
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'instance creation' }
HtmlValidator class >> on: aString [

	^self new content: aString
]

{ #category : 'instance creation' }
HtmlValidator class >> onUrl: aStringOrUrl [

	^self new url: aStringOrUrl asUrl 
]

{ #category : 'actions' }
HtmlValidator >> bruteForceAnalyze [

	"Maybe add more as I think of things"


	^self checkHtmlHeadBody
]

{ #category : 'actions' }
HtmlValidator >> checkHtmlHeadBody [

	| structure in tags pos tag patterns |

	structure := OrderedCollection new.
	patterns := #( "These are the only valid combinations"
				#( '<html' '<head' '</head' '<body' '</body' '</html')
				#( '<html' '<body' '</body' '</html')
				#( '<html' '<head' '</head' '</html')
				#( '<html' '</html')
				#( '<body' '</body')
				#( '<head' '</head' )
				#( )
			).
	tags := 	patterns first.

	in := ReadStream on: self content asLowercase.

	[in atEnd] whileFalse:
	[
		| min locs |
		pos := in position.

		locs := (tags collect: [:ea | in position: pos; upToAll: ea; position]). 	
		(locs reject:[:ea | locs first = ea])	isEmpty ifFalse:
		[
			min := locs min.
			tag := tags at: (locs indexOf: min).

			structure add: tag.
			in position: min.
			in atEnd ifFalse: [in skip: 1].
		]
		ifTrue: [in upToEnd].
	].
	structure := structure asArray.
	((patterns detect: [:ea | structure = ea] ifNone: [nil]) notNil) ifFalse:  
	[
		self dom addError: (HtmlHeadBodyNestingError new nesting: structure asArray). 
	]
	ifTrue:
	[
		(dom children size > 1 and: 
			[(dom children detect:[:ea | ea tag = 'html'] ifNone:[nil]) notNil]) ifTrue:
		[
			dom children do:
			[:ea | 
				(ea isComment or: [ea tag = 'html']) ifFalse: 
				[
					ea addError:(HtmlTagImproperlyNestedError new).
				]
			]
		]
	]
	
]

{ #category : 'accessing' }
HtmlValidator >> content [
	"Answer the value of content"

	^ content isNil 
		ifFalse: [content]
		ifTrue: [content := self document content]
	
]

{ #category : 'accessing' }
HtmlValidator >> content: anObject [
	"Set the value of content"

	content := anObject
]

{ #category : 'accessing' }
HtmlValidator >> cssErrors [

	| list |
	list := OrderedCollection new.
	self stylesheets do:
	[:ss |
		list addAll: (ss allErrorsMatching: [:ea | ea isCSSError])
	].
	^list asArray
]

{ #category : 'accessing' }
HtmlValidator >> document [
	"Answer the value of document"

	document isNil ifTrue: 
	[
		url isNil 
			ifTrue: [nil]
			ifFalse: 
			[
				document := self loader documentForUrl: self url.
				loader url: document url.
			] 
	].
	^document 
]

{ #category : 'accessing' }
HtmlValidator >> document: anObject [
	"Set the value of document"

	document := anObject
]

{ #category : 'accessing' }
HtmlValidator >> dom [
	"Answer the value of dom"

	dom isNil ifTrue: [self parse].
	^ dom
]

{ #category : 'accessing' }
HtmlValidator >> dom: anObject [
	"Set the value of dom"

	dom := anObject
]

{ #category : 'accessing' }
HtmlValidator >> errors [
	"Answer the value of errors"

	^ errors
]

{ #category : 'accessing' }
HtmlValidator >> errors: anObject [
	"Set the value of errors"

	errors := anObject
]

{ #category : 'accessing' }
HtmlValidator >> htmlErrors [

	^self dom allErrorsMatching: [:ea | ea isCSSError not ]
]

{ #category : 'initialize-release' }
HtmlValidator >> initialize [

	super initialize.

]

{ #category : 'accessing' }
HtmlValidator >> loader [
	"Answer the value of loader"

	^ loader isNil ifTrue: [loader := HtmlCache new url: self url] ifFalse: [loader]
]

{ #category : 'accessing' }
HtmlValidator >> loader: anObject [
	"Set the value of loader"

	loader := anObject
]

{ #category : 'actions' }
HtmlValidator >> parse [

	| in |
	
	in := ReadStream on: self content.
	self dom: (HtmlDocument new loader: self loader;
			requestUrl: self url; 
			responseUrl: (self document isNil ifTrue: [nil] ifFalse: [self document url]); 
			parseContents: in)

]

{ #category : 'actions' }
HtmlValidator >> parseStylesheets [

	self dom stylesheets

]

{ #category : 'accessing' }
HtmlValidator >> stylesheets [

	^self dom stylesheets
]

{ #category : 'accessing' }
HtmlValidator >> url [
	"Answer the value of url"

	^ url
]

{ #category : 'accessing' }
HtmlValidator >> url: anObject [
	"Set the value of url"

	url := anObject asUrl.

]

{ #category : 'actions' }
HtmlValidator >> validate [

	| dtd |
	
	self parse.
	self checkHtmlHeadBody.
	dtd := HtmlDTD forDocType: self dom docType.
	self dom applyStyles.
	self validateAgainstDTD: dtd.
	self validateCSSImports.
	self validateCSSAgainstDTD: dtd
]

{ #category : 'actions' }
HtmlValidator >> validateAgainstDTD: dtd [

	self dom nodesDo:
	[:ea |
		(ea isComment or: [ea isCDATA or: [ea isDocument or: [ea isCSS]]]) ifFalse:
		[
			(dtd tagIsReal: ea dtdTag) 
			ifFalse: [ea addError: (HtmlTagUnknownError new)]	
			ifTrue:
			[
				dtd validateChildrenOfNode: ea.
			 	dtd validateAttributesOfNode: ea.
			]
		]
		ifTrue:
		[
			(ea isCDATA) ifTrue: [ea checkForUnescapedCharacters]
			ifFalse: 
			[
				(ea isComment) ifTrue: 
				[
					ea endTagMissing ifTrue: 
					[
						ea addError: HtmlUnclosedCommentError new
					]
				]
			]
		]
	]
]

{ #category : 'actions' }
HtmlValidator >> validateCSSAgainstDTD: dtd [

	| rules  color backgroundColor |

	rules := dom allStyles.
	rules do:
	[:ea |
		ea selector isValid ifFalse: [ea addError: CSSSelectorNotValidError new]
		ifTrue:
		[
			ea selector isCSS3 ifTrue: [ea addError: CSSVersion3ConstructFoundError new].
			ea selector typeSelectors do:
			[:sel |
				sel element = sel element asLowercase ifFalse:
				[
					ea addError: (CSSSelectorElementNotLowercaseError new element: sel element).
				].
				(dtd tagIsReal: (dtd isXML 
					ifTrue: [sel element asLowercase] 
					ifFalse:[sel element asUppercase])) 
				ifFalse:
				[
					ea addError: (CSSSelectorElementNotValidError new element: sel element)
				]
			].
			(ea matchCount = 0 and: [ea selector isValid]) ifTrue:
			[
				ea addError: CSSUnmatchedRuleError new.		
			].
			ea properties do:
			[:prop |
				| lcname |
				lcname := prop propertyName asLowercase.
				prop propertyName = lcname ifFalse: 
				[
					ea addError:
					(CSSPropertyNameNotLowercaseError new propertyName: prop propertyName).
					prop propertyName: lcname.
				].
 
				prop definition isNil ifTrue:
				[
					ea addError: 
					(CSSPropertyUnknownError new propertyName: prop propertyName)
				]
				ifFalse:
				[
					prop valueIsValid ifFalse:
					[
						ea addError: 
						(CSSPropertyValueNotValidError new propertyName: prop propertyName)					
					]
				]
			].

			color := backgroundColor := nil.

			ea properties do:
			[:prop |
				prop propertyName = 'color' ifTrue: [ color:= prop].
				prop propertyName = 'background-color' ifTrue: [backgroundColor := prop].

			].

			color = backgroundColor ifFalse:
			[
				color isNil ifTrue: 
				[
					ea addError: 
					(CSSColorAndBackgroundColorNotSet new propertyName: 'color')
				]
				ifFalse:
				[
					backgroundColor isNil ifTrue:
					[
						ea addError: 
					(CSSColorAndBackgroundColorNotSet new propertyName: 'background-color')
					]
				]
			]
		]
	]
	
]

{ #category : 'actions' }
HtmlValidator >> validateCSSImports [

	| ss styleFound |
	ss := dom stylesheets.
	ss do:
	[:ea |
		styleFound := false.
		ea children do:
		[:rule |
			styleFound ifFalse:
			[
				rule isStyleRule ifTrue:[ styleFound := true]
			]
			ifTrue:
			[
				rule isAtImportRule ifTrue:
				[
					rule addError: (CSSImportAfterStyleRuleError new)
				]
			]
		]


	]

]
