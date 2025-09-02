Class {
	#name : 'HtmlHEADNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlHEADNode >> addToFormatter: aFormatter [
	"Do nothing"
]

{ #category : 'accessing' }
HtmlHEADNode >> tag [
	^ 'head'
]
