"
<LINK rel=""stylesheet"" type=""text/css"" name=""anyname"" href=""url"">
"
Class {
	#name : 'HtmlLINKNode',
	#superclass : 'HtmlDOMNode',
	#instVars : [
		'stylesheet',
		'href'
	],
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlLINKNode >> href [
	"Answer the value of href"

	^ href
]

{ #category : 'accessing' }
HtmlLINKNode >> href: anObject [
	"Set the value of href"

	href := anObject
]

{ #category : 'parsing' }
HtmlLINKNode >> parseContents: aStream [

	| rel |

	rel := self attributes keys detect: [:ea | ea asLowercase = 'rel'] ifNone: [nil].
	(rel notNil and: [((self attributes at: rel) asLowercase findTokens: ' ') includes: 'stylesheet']) 
	ifTrue: 
	[
		href := self attributes keys detect: [:ea | ea asLowercase = 'href'] ifNone: [nil].
		href isNil ifFalse: 
		[
			href := self attributes at: href.
			(href notNil and:[href size > 0]) ifTrue:
			[
				self loader queueUrl: href. "Start download in another thread"
			]
			ifFalse: [href := nil].
		]
	].
	super parseContents: aStream
]

{ #category : 'accessing' }
HtmlLINKNode >> stylesheet [
	"Answer the value of stylesheet"

	| |

	(stylesheet isNil and: [href notNil])
	ifTrue:
	[
		| doc |
		doc := self loader documentForUrl: self href.
		doc ifNil: [^nil].
		stylesheet := CSSStyleSheet new parent: self; 
			start: 0; 
			content: doc content; 
			end: doc content size;
 			url: self href; 
			parseContents: (ReadStream on: doc content)
	].	
	^ stylesheet
]

{ #category : 'accessing' }
HtmlLINKNode >> stylesheet: anObject [
	"Set the value of stylesheet"

	stylesheet := anObject
]

{ #category : 'accessing' }
HtmlLINKNode >> tag [
	^ 'link'
]
