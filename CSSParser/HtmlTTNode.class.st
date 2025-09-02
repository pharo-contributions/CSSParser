Class {
	#name : 'HtmlTTNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlTTNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'font-family' -> 'TrebuchetMS'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlTTNode >> tag [
	^ 'tt'
]
