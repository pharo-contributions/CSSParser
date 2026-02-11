Class {
	#name : 'HtmlTDNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlTDNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'table-cell'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlTDNode >> tag [
	^ 'td'
]
