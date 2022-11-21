Class {
	#name : #HtmlBLOCKQUOTENode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #rendering }
HtmlBLOCKQUOTENode >> endStyles: aFormatter [
	aFormatter decreaseIndent.
	aFormatter ensureNewlines: 2
]

{ #category : #accessing }
HtmlBLOCKQUOTENode >> startStyles: aFormatter [
	aFormatter ensureNewlines: 2.
	aFormatter increaseIndent
]

{ #category : #accessing }
HtmlBLOCKQUOTENode >> tag [
	^ 'blockquote'
]
