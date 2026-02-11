Class {
	#name : 'CSSFontFormatter',
	#superclass : 'CSSFormatter',
	#instVars : [
		'fontMap'
	],
	#classInstVars : [
		'fontSizeFactorMap'
	],
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'font parameters' }
CSSFontFormatter class >> defaultSize [

	^ TextStyle pointsToPixels:
		  ((TextStyle named: 'Verdana') ifNil: [ TextStyle default ])
			  defaultFont pointSize
]

{ #category : 'font parameters' }
CSSFontFormatter class >> defaultStyle [

	^ (TextStyle named: 'Verdana') ifNil: [ TextStyle default ]
]

{ #category : 'font parameters' }
CSSFontFormatter class >> fontSizeFactorMap [
"I provide values to scale fonts to a correct display size."
	^ fontSizeFactorMap ifNil:
		[ Dictionary newFrom: {
			'NimbusRomanNo9L' -> 1.25.
			'NimbusSansL' -> 1.25.
			'ComicSansMS' -> 1.3.
			'URWChanceryL' -> 1.3.
			'NimbusMonoL' -> 1.25.
			'TrebuchetMS' -> 1.2.
			'AndaleMono' -> 1.2.
			'Georgia' -> 1.15.
			'Verdana' -> 1.25.
			'Webdings' -> 1.07.
		}]
]

{ #category : 'font installation' }
CSSFontFormatter class >> pointSizes [
	^ #(6 8 9 10 12 14 16 18 20 22 24 26 30 36 48)
]

{ #category : 'font parameters' }
CSSFontFormatter class >> sizeFactorFor: aTextStyle [
	self fontSizeFactorMap associationsDo:
			[:association | aTextStyle = (TextStyle named: association key)
								ifTrue: [^association value]].
	^1
]

{ #category : 'accessing' }
CSSFontFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			'font' 			-> 	[ :aProperty :aContext | self readFontAttribute: aProperty propertyString to: aContext ].
			'font-style' 		-> 	[ :aProperty :aContext | self readFontStyleAttribute: aProperty propertyString to: aContext ].
			'font-weight' 	-> 	[ :aProperty :aContext | self readFontWeightAttribute: aProperty propertyString to: aContext ].
			'font-size' 		-> 	[ :aProperty :aContext | self readFontSizeAttribute: aProperty propertyString to: aContext ].
			'font-family' 	-> 	[ :aProperty :aContext | self readFontFamilyAttribute: aProperty propertyString to: aContext ]
		}]
]

{ #category : 'parsing' }
CSSFontFormatter >> factorForNamedSize: aString [
	^(Dictionary newFrom: {
		'initial' -> 1.
		'xx-small' -> 0.5.
		'x-small' -> 0.6.
		'small' -> 0.8.
		'medium' -> 1.
		'large' -> 1.5.
		'x-large' -> 2.
		'xx-large' -> 3.
	}) at: aString ifAbsent: [1]
]

{ #category : 'accessing' }
CSSFontFormatter >> fontMap [
"I replace some fonts with licence issues by free alternatives and set a mapping for generic font families such as serif or monospace."
	^ fontMap ifNil: [ Dictionary newFrom: {
			'serif' -> 'NimbusRomanNo9L'.
			'Times' -> 'NimbusRomanNo9L'.
			'Times New Roman' -> 'NimbusRomanNo9L'.
			'Nimbus Roman No9 L' -> 'NimbusRomanNo9L'.
			'sans-serif' -> 'NimbusSansL'.
			'Arial' -> 'NimbusSansL'.
			'Helvetica' -> 'NimbusSansL'.
			'Nimbus Sans L' -> 'NimbusSansL'.
			'fantasy' -> 'ComicSansMS'.
			'Comic Sans MS' -> 'ComicSansMS'.
			'cursive' -> 'URWChanceryL'.
			'URW Chancery L' -> 'URWChanceryL'.
			'monospace' -> 'NimbusMonoL'.
			'Courier New' -> 'NimbusMonoL'.
			'Nimbus Mono L' -> 'NimbusMonoL'.
			'Trebuchet MS' -> 'TrebuchetMS'.
			'Andale Mono' -> 'AndaleMono'.
		}]
]

{ #category : 'parsing' }
CSSFontFormatter >> isValidStyleValue: aString [

	^ {'normal'. 'italic'. 'oblique'. 'initial'. 'inherit'} includes: aString
]

{ #category : 'parsing' }
CSSFontFormatter >> isValidWeightValue: aString [

	^ {'normal'. 'bold'. 'bolder'. 'lighter'. '100'. '200'. '300'. '400'. '500'. '600'. '700'. '800'. '900'. 'initial'. 'inherit'} includes: aString
]

{ #category : 'parsing' }
CSSFontFormatter >> readFontAttribute: aString to: aContext [
	| values shorthandContext |
	shorthandContext := Dictionary newFrom: {
		#italic -> false.
		#bold -> false.
		#fontSize -> self class defaultSize.
		#fontFamily -> self class defaultStyle.
	}.
	
	values := aString splitOn: ' '.
	values size >= 2 ifTrue: [
		self readFontSizeAttribute: (values nextToLast splitOn: '/') first to: shorthandContext].
	values size >= 3 ifTrue: [
		(self isValidStyleValue: values first) 
			ifTrue: [	self readFontStyleAttribute: values first to: shorthandContext.
					values size >= 4
						ifTrue: [self readFontWeightAttribute: values second to: shorthandContext ]]
			ifFalse: [ 
				(self isValidWeightValue: values first)
					ifTrue: [self readFontWeightAttribute: values first to: shorthandContext ]]].
	values last ifNotNil: [:val | self readFontFamilyAttribute: val to: shorthandContext].
	aContext addAll: shorthandContext
]

{ #category : 'parsing' }
CSSFontFormatter >> readFontFamilyAttribute: aString to: aContext [
	| style |
	style := self class defaultStyle.
	(aString substrings: ',') reversed
		do: [:family | (self styleForFamily: family) ifNotNil: [:s | style := s]].
	aContext at: #fontFamily put: style.
]

{ #category : 'parsing' }
CSSFontFormatter >> readFontSizeAttribute: aString to: aContext [
	| defaultSize parentFontSize|
	defaultSize := self class defaultSize.
	parentFontSize := (self parentResolver value: #fontSize) ifNil: [ defaultSize ].
	
	self isRelativeSize: aString
		ifTrue: [aContext at: #fontSize put: 
					(self relativeSizeToPx: aString parentAndDefaultSize: parentFontSize).
				^self].	
	
	self isAbsoluteSize: aString
		ifTrue: [aContext at: #fontSize put: 
					(self absoluteSizeToPx: aString defaultSize: defaultSize).
				^self].
	
	aContext at: #fontSize put: ((self factorForNamedSize: aString) * defaultSize) asInteger
]

{ #category : 'parsing' }
CSSFontFormatter >> readFontStyleAttribute: aString to: aContext [
	| map |
	map := Dictionary newFrom: {
		'italic' -> true.
		'oblique' -> true.
		'normal' -> false
	}.
	
	(map at: aString ifAbsent: [nil]) ifNotNil: [:value | aContext at: #italic put: value]
]

{ #category : 'parsing' }
CSSFontFormatter >> readFontWeightAttribute: aString to: aContext [
	| map |
	map := Dictionary newFrom: {
		'bold' -> true.
		'normal' -> false
	}.
	
	(map at: aString ifAbsent: [nil]) ifNotNil: [:value | aContext at: #bold put: value]
]

{ #category : 'parsing' }
CSSFontFormatter >> styleForFamily: aString [
	| family |
	family := aString trimBoth: [:char | (char isSeparator or: [char = $"]) or: [char = $']].
	(TextStyle named: family) ifNotNil: [:style | ^style].
	self fontMap at: family ifPresent: [:replacement | ^TextStyle named: replacement].
	^nil
]
