Class {
	#name : #HtmlDFNNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #accessing }
HtmlDFNNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'font-style' -> 'italic'.
		'font-family' -> 'Times'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #accessing }
HtmlDFNNode >> tag [
	^ 'dfn'
]
