Class {
	#name : #HtmlHEADNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #accessing }
HtmlHEADNode >> addToFormatter: aFormatter [
	"Do nothing"
]

{ #category : #accessing }
HtmlHEADNode >> tag [
	^ 'head'
]
