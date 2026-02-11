Class {
	#name : 'HtmlULNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlULNode >> addDefaultStyle [
	"| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'list-style-type' -> 'disc'.
		'margin' -> '1em 0'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)"
]

{ #category : 'accessing' }
HtmlULNode >> tag [
	^ 'ul'
]
