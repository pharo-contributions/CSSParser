Class {
	#name : #HtmlTABLENode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlTABLENode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'table'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #rendering }
HtmlTABLENode >> addToHtmlMorph: aHtmlBlockMorph [	
	super addToHtmlMorph: aHtmlBlockMorph.
	((self attributes at: #border ifAbsent: ['0']) = '0') ifFalse: [htmlMorph addTableLines].
]

{ #category : #'initialize-release' }
HtmlTABLENode >> defaultBlockMorph [
	^ HtmlTableMorph
]

{ #category : #rendering }
HtmlTABLENode >> endStyles: aFormatter [
	aFormatter ensureNewlines: 1
]

{ #category : #accessing }
HtmlTABLENode >> startStyles: aFormatter [
	aFormatter ensureNewlines: 1
]

{ #category : #accessing }
HtmlTABLENode >> tag [
	^ 'table'
]
