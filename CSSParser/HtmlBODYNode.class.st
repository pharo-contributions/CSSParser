Class {
	#name : #HtmlBODYNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #'initialize-release' }
HtmlBODYNode >> defaultBlockMorph [
	^ HtmlBodyMorph
]

{ #category : #accessing }
HtmlBODYNode >> tag [
	^ 'body'
]
