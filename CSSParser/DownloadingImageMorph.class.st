"
a placeholder for an image that is downloading
"
Class {
	#name : #DownloadingImageMorph,
	#superclass : #Morph,
	#instVars : [
		'url',
		'altText',
		'defaultExtent',
		'image',
		'downloadQueue',
		'formatter'
	],
	#category : #'CSSParser-Formatter'
}

{ #category : #accessing }
DownloadingImageMorph >> altText: aString [
	"set the text to be displayed while downloading"
	altText := aString.
	aString ifNotNil: [self setBalloonText: aString].
	self setContents
]

{ #category : #accessing }
DownloadingImageMorph >> defaultExtent: aPoint [
	"set the size to use when the image hasn't yet downloaded"
	defaultExtent := aPoint
]

{ #category : #rendering }
DownloadingImageMorph >> downloadStateIn: aScamper [
	"download the image"
	| doc |
	doc := url retrieveContents.
	downloadQueue nextPut: doc.


]

{ #category : #downloading }
DownloadingImageMorph >> forkDownloadWhenFinished: aBlock [ 
	| doc |
	image ifNotNil: [^self].
	self setContents.
	[
		[
			doc := url retrieveContents.
			(doc notNil and: [doc mainType = 'image'])
				ifTrue: [image := ImageReadWriter formFromStream: doc contentStream binary].
		] ifError: [].
		WorldState addDeferredUIMessage:
			[image ifNotNil: [self setContents].
			self stopStepping.
			aBlock value]
	] forkAt: Processor userBackgroundPriority
]

{ #category : #accessing }
DownloadingImageMorph >> formatter [
	^formatter
]

{ #category : #accessing }
DownloadingImageMorph >> formatter: aFormatter [
	formatter := aFormatter
]

{ #category : #accessing }
DownloadingImageMorph >> imageMapName [
	^imageMapName
]

{ #category : #accessing }
DownloadingImageMorph >> imageMapName: aString [
	imageMapName := aString
]

{ #category : #initialization }
DownloadingImageMorph >> initialize [
	super initialize.

	altText := '[image]'.
	self color: Color transparent.
	downloadQueue := SharedQueue new.
]

{ #category : #rendering }
DownloadingImageMorph >> setContents [
	"set up our morphic contents"
	| imageMorph |
	self removeAllMorphs.

	image ifNil: [^self setNoImageContents].

	defaultExtent isNil
		ifTrue: [(imageMorph := ImageMorph new) image: image]
		ifFalse: [imageMorph := SketchMorph withForm: image].

	imageMorph position: self position.
	self addMorph: imageMorph.
	defaultExtent isNil
		ifFalse: [imageMorph extent: defaultExtent].
	self extent ~= imageMorph extent
		ifTrue: [	self extent: imageMorph extent ].
	"TODO: trigger scrollbar reevaluation of WebPageMorph"
	self owner composeToBounds
]

{ #category : #rendering }
DownloadingImageMorph >> setNoImageContents [
	"set up our morphic contents in case image download/decoding failed"
	| stringMorph outlineMorph extent |
	altText isEmptyOrNil
		ifTrue: [ self extent: 0@0. "don't display anything..." ^self ].

	stringMorph := StringMorph new.
	stringMorph contents: altText.
	stringMorph position: self position+(2@2).
	self addMorph: stringMorph.

	outlineMorph := RectangleMorph new.
	outlineMorph borderWidth: 1.
	outlineMorph color: Color transparent.
	outlineMorph position: self position.

	"figure out how big to make the box"
	extent := defaultExtent ifNil: [ 0 @ 0 ].
	stringMorph width + 4 > extent x ifTrue: [
		extent := (stringMorph width + 4) @ extent y ].
	stringMorph height + 4 > extent y ifTrue: [
		extent := extent x @ (stringMorph height + 4) ].
	outlineMorph extent: extent.
	self addMorph: outlineMorph.

	self extent: outlineMorph extent

]

{ #category : #rendering }
DownloadingImageMorph >> setSvgContents [
	"set up our svg contents"
	| svgMorph |
	self removeAllMorphs.

	image ifNil: [^self setNoImageContents].

	svgMorph := image.

	svgMorph position: self position.
	self addMorph: svgMorph.
	defaultExtent isNil
		ifFalse: [svgMorph extent: defaultExtent].
	self extent ~= svgMorph extent
		ifTrue: [	self extent: svgMorph extent ].
	"TODO: trigger scrollbar reevaluation of WebPageMorph"
	self owner composeToBounds
]

{ #category : #'stepping and presenter' }
DownloadingImageMorph >> step [
	| doc|
	downloadQueue size > 0 ifTrue: [
		doc := downloadQueue next.
		
		"By now MIMEDocument sees svg as application with octet-stream"
		((doc notNil and: [doc mainType = 'image']) and: [doc subType = 'svg'])
		ifTrue: [
			[image := SVGMorph fromFileStream: doc contentStream]
				ifError: [:err :rcvr | self altText: 'You need SVGMorphic to display svg content!'. image := nil].
			self setSvgContents.
		].

		(doc notNil and: [doc mainType = 'image'])
		ifTrue: [
			[image := ImageReadWriter formFromStream: doc contentStream binary]
				ifError: [:err :rcvr | "ignore" image := nil].
			self setContents.
			]. 
		].
]

{ #category : #testing }
DownloadingImageMorph >> stepTime [
	"this check doesn't need to be frequent"
	^500
]

{ #category : #accessing }
DownloadingImageMorph >> url: aUrl [
	"set the url to download"
	url := aUrl asUrl.
]
