Class {
	#name : #HtmlTBODYNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlTBODYNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #rendering }
HtmlTBODYNode >> addToHtmlMorph: aHtmlTableMorph [
	self children do: [ :ea |
		ea addToHtmlMorph: aHtmlTableMorph.
	]
]

{ #category : #accessing }
HtmlTBODYNode >> tag [
	^ 'tbody'
]
