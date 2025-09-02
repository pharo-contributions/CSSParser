Class {
	#name : 'HtmlDTNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlDTNode >> startStyles: aFormatter [
	aFormatter ensureNewlines: 1
]

{ #category : 'accessing' }
HtmlDTNode >> tag [
	^ 'dt'
]
