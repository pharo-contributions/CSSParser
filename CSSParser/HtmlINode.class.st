Class {
	#name : #HtmlINode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlINode >> addDefaultStyle [
	| styles |
	styles := Dictionary newFrom: {
		'font-style' -> 'italic'.
	}.
	self addStyle: (CSSDefaultStyleRule fromDictionary: styles)
]

{ #category : #accessing }
HtmlINode >> tag [
	^ 'i'
]
