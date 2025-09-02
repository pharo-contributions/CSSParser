Class {
	#name : 'HtmlBODYNode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'initialize-release' }
HtmlBODYNode >> defaultBlockMorph [
	^ HtmlBodyMorph
]

{ #category : 'accessing' }
HtmlBODYNode >> tag [
	^ 'body'
]
