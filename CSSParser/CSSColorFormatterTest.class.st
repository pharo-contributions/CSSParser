Class {
	#name : #CSSColorFormatterTest,
	#superclass : #TestCase,
	#instVars : [
		'colorFormatter'
	],
	#category : #'CSSParser-CSS-Tests'
}

{ #category : #accessing }
CSSColorFormatterTest >> colorFormatter [

	^ colorFormatter
]

{ #category : #accessing }
CSSColorFormatterTest >> colorFormatter: anObject [

	colorFormatter := anObject
]

{ #category : #running }
CSSColorFormatterTest >> setUp [
	self colorFormatter: CSSColorFormatter new
]

{ #category : #testing }
CSSColorFormatterTest >> test01ColorShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'color';
				propertyString: 'blue';
				yourself.
	self colorFormatter parseTextAttributesFrom: prop into: result.
	self assert: Color blue equals: (result at: #color).
]
