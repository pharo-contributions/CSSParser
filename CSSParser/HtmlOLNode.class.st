Class {
	#name : 'HtmlOLNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlOLNode >> addDefaultStyle [
	"| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'list-style-type' -> 'decimal'.
		'margin' -> '1em 0'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)"
]

{ #category : 'accessing' }
HtmlOLNode >> tag [
	^ 'ol'
]
