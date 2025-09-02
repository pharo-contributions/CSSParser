Class {
	#name : 'HtmlCENTERNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlCENTERNode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'text-align' -> 'center'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : 'accessing' }
HtmlCENTERNode >> tag [
	^ 'center'
]
