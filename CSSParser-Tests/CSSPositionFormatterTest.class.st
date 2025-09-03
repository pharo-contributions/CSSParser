Class {
	#name : 'CSSPositionFormatterTest',
	#superclass : 'TestCase',
	#instVars : [
		'positionFormatter'
	],
	#category : 'CSSParser-Tests-CSS-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'CSS-Tests'
}

{ #category : 'accessing' }
CSSPositionFormatterTest >> positionFormatter [

	^ positionFormatter
]

{ #category : 'accessing' }
CSSPositionFormatterTest >> positionFormatter: anObject [

	positionFormatter := anObject

]

{ #category : 'running' }
CSSPositionFormatterTest >> setUp [
	super setUp.
	self positionFormatter: CSSPositionFormatter new
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test01PositionAbsoluteShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'position';
				propertyString: 'absolute';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: #absolute equals: (result at: #position)
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test02PositionFixedShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'position';
				propertyString: 'fixed';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: #fixed equals: (result at: #position)
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test03PositionRelativeShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'position';
				propertyString: 'relative';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: #relative equals: (result at: #position)
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test04PositionStaticShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'position';
				propertyString: 'static';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: #static equals: (result at: #position)
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test05TopPositionShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'top';
				propertyString: '10px';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: '10px' equals: (result at: #top)
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test06RightPositionShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'right';
				propertyString: '20px';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: '20px' equals: (result at: #right)
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test07BottomPositionShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'bottom';
				propertyString: '30px';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: '30px' equals: (result at: #bottom)
]

{ #category : 'testing' }
CSSPositionFormatterTest >> test08LeftPositionShouldBeParsedCorrectly [
	| prop result |
	result := Dictionary new.
	prop := CSSProperty new
				propertyName: 'left';
				propertyString: '40px';
				yourself.
	self positionFormatter parseTextAttributesFrom: prop into: result.
	self assert: '40px' equals: (result at: #left)
]
