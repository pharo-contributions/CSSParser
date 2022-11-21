Class {
	#name : #HtmlDOMNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'domNode'
	],
	#category : #'CSSParser-Tests'
}

{ #category : #accessing }
HtmlDOMNodeTest >> domNode [

	^ domNode
]

{ #category : #accessing }
HtmlDOMNodeTest >> domNode: anObject [

	domNode := anObject
]

{ #category : #running }
HtmlDOMNodeTest >> setUp [ 
	self domNode: HtmlDOMNode new
]

{ #category : #testing }
HtmlDOMNodeTest >> test01FlushingInlineNodesShouldEmptyInputCollection [
	| blockMorph inlineNodes |
	blockMorph := HtmlBlockMorph new.
	blockMorph node: self domNode.
	inlineNodes := OrderedCollection newFrom: { HtmlDOMNode new. HtmlDOMNode new }.
	self domNode flushInlineNodes: inlineNodes to: blockMorph.
	self assert: inlineNodes isEmpty
]

{ #category : #testing }
HtmlDOMNodeTest >> test02InlineNodesShouldBePlacedInHtmlInlineMorph [

	| doc result |
	doc := HtmlDocument new 
		content: 'test';
		children: {self domNode}.
	self domNode children: { HtmlCDATANode start: 0 end: 4 }.
	result := self domNode getHtmlBlockMorph.
	self assert: result submorphs size equals: 1.
	self assert: result submorphs first class equals: HtmlInlineMorph.
	self assert: result submorphs first text asString equals: 'test'
]

{ #category : #testing }
HtmlDOMNodeTest >> test03SubsequentInlineNodesShouldGroupedIntoHtmlInlineMorph [

	| doc result |
	doc := HtmlDocument new 
		content: 'testeins';
		children: {self domNode}.
	self domNode children: { HtmlCDATANode start: 0 end: 4. HtmlCDATANode start: 4 end: 8 }.
	result := self domNode getHtmlBlockMorph.
	self assert: result submorphs size equals: 1.
	self assert: result submorphs first class equals: HtmlInlineMorph.
	self assert: result submorphs first text asString equals: 'testeins'
]

{ #category : #testing }
HtmlDOMNodeTest >> test04BlockNodeShouldBePlacedInHtmlBlockMorph [

	| result |
	self domNode children: { HtmlDIVNode new }.
	result := self domNode getHtmlBlockMorph.
	self assert: result submorphs size equals: 1.
	self assert: result submorphs first class equals: HtmlBlockMorph
]

{ #category : #testing }
HtmlDOMNodeTest >> test05MixedChildrenShouldBeGroupedIntoCorrectSubmorphs [

	| doc result |
	doc := HtmlDocument new 
		content: 'testeinszweidrei';
		children: {self domNode}.
	self domNode children: { 
		HtmlCDATANode start: 0 end: 4. 
		HtmlDIVNode new.
		HtmlCDATANode start: 4 end: 8.
		HtmlCDATANode start: 8 end: 12.
		HtmlDIVNode new.
		HtmlCDATANode start: 12 end: 16}.
	result := self domNode getHtmlBlockMorph.
	self assert: result submorphs size equals: 5.
	self assert: result submorphs first class equals: HtmlInlineMorph.
	self assert: result submorphs first text asString equals: 'test'.
	self assert: result submorphs second class equals: HtmlBlockMorph.
	self assert: result submorphs third class equals: HtmlInlineMorph.
	self assert: result submorphs third text asString equals: 'einszwei'.
	self assert: result submorphs fourth class equals: HtmlBlockMorph.
	self assert: result submorphs fifth class equals: HtmlInlineMorph.
	self assert: result submorphs fifth text asString equals: 'drei'
]

{ #category : #testing }
HtmlDOMNodeTest >> test06InlineBlockElementsShouldBeTransformedIntoCorrectSubmorphs [

	| doc result |
	doc := HtmlDocument new 
		content: 'testeinszwei';
		children: {self domNode}.
	self domNode children: { 
		HtmlCDATANode start: 0 end: 4. 
		HtmlDIVNode new 
			computedStyles: (Dictionary newFrom: { #display -> #inlineBlock });
			children: { HtmlCDATANode start: 4 end: 8 }.
		HtmlCDATANode start: 8 end: 12 }.
	result := self domNode getHtmlBlockMorph.
	self assert: result submorphs size equals: 1.
	self assert: result submorphs first class equals: HtmlInlineMorph.
	self assert: (result submorphs first text findString: 'test' startingAt: 1) > 0.
	self assert: (result submorphs first text findString: 'zwei' startingAt: 1) > 0.
	self assert: result submorphs first submorphs size equals: 1.
	self assert: result submorphs first submorphs first class equals: HtmlBlockMorph.
	self assert: result submorphs first submorphs first submorphs size equals: 1.
	self assert: result submorphs first submorphs first submorphs first class equals: HtmlInlineMorph.
	self assert: result submorphs first submorphs first submorphs first text equals: 'eins'
]

{ #category : #testing }
HtmlDOMNodeTest >> test07InlineBlockElementsShouldAlwaysBeRenderedInline [

	self domNode 
		computedStyles: (Dictionary newFrom: { #display -> #inlineBlock });
		children: { HtmlDIVNode new }.
	self assert: self domNode isRenderedInline equals: true
]

{ #category : #testing }
HtmlDOMNodeTest >> test08BlockElementsShouldNeverBeRenderedInline [

	self domNode 
		computedStyles: (Dictionary newFrom: { #display -> #block });
		children: { HtmlCDATANode new }.
	self assert: self domNode isRenderedInline equals: false
]

{ #category : #testing }
HtmlDOMNodeTest >> test09InlineElementsShouldBeRenderedAsBlockIfContainingBlockChildren [

	self domNode
		computedStyles: (Dictionary newFrom: { #display -> #inline });
		children: { HtmlCDATANode new. HtmlDIVNode new }.
	self assert: self domNode isRenderedInline equals: false
]

{ #category : #testing }
HtmlDOMNodeTest >> test10BoxTypeShouldDefaultToInline [

	self assert: self domNode boxType equals: #inline
]

{ #category : #testing }
HtmlDOMNodeTest >> test11BoxTypeShouldBeResolvedToCSSAttribute [

	self domNode addStyle: (CSSStyleRule fromDictionary: (Dictionary newFrom: { 'display' -> 'inline-block' })).
	self assert: self domNode boxType equals: #inlineBlock
]

{ #category : #testing }
HtmlDOMNodeTest >> test12InlineNodesShouldBeAssignedToHtmlInlineMorph [

	| doc result inlineNodes |
	doc := HtmlDocument new 
		content: 'testeins';
		children: {self domNode}.
	inlineNodes :=  { HtmlCDATANode start: 0 end: 4. HtmlCDATANode start: 4 end: 8 }..
	self domNode children: inlineNodes.
	result := self domNode getHtmlBlockMorph.
	self assert: result submorphs first nodes size equals: inlineNodes size.
	self assert: (result submorphs first nodes allSatisfy: [:node | inlineNodes includes: node ])
]

{ #category : #testing }
HtmlDOMNodeTest >> test13AttributesInUppercaseShouldBeParsed [
	| doc |
	doc := HtmlDocument new 
		parseContents: (ReadStream on: '<A HREF="test">link</A>').
	self assert: HtmlANode equals: doc children first class.
	self assert: (doc children first attributes includesKey: 'href').
	self assert: 'test' equals: (doc children first attributes at: 'href')
]
