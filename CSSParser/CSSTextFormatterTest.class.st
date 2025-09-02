Class {
	#name : 'CSSTextFormatterTest',
	#superclass : 'TestCase',
	#instVars : [
		'textFormatter'
	],
	#category : 'CSSParser-CSS-Tests',
	#package : 'CSSParser',
	#tag : 'CSS-Tests'
}

{ #category : 'running' }
CSSTextFormatterTest >> setUp [
	super setUp.
	self textFormatter: CSSTextFormatter new
]

{ #category : 'testing' }
CSSTextFormatterTest >> test01TextDecorationUnderlinedShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'text-decoration';
				propertyString: 'underline';
				yourself.
	self textFormatter parseTextAttributesFrom: prop into: result.
	self assert: true equals: (result at: #underlined)
]

{ #category : 'testing' }
CSSTextFormatterTest >> test02TextDecorationLineThroughShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'text-decoration';
				propertyString: 'line-through';
				yourself.
	self textFormatter parseTextAttributesFrom: prop into: result.
	self assert: true equals: (result at: #struckOut)
]

{ #category : 'testing' }
CSSTextFormatterTest >> test03TextDecorationUnderlinedLineThroughShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'text-decoration';
				propertyString: 'underline line-through';
				yourself.
	self textFormatter parseTextAttributesFrom: prop into: result.
	self assert: true equals: (result at: #underlined).
	self assert: true equals: (result at: #struckOut)
]

{ #category : 'testing' }
CSSTextFormatterTest >> test04TextAlignCenterShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'text-align';
				propertyString: 'center';
				yourself.
	self textFormatter parseTextAttributesFrom: prop into: result.
	self assert: #centered equals: (result at: #textAlign).
	self assert: (TextAlignment respondsTo: #centered)
]

{ #category : 'testing' }
CSSTextFormatterTest >> test05TextAlignLeftShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'text-align';
				propertyString: 'left';
				yourself.
	self textFormatter parseTextAttributesFrom: prop into: result.
	self assert: #leftFlush equals: (result at: #textAlign).
	self assert: (TextAlignment respondsTo: #leftFlush)
]

{ #category : 'testing' }
CSSTextFormatterTest >> test06TextAlignRightShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'text-align';
				propertyString: 'right';
				yourself.
	self textFormatter parseTextAttributesFrom: prop into: result.
	self assert: #rightFlush equals: (result at: #textAlign).
	self assert: (TextAlignment respondsTo: #rightFlush)
]

{ #category : 'testing' }
CSSTextFormatterTest >> test07TextAlignJustifyShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'text-align';
				propertyString: 'justify';
				yourself.
	self textFormatter parseTextAttributesFrom: prop into: result.
	self assert: #justified equals: (result at: #textAlign).
	self assert: (TextAlignment respondsTo: #justified)
]

{ #category : 'accessing' }
CSSTextFormatterTest >> textFormatter [

	^ textFormatter
]

{ #category : 'accessing' }
CSSTextFormatterTest >> textFormatter: anObject [

	textFormatter := anObject
]
