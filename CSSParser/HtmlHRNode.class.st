Class {
	#name : 'HtmlHRNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'rendering' }
HtmlHRNode >> addToFormatter: formatter [
	formatter hr
]

{ #category : 'accessing' }
HtmlHRNode >> tag [
	^ 'hr'
]
