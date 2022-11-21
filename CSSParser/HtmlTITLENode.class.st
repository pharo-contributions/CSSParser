Class {
	#name : #HtmlTITLENode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #accessing }
HtmlTITLENode >> innerContents [

	^self rawContent
]

{ #category : #accessing }
HtmlTITLENode >> tag [
	^ 'title'
]
