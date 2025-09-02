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
HtmlOLNode >> endStyles: aFormatter [
	aFormatter endOrderedList.
]

{ #category : 'accessing' }
HtmlOLNode >> startStyles: aFormatter [
	aFormatter startOrderedListWithStart: (self attributes at: 'start' ifAbsent: [1]) asInteger type: (self computedStyles at: #'list-style-type' ifAbsent: ['decimal']).
]

{ #category : 'accessing' }
HtmlOLNode >> tag [
	^ 'ol'
]
