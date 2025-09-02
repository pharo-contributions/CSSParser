Class {
	#name : 'HtmlPRENode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'rendering' }
HtmlPRENode >> endStyles: formatter [
	formatter decreasePreformatted.
	formatter ensureNewlines: 1
]

{ #category : 'accessing' }
HtmlPRENode >> startStyles: formatter [
	formatter ensureNewlines: 1.
	formatter increasePreformatted
]

{ #category : 'accessing' }
HtmlPRENode >> tag [
	^ 'pre'
]
