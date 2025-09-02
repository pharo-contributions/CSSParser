Class {
	#name : 'HtmlH2Node',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlH2Node >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'font-size' -> '1.5em'.
		'font-weight' -> 'bold'.
		'margin' -> '.83em 0'
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlH2Node >> tag [
	^ 'h2'
]
