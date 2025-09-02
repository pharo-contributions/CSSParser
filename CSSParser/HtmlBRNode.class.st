Class {
	#name : 'HtmlBRNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'rendering' }
HtmlBRNode >> addToFormatter: formatter [
	formatter addChar: Character cr.
]

{ #category : 'accessing' }
HtmlBRNode >> tag [
	^ 'br'
]
