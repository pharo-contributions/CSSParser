Class {
	#name : 'HtmlBIGNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlBIGNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'font-size' -> 'larger'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlBIGNode >> tag [
	^ 'big'
]
