Class {
	#name : #CSSAdjacentSelectorTest,
	#superclass : #TestCase,
	#category : #'CSSParser-CSS-Tests'
}

{ #category : #testing }
CSSAdjacentSelectorTest >> test01NodeWithoutParentShouldntRaiseErrors [
	| selector |
	selector := CSSSelector fromString: 'a+*'.
	self shouldnt: [selector matches: HtmlDocument new] raise: Error.
]
