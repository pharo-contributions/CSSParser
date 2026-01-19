Class {
	#name : 'HtmlTRNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlTRNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'table-row'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlTRNode >> tag [
	^ 'tr'
]
