Class {
	#name : 'HtmlTHNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlTHNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'table-cell'.
		'font-weight' -> 'bold'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlTHNode >> tag [
	^ 'th'
]
