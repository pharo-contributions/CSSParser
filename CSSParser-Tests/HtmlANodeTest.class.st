Class {
	#name : 'HtmlANodeTest',
	#superclass : 'TestCase',
	#instVars : [
		'aNode'
	],
	#category : 'CSSParser-Tests-HTML-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'HTML-Tests'
}

{ #category : 'accessing' }
HtmlANodeTest >> aNode [

	^ aNode
]

{ #category : 'accessing' }
HtmlANodeTest >> aNode: anObject [

	aNode := anObject
]

{ #category : 'running' }
HtmlANodeTest >> setUp [ 
	self aNode: HtmlANode new
]

{ #category : 'testing' }
HtmlANodeTest >> test01AShouldRenderAsHtmlLinkMorphIfDisplayIsBlock [

	self assert: self aNode getHtmlBlockMorph class equals: HtmlLinkMorph
]
