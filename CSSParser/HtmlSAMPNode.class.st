Class {
	#name : 'HtmlSAMPNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlSAMPNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'font-family' -> 'Georgia'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlSAMPNode >> tag [
	^ 'samp'
]
