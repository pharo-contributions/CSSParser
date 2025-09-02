Class {
	#name : 'HtmlH4Node',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlH4Node >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'font-size' -> '1.00em'.
		'font-weight' -> 'bold'.
		'margin' -> '1.33em 0'
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlH4Node >> tag [
	^ 'h4'
]
