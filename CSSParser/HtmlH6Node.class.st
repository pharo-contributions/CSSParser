Class {
	#name : #HtmlH6Node,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlH6Node >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'font-size' -> '0.67em'.
		'font-weight' -> 'bold'.
		'margin' -> '2.33em 0'
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #accessing }
HtmlH6Node >> tag [
	^ 'h6'
]
