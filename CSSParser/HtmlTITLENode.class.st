Class {
	#name : 'HtmlTITLENode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlTITLENode >> innerContents [

	^self rawContent
]

{ #category : 'accessing' }
HtmlTITLENode >> tag [
	^ 'title'
]
