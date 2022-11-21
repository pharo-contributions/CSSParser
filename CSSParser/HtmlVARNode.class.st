Class {
	#name : #HtmlVARNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #accessing }
HtmlVARNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'font-style' -> 'italic'.
		'font-family' -> 'Courier New'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #accessing }
HtmlVARNode >> tag [
	^ 'var'
]
