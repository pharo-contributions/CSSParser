Class {
	#name : #HtmlULNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlULNode >> addDefaultStyle [
	"| styles |
	styles := Dictionary newFrom: {
		'display' -> 'block'.
		'list-style-type' -> 'disc'.
		'margin' -> '1em 0'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)"
]

{ #category : #accessing }
HtmlULNode >> endStyles: aFormatter [
	aFormatter endUnorderedList
]

{ #category : #accessing }
HtmlULNode >> startStyles: aFormatter [
	aFormatter startUnorderedListWithType: (self computedStyles at: #'list-style-type' ifAbsent: ['disc']).
]

{ #category : #accessing }
HtmlULNode >> tag [
	^ 'ul'
]
