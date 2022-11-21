Class {
	#name : #HtmlANode,
	#superclass : #HtmlDOMNode,
	#instVars : [
		'href'
	],
	#category : #'CSSParser-DOM'
}

{ #category : #rendering }
HtmlANode >> addToFormatter: aFormatter [
	"Currently not supported:"
	"name := self attributes at: 'name' ifAbsent: [nil].
	name ifNotNil: [
			aFormatter noteAnchorStart: name ]."
	super addToFormatter: aFormatter
]

{ #category : #'initialize-release' }
HtmlANode >> defaultBlockMorph [
	^ HtmlLinkMorph
]

{ #category : #rendering }
HtmlANode >> endStyles: aFormatter [

	href ifNotNil: [:value | aFormatter endLink: value ]
]

{ #category : #accessing }
HtmlANode >> href [
	^ href ifNil: [ href := self attributes at: 'href' ifAbsent: [nil] ]
]

{ #category : #accessing }
HtmlANode >> startStyles: aFormatter [

	href := self attributes at: 'href' ifAbsent: [nil].	
	href ifNotNil: [:value | aFormatter startLink: value ]
]

{ #category : #accessing }
HtmlANode >> tag [
	^ 'a'
]

{ #category : #accessing }
HtmlANode >> target [
	^ self attributes at: 'target' ifAbsent: [nil]
]
