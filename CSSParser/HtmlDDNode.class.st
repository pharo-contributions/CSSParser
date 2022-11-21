Class {
	#name : #HtmlDDNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #rendering }
HtmlDDNode >> endStyles: aFormatter [
	aFormatter decreaseIndent.
]

{ #category : #accessing }
HtmlDDNode >> startStyles: aFormatter [
	aFormatter ensureNewlines: 1.
	aFormatter increaseIndent
]

{ #category : #accessing }
HtmlDDNode >> tag [
	^ 'dd'
]
