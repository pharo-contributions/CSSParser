Class {
	#name : #HtmlEMNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #accessing }
HtmlEMNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'font-style' -> 'italic'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #accessing }
HtmlEMNode >> tag [
	^ 'em'
]
