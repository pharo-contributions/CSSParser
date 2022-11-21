Class {
	#name : #CSSSelectorTest,
	#superclass : #TestCase,
	#instVars : [
		'colorFormatter'
	],
	#category : #'CSSParser-CSS-Tests'
}

{ #category : #testing }
CSSSelectorTest >> test01CSSSelectorWihtoutNilSelector [

	| selector |
	selector := CSSSelector fromString: 'yt-uix-button img,.yt-uix-button-icon-wrapper+.yt-uix-button-content'.
	self assert: selector asString equals: 'yt-uix-button img , *.yt-uix-button-icon-wrapper+*.yt-uix-button-content '.
]

{ #category : #testing }
CSSSelectorTest >> test02CSSAtRuleStartingWithDashShouldNotRaiseErrors [

	self shouldnt: [CSSAtRule named: '-ignore'] raise: MessageNotUnderstood.
]
