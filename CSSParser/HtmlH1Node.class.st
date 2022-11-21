Class {
	#name : #HtmlH1Node,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlH1Node >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'font-size' -> '2em'.
		'font-weight' -> 'bold'.
		'margin' -> '.67em 0'
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #accessing }
HtmlH1Node >> tag [
	^ 'h1'
]
