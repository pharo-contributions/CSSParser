Class {
	#name : #HtmlTFOOTNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlTFOOTNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'font-style' -> 'italic'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #rendering }
HtmlTFOOTNode >> addToHtmlMorph: aHtmlTableMorph [
	self children do: [ :ea |
		ea addToHtmlMorph: aHtmlTableMorph.
	]
]

{ #category : #accessing }
HtmlTFOOTNode >> tag [
	^ 'tfoot'
]
