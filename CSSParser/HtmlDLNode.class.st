Class {
	#name : #HtmlDLNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #rendering }
HtmlDLNode >> endStyles: aFormatter [
	aFormatter ensureNewlines: 1.
]

{ #category : #accessing }
HtmlDLNode >> tag [
	^ 'dl'
]
