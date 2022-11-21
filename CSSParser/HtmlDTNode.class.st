Class {
	#name : #HtmlDTNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #accessing }
HtmlDTNode >> startStyles: aFormatter [
	aFormatter ensureNewlines: 1
]

{ #category : #accessing }
HtmlDTNode >> tag [
	^ 'dt'
]
