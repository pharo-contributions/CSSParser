"
A filter which formats an HtmlDocument into a nice-looking Text suitable for a web browser such as Scamper.  See HtmlFormatter class example1 for usage information.

In principle, this formatter, along with the associated addToFormatter: methods, attempts to format any HTML which is fed to it.

"
Class {
	#name : 'HtmlFormatter',
	#superclass : 'Object',
	#instVars : [
		'browser',
		'baseUrl',
		'outputStream',
		'preformattedLevel',
		'indentLevel',
		'urlLink',
		'listLengths',
		'listStyleTypes',
		'listTypes',
		'precedingSpaces',
		'precedingNewlines',
		'morphsToEmbed',
		'incompleteMorphs'
	],
	#classVars : [
		'CSNonSeparators',
		'CSSeparators'
	],
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'examples' }
HtmlFormatter class >> example1 [
	"(HtmlFormatter example1 asParagraph compositionRectangle: (0@0 extent: 300@500) ) displayAt: 0@0"
	| input |
	input := ReadStream on: 
'<html>
<head>
<title>The Gate of Chaos</title>
</head>

<body>

<h1>Chaos</h1>



<h2>Into the Maelstrom</h2>
Direction is useless in the ever-changing Maelstrom.  However,
if you wander with purpose, you might be able to find....
<ul>
<li><a href="/cgi-bin/w">see who''s logged in</a>
<li><a href="/Telnet/connect.html">log in, if you (oooh) have an account</a>
<li><a href="http://chaos.resnet.gatech.edu:9000/sw">The Chaos Swiki</a>--scribble on chaos
<li>the original <a href="/cgi-bin/guestlog-print">Visitor Sands</a>
<li>my old <a href="rant.html">Rant Page</a>
<li>neverending <a href="/cgi-bin/bread">poll</a>: do you have an opinion on bread?
<li>a <a href="http://www.cc.gatech.edu/~lex/linux.html">Linux page</a>-- free UNIX for PC''s!
<li><a href="english.au">Hear Linus Himself speak!!</a>
<li><a href="/doc/">some docs on all kinds of computer stuff</a>
</ul>

<hr>


<h2>Paths of Retreat</h2>
Several commonly travelled ways have left paths leading 
<em>away</em> from the maelstrom, too:
<p>
<ul>
<li><a href="friends.html">Friends of Chaos</a>
<li><a href="http://www.apache.org/">The <em>Apache</em> home page</a> -- 
        <em>Chaos</em>''s WWW server!
<li><a href="http://www.ee.umanitoba.ca/~djc/personal/notscape.html">
Notscape</a>

the <a href="http://www.eskimo.com/%7Eirving/anti-ns/">Anti-Netscape
Page</a> -- fight the tyranny!
</ul>

<hr>
<a href="/analog/usage.html">usage stats</a> for this server

<hr>
<a href="http://www.eff.org/blueribbon.html"><img src="blueribbon.gif" alt="[blue ribbon campaign]"></a>
<a href="http://www.ee.umanitoba.ca/~djc/personal/notscape.html">
<img src="notscape.gif" alt="[NOTscape]">
</a>
<a href="http://www.anybrowser.org/campaign/">
<img src="anybrowser3.gif" alt="[Best Viewed With Any Browser"]></a>
</body>
</html>'.
	^(HtmlParser parse: input) formattedText
]

{ #category : 'initialization' }
HtmlFormatter class >> initialize [
	"HtmlFormatter initialize"

	CSSeparators := CharacterSet separators.
	CSNonSeparators := CSSeparators complement.
]

{ #category : 'instance creation' }
HtmlFormatter class >> new [
	^super new initialize
]

{ #category : 'instance creation' }
HtmlFormatter class >> preferredFormatterClass [
	^DHtmlFormatter
]

{ #category : 'formatting commands' }
HtmlFormatter >> addChar: c [
	"add a single character, updating all the tallies"

	"add the character to the output"
	outputStream nextPut: c.

	"update counters for preceeding spaces and preceding newlines"
	(c = Character space or: [ c = Character tab ]) 
	ifTrue: [ precedingSpaces := precedingSpaces+1.  precedingNewlines := 0 ]
	ifFalse: [
		(c = Character cr) ifTrue: [
			precedingSpaces := 0.
			precedingNewlines := precedingNewlines + 1 ]
		ifFalse: [
			precedingSpaces := precedingNewlines := 0 ] ].
]

{ #category : 'image maps' }
HtmlFormatter >> addImageMap: anImageMap [
	imageMaps addLast: anImageMap
]

{ #category : 'formatting commands' }
HtmlFormatter >> addIncompleteMorph: aMorph [
	"add a morph, and note that it needs to download some more state before reaching its ultimate state"
	self addMorph: aMorph.
	incompleteMorphs add: aMorph.
]

{ #category : 'formatting commands' }
HtmlFormatter >> addLink: text  url: url [
	"add a link with the given url and text"
	| savedAttributes linkAttribute  |

	"set up the link attribute"
	linkAttribute := TextURL new.
	linkAttribute url: url.

	"add the link to the stream"
	savedAttributes := outputStream currentAttributes.
	outputStream currentAttributes: (savedAttributes, linkAttribute).
	outputStream nextPutAll: text.
	outputStream currentAttributes: savedAttributes.

	"reset counters"
	precedingSpaces := precedingNewlines := 0.
]

{ #category : 'formatting commands' }
HtmlFormatter >> addMorph: aMorph [
	"add a morph to the output"
	| savedAttributes |
	self addChar: Character space.

	savedAttributes := outputStream currentAttributes.
	outputStream currentAttributes: (savedAttributes copyWith: (TextAnchor new anchoredMorph: aMorph)).
	self addChar: (Character value: 1).
	outputStream currentAttributes: savedAttributes.

	self addChar: Character space.

	morphsToEmbed add: aMorph.
]

{ #category : 'formatting commands' }
HtmlFormatter >> addString: aString [
	"adds the text in the given string.  It collapses spaces unless we are in a preformatted region"

	| space compacted lastC i |
	aString isEmpty
		ifTrue: [ ^ self ].
	space := Character space.
	preformattedLevel > 0
		ifTrue:
			[ "add all the characters as literals"
			outputStream nextPutAll: aString.	"update the counters"
			lastC := aString last.
			(lastC = space or: [ lastC = Character cr ])
				ifTrue:
					[ "how many of these are there?"
					i := aString size - 1.
					[ i >= 1 and: [ (aString at: i) = lastC ] ] whileTrue: [ i := i - 1 ].
					i = 0
						ifTrue:
							[ "the whole string is the same character!"
							lastC = space
								ifTrue:
									[ precedingSpaces := precedingSpaces + aString size.
									precedingNewlines := 0.
									^ self ]
								ifFalse:
									[ precedingSpaces := 0.
									precedingNewlines := precedingNewlines + aString size.
									^ self ] ].
					lastC = space
						ifTrue:
							[ precedingSpaces := aString size - i.
							precedingNewlines := 0 ]
						ifFalse:
							[ precedingSpaces := 0.
							precedingNewlines := aString size - i ] ] ]
		ifFalse:
			[ compacted := aString withSeparatorsCompacted.
			compacted = ' '
				ifTrue:
					[ "no letters in the string--just white space!"
					(precedingNewlines = 0 and: [ precedingSpaces = 0 ])
						ifTrue:
							[ precedingSpaces := 1.
							outputStream nextPut: space ].
					^ self ].
			(compacted first = Character space and: [ precedingSpaces > 0 or: [ precedingNewlines > 0 ] ])
				ifTrue: [ compacted := compacted copyFrom: 2 to: compacted size ].
			outputStream nextPutAll: compacted.	"update counters"
			precedingNewlines := 0.
			precedingSpaces := compacted last = space
				ifTrue: [ 1 ]
				ifFalse: [ 0 ] ]
]

{ #category : 'access' }
HtmlFormatter >> anchorLocations [
	"return a dictionary mapping lowercase-ed anchor names into the integer positions they are located at in the text"
	^anchorLocations
]

{ #category : 'access' }
HtmlFormatter >> baseUrl [
	"return the base URL for the document we are formatting, if known"
	^baseUrl
]

{ #category : 'access' }
HtmlFormatter >> baseUrl: url [
	"set the base url.  All relative URLs will be determined relative to it"
	baseUrl := url.
]

{ #category : 'access' }
HtmlFormatter >> browser [
	"return the browser we are formatting for, or nil if none"
	^browser
]

{ #category : 'access' }
HtmlFormatter >> browser: b [
	"set what browser we are formatting for"
	browser := b.
]

{ #category : 'forms' }
HtmlFormatter >> currentFormData [
	"return the current form data, or nil if we aren't inside a form"
	formDatas size > 0 
		ifTrue: [ ^formDatas last ]
		ifFalse: [ ^nil ].
]

{ #category : 'formatting commands' }
HtmlFormatter >> decreaseBold [
	boldLevel := boldLevel - 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> decreaseIndent [
	indentLevel := indentLevel - 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> decreaseItalics [
	italicsLevel := italicsLevel - 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> decreasePreformatted [
	preformattedLevel := preformattedLevel - 1
]

{ #category : 'formatting commands' }
HtmlFormatter >> decreaseStrike [
	strikeLevel := strikeLevel - 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> decreaseUnderline [
	underlineLevel := underlineLevel - 1.
	self setAttributes.
]

{ #category : 'forms' }
HtmlFormatter >> endForm [
	formDatas size > 0 ifTrue: [ 
		formDatas removeLast. ]
	ifFalse: [ self halt: 'HtmlFormatter: ended more forms that started!?' ].
	self ensureNewlines: 1.
]

{ #category : 'formatting commands' }
HtmlFormatter >> endHeader: level [
	self decreaseBold.
	self ensureNewlines: 2
]

{ #category : 'formatting commands' }
HtmlFormatter >> endLink: url [
	urlLink := nil.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> endListItem [
	"end a list item"
	self ensureNewlines: 1.
]

{ #category : 'formatting commands' }
HtmlFormatter >> endOrderedList [
	"end an ordered list"
	listLengths removeLast.
	listStyleTypes removeLast.
	listTypes removeLast.
	indentLevel := indentLevel - 1.
	self setAttributes. 

	self ensureNewlines: 1.
	
]

{ #category : 'formatting commands' }
HtmlFormatter >> endUnorderedList [
	"end an unordered list"
	listLengths removeLast.
	listStyleTypes removeLast.
	listTypes removeLast.
	indentLevel := indentLevel - 1.
	self setAttributes. 
	
	self ensureNewlines: 1.
]

{ #category : 'formatting commands' }
HtmlFormatter >> ensureNewlines: number [
	"make sure there are at least number preceding newlines"
	number > precedingNewlines ifTrue: [
		(number - precedingNewlines) timesRepeat: [ self addChar: Character cr ] ].
]

{ #category : 'formatting commands' }
HtmlFormatter >> ensureSpaces: number [
	"make sure there are at least number preceding spaces, unless we're at the beginning of a new line"

	precedingNewlines > 0 ifTrue: [ ^ self ].

	number > precedingSpaces ifTrue: [
		(number - precedingSpaces) timesRepeat: [ self addChar: Character space ] ].
]

{ #category : 'formatting commands' }
HtmlFormatter >> hr [
	"add an (attempt at a) horizontal rule"
	self ensureNewlines: 1.
	25 timesRepeat: [ self addChar: $- ].
	self ensureNewlines: 1.
	precedingSpaces := 0.
	precedingNewlines := 1000.    "pretend it's the top of a new page"
]

{ #category : 'formatting' }
HtmlFormatter >> htmlInlineMorph [
	| text htmlInlineMorph |
	text := outputStream contents.
	htmlInlineMorph := HtmlInlineMorph new contents: text.
	morphsToEmbed do:[ :m | htmlInlineMorph addMorph: m ].
	htmlInlineMorph incompleteMorphs: self incompleteMorphs.
	^htmlInlineMorph
]

{ #category : 'image maps' }
HtmlFormatter >> imageMapNamed: imageMapName [
	^imageMaps detect: [:im | im name asLowercase = imageMapName asLowercase] ifNone: []
]

{ #category : 'access' }
HtmlFormatter >> incompleteMorphs [
	"list of morphs needing to download some more state"
	^incompleteMorphs
]

{ #category : 'formatting commands' }
HtmlFormatter >> increaseBold [
	boldLevel := boldLevel + 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> increaseIndent [
	indentLevel := indentLevel + 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> increaseItalics [
	italicsLevel := italicsLevel + 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> increasePreformatted [
	preformattedLevel := preformattedLevel + 1
]

{ #category : 'formatting commands' }
HtmlFormatter >> increaseStrike [
	strikeLevel := strikeLevel + 1.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> increaseUnderline [
	underlineLevel := underlineLevel + 1.
	self setAttributes.
]

{ #category : 'private-initialization' }
HtmlFormatter >> initialize [
	outputStream := AttributedTextStream new.
	preformattedLevel := 0.
	indentLevel := boldLevel := italicsLevel := underlineLevel := strikeLevel := centerLevel := 0.
	listLengths := OrderedCollection new.
	listStyleTypes := OrderedCollection new.
	listTypes := OrderedCollection new.
	precedingSpaces := 0.
	precedingNewlines := 1000.   "more than will ever be asked for"
	morphsToEmbed := OrderedCollection new.
	incompleteMorphs := OrderedCollection new.
	anchorLocations := Dictionary new.
	imageMaps := OrderedCollection new.
]

{ #category : 'formatting commands' }
HtmlFormatter >> noteAnchorStart: anchorName [
	"note that an anchor starts at this point in the output"
	anchorLocations at: anchorName asLowercase put: outputStream size
]

{ #category : 'private-formatting' }
HtmlFormatter >> setAttributes [
	"set attributes on the output stream"
	| attribs |
	attribs := OrderedCollection new.
	indentLevel > 0 ifTrue: [ attribs add: (TextIndent tabs: indentLevel) ].
	boldLevel > 0 ifTrue: [ attribs add: TextEmphasis bold ].
	italicsLevel >  0 ifTrue: [ attribs add: TextEmphasis italic ].
	underlineLevel > 0 ifTrue: [ attribs add: TextEmphasis underlined ].
	strikeLevel > 0 ifTrue: [ attribs add: TextEmphasis struckOut ].
	urlLink isNil ifFalse: [ attribs add: (TextURL new url: urlLink) ].
	outputStream currentAttributes: attribs
]

{ #category : 'forms' }
HtmlFormatter >> startForm: form [
	"a form is beginning"
	self ensureNewlines: 1.
	formDatas addLast: (FormInputSet forForm: form  andBrowser: browser).
]

{ #category : 'formatting commands' }
HtmlFormatter >> startHeader: level [
	self ensureNewlines: 3.
	self increaseBold
]

{ #category : 'formatting commands' }
HtmlFormatter >> startLink: url [
	urlLink := url.
	self setAttributes.
]

{ #category : 'formatting commands' }
HtmlFormatter >> startListItem [
	"begin a new list item"
	(listTypes isEmpty or: [listStyleTypes isEmpty]) ifTrue: [ ^self ].
	self ensureNewlines: 1.
	listStyleTypes last = 'none' ifTrue: [ ^self ].
	listTypes last = #unordered
		ifTrue: [| bulletPoint|
				bulletPoint := RectangleMorph new.
				bulletPoint
					extent: 8@8;
					color: Color black;
					borderColor: Color transparent;
					borderWidth: 2.
				self addMorph: bulletPoint.]
		ifFalse: [ self addString: (listLengths last + 1) printString.
			self addString: '. ' ].
	listLengths at: (listLengths size) put: (listLengths last + 1).
]

{ #category : 'formatting commands' }
HtmlFormatter >> startListItemWithValue: aValue [
	listLengths at: (listLengths size) put: (aValue - 1).
	self startListItem.
]

{ #category : 'formatting commands' }
HtmlFormatter >> startOrderedList [
	"begin an ordered list"
	listLengths add: 0.
	listTypes add: #ordered.
	indentLevel := indentLevel + 1.
	self setAttributes.
	
]

{ #category : 'formatting commands' }
HtmlFormatter >> startOrderedListWithStart: aStartValue type: aListStyleType [
	"begin an ordered list"
	listLengths add: (aStartValue - 1).
	listStyleTypes add: aListStyleType.
	listTypes add: #ordered.
	indentLevel := indentLevel + 1.
	self setAttributes.
	
]

{ #category : 'formatting commands' }
HtmlFormatter >> startUnorderedList [
	"begin an unordered list"
	listLengths add: 0.
	listTypes add: #unordered.
	indentLevel := indentLevel + 1.
	self setAttributes.
	
]

{ #category : 'formatting commands' }
HtmlFormatter >> startUnorderedListWithType: aListStyleType [
	"begin an unordered list"
	listLengths add: 0.
	listStyleTypes add: aListStyleType.
	listTypes add: #unordered.
	indentLevel := indentLevel + 1.
	self setAttributes.
	
]

{ #category : 'formatting' }
HtmlFormatter >> text [
	| text |
	text := outputStream contents.
	^text
]

{ #category : 'formatting' }
HtmlFormatter >> textMorph [
	| text textMorph |
	text := outputStream contents.
	textMorph := TextMorph new contents: text.
	morphsToEmbed do:[ :m | textMorph addMorph: m ].
	^textMorph
]
