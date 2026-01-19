Class {
	#name : 'HtmlINPUTNode',
	#superclass : 'HtmlDOMNode',
	#instVars : [
		'value'
	],
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlINPUTNode >> alt [
	(self type = 'image')
		ifTrue: [^self attributes at: 'alt' ifAbsent: ['[image]']]
		ifFalse: [^self attributes at: 'alt' ifAbsent: ['']]
]

{ #category : 'accessing' }
HtmlINPUTNode >> defaultValue [
	^(self attributes at: 'value' ifAbsent: ['']) asUnHtml
]

{ #category : 'accessing' }
HtmlINPUTNode >> imageExtent [
	"the image extent, according to the WIDTH and HEIGHT attributes.  returns nil if either WIDTH or HEIGHT is not specified"
	| widthText heightText |
	widthText := self attributes at: 'width' ifAbsent: [ ^nil ].
	heightText := self attributes at: 'height' ifAbsent: [ ^nil ].
	^ widthText asNumber @ heightText asNumber
]

{ #category : 'testing' }
HtmlINPUTNode >> name [
	^self attributes at: 'name' ifAbsent: [nil]
]

{ #category : 'accessing' }
HtmlINPUTNode >> tag [
	^ 'input'
]

{ #category : 'accessing' }
HtmlINPUTNode >> type [
	^(self attributes at:'type' ifAbsent: ['text']) asLowercase
]
