Class {
	#name : #HtmlTHEADNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlTHEADNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'font-weight' -> 'bold'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #rendering }
HtmlTHEADNode >> addToHtmlMorph: aHtmlTableMorph [
	self children do: [ :ea |
		ea addToHtmlMorph: aHtmlTableMorph.
	]
]

{ #category : #accessing }
HtmlTHEADNode >> tag [
	^ 'thead'
]
