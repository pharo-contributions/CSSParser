Class {
	#name : 'HtmlANode',
	#superclass : 'HtmlDOMNode',
	#instVars : [
		'href'
	],
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlANode >> href [
	^ href ifNil: [ href := self attributes at: 'href' ifAbsent: [nil] ]
]

{ #category : 'accessing' }
HtmlANode >> tag [
	^ 'a'
]

{ #category : 'accessing' }
HtmlANode >> target [
	^ self attributes at: 'target' ifAbsent: [nil]
]
