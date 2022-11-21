Class {
	#name : #CSSDisplayFormatterTest,
	#superclass : #TestCase,
	#instVars : [
		'displayFormatter'
	],
	#category : #'CSSParser-CSS-Tests'
}

{ #category : #accessing }
CSSDisplayFormatterTest >> displayFormatter [

	^ displayFormatter
]

{ #category : #accessing }
CSSDisplayFormatterTest >> displayFormatter: anObject [

	displayFormatter := anObject
]

{ #category : #running }
CSSDisplayFormatterTest >> setUp [
	super setUp.
	self displayFormatter: CSSDisplayFormatter new
]

{ #category : #testing }
CSSDisplayFormatterTest >> test01SupportedDisplayValuesShouldBeParsedCorrectly [
	| supportedValues |
	supportedValues := Dictionary newFrom: {
		'inline' -> #inline.
		'inline-block' -> #inlineBlock.
		'block' -> #block
	}.
	
	supportedValues keysAndValuesDo: [:value :expectedResult |
		| tempContext |
		tempContext := Dictionary new.
		self displayFormatter 
			parseTextAttributesFrom: ((CSSProperty propertyNamed: 'display') propertyString: value)  
			into: tempContext.
		self assert: (tempContext at: #display) equals: expectedResult ]
]

{ #category : #testing }
CSSDisplayFormatterTest >> test02OtherDisplayValuesShouldDefaultToInline [
	| styles |
	styles := Dictionary new.
	self displayFormatter 
		parseTextAttributesFrom: ((CSSProperty propertyNamed: 'display') propertyString: 'foobar')  
		into: styles.
	self assert: (styles at: #display) equals: #inline
]

{ #category : #testing }
CSSDisplayFormatterTest >> test03DefaultFallbackDisplayValueShouldNotOverrideSupportedValue [
	| styles |
	styles := Dictionary newFrom: { #display -> #inlineBlock }.
	self displayFormatter 
		parseTextAttributesFrom: ((CSSProperty propertyNamed: 'display') propertyString: 'foobar')  
		into: styles.
	self assert: (styles at: #display) equals: #inlineBlock
]
