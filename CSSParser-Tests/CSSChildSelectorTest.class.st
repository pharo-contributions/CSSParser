Class {
	#name : 'CSSChildSelectorTest',
	#superclass : 'TestCase',
	#category : 'CSSParser-Tests-CSS-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'CSS-Tests'
}

{ #category : 'testing' }
CSSChildSelectorTest >> test01NodeWithoutParentShouldntRaiseErrors [

	| selector |
	selector := CSSSelector fromString: 'a>*'.
	self deny: (selector matches: HtmlParseNode new)
]
