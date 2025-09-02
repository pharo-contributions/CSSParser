Class {
	#name : 'HtmlUNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlUNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'text-decoration' -> 'underline'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlUNode >> tag [
	^ 'u'
]
