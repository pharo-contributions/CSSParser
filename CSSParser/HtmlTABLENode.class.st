Class {
	#name : 'HtmlTABLENode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlTABLENode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'display' -> 'table'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlTABLENode >> tag [
	^ 'table'
]
