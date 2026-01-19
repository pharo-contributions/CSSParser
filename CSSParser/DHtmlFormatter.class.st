"
an attempt to improve HtmlFormatter...
make it a bit more DOMish (eventually)

roadmap
-1-	support for font specs (color, size)
-2-	support for tabless
"
Class {
	#name : 'DHtmlFormatter',
	#superclass : 'HtmlFormatter',
	#instVars : [
		'fontSpecs'
	],
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'formatting commands' }
DHtmlFormatter >> decreaseFontBy: relSize [
	self startFont: (TextFontChange fontNumber: ((self lastFontSize - relSize) min: 4))
]

{ #category : 'formatting commands' }
DHtmlFormatter >> endFont: aFont [
	fontSpecs isEmptyOrNil
		ifFalse: [fontSpecs removeLast].
	self setAttributes
]

{ #category : 'formatting commands' }
DHtmlFormatter >> endHeader: level [
	boldLevel := boldLevel - 1. "self decreaseBold"
	self ensureNewlines: 2.
	self endFont: nil.
]

{ #category : 'formatting commands' }
DHtmlFormatter >> endStyles [
	self endFont: nil
]

{ #category : 'private-formatting' }
DHtmlFormatter >> fontWith: aTextStyle and: aFontSize [
	| size font |
	size := (CSSFontFormatter sizeFactorFor: aTextStyle)
				 * (TextStyle pixelsToPoints: aFontSize) ceiling.
	font := aTextStyle fonts detect: [:f | f pointSize = size]
							   ifNone: [ aTextStyle addNewFontSize: size].
	^font
]

{ #category : 'formatting commands' }
DHtmlFormatter >> headerFont: level [
	^{TextFontChange fontNumber: ((5 - level) max: 1)}
]

{ #category : 'formatting commands' }
DHtmlFormatter >> increaseFontBy: relSize [
	self startFont: (TextFontChange fontNumber: ((self lastFontSize + relSize) min: 4))
]

{ #category : 'formatting commands' }
DHtmlFormatter >> lastFontSize [
	| textAttrib |
	fontSpecs isEmptyOrNil ifTrue: [^1].

	fontSpecs reverseDo: [:specs |
		textAttrib := specs detect: [:attrib | attrib isKindOf: TextFontChange] ifNone: [].
		textAttrib ifNotNil: [^textAttrib fontNumber]].

	^1 "default font size in Squeak (1) corresponds to HTML's default 4"
]

{ #category : 'formatting commands' }
DHtmlFormatter >> parseTextAttributesFor: aDomNode [
	
	| attributes resolver |
	attributes := OrderedCollection new.
	resolver := CSSStyleResolver for: aDomNode.
	
	self parseTextStyleAttributesFor: resolver in: attributes.
	
	resolver
		ifStyleNotNil: #italic do: [:italic | italic ifTrue: [ attributes add: TextEmphasis italic ]];
		ifStyleNotNil: #bold do: [:bold | bold ifTrue: [ attributes add: TextEmphasis bold ]];
		ifStyleNotNil: #color do: [:color | attributes add: (TextColor color: color)];
		ifStyleNotNil: #underlined do:
				[:underlined | underlined ifTrue: [ attributes add: TextEmphasis underlined ]];
		ifStyleNotNil: #struckOut do:
				[:struckOut | struckOut ifTrue: [ attributes add: TextEmphasis struckOut ]];
		ifStyleNotNil: #textAlign do: [:align | attributes add: (TextAlignment perform: align)].
	^ attributes
]

{ #category : 'formatting commands' }
DHtmlFormatter >> parseTextStyleAttributesFor: aStyleResolver in: anOrderedCollection [
	
	| family size |
	size := aStyleResolver ifStyleNotNil: #fontSize do: [:s | s]
				ifNil: [CSSFontFormatter defaultSize].
	family := aStyleResolver ifStyleNotNil: #fontFamily do: [:f | f]
				ifNil: [CSSFontFormatter defaultStyle].

	((aStyleResolver getStyle: #fontFamily) notNil or: [(aStyleResolver getStyle: #fontSize) notNil])
			ifTrue: [anOrderedCollection add:
					(TextFontReference toFont: (self fontWith: family and: size))].
]

{ #category : 'formatting commands' }
DHtmlFormatter >> resetFont [
	"probably need use document defaults"
	self startFont:
		{TextColor black.
		TextFontChange fontNumber: 1}
]

{ #category : 'private-formatting' }
DHtmlFormatter >> setAttributes [
	"set attributes on the output stream"
	| attribs |
	attribs := OrderedCollection new.
	indentLevel > 0 ifTrue: [ attribs add: (TextIndent tabs: indentLevel) ].
	boldLevel > 0 ifTrue: [ attribs add: TextEmphasis bold ].
	italicsLevel >  0 ifTrue: [ attribs add: TextEmphasis italic ].
	underlineLevel > 0 ifTrue: [ attribs add: TextEmphasis underlined ].
	strikeLevel > 0 ifTrue: [ attribs add: TextEmphasis struckOut ].
	urlLink isNil ifFalse: [ attribs add: (TextURL new url: urlLink) ].
	fontSpecs isEmptyOrNil
		ifFalse: [attribs addAll: fontSpecs last]
		ifTrue: [attribs add: (TextFontChange defaultFontChange)].
	outputStream currentAttributes: attribs
]

{ #category : 'formatting commands' }
DHtmlFormatter >> startFont: aTextAttribList [
	"aTextAttribList is a collection of TextAttributes"
	fontSpecs ifNil: [fontSpecs := OrderedCollection new].
	fontSpecs add:
		(aTextAttribList isArray 
			ifTrue: [ OrderedCollection newFrom: aTextAttribList ] 
			ifFalse: [ aTextAttribList ]).
	self setAttributes
]

{ #category : 'formatting commands' }
DHtmlFormatter >> startHeader: level [
	self ensureNewlines: 3.
	boldLevel := boldLevel + 1. "self increaseBold"
	self startFont: (self headerFont: level).
]
