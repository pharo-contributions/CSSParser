Class {
	#name : #HtmlTDNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlTDNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'table-cell'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #accessing }
HtmlTDNode >> endStyles: aFormatter [
	aFormatter ensureSpaces: 1
]

{ #category : #accessing }
HtmlTDNode >> tag [
	^ 'td'
]
