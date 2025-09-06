Class {
	#name : 'CSSBackgroundFormatterTest',
	#superclass : 'TestCase',
	#instVars : [
		'backgroundFormatter'
	],
	#category : 'CSSParser-Tests-CSS-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'CSS-Tests'
}

{ #category : 'accessing' }
CSSBackgroundFormatterTest >> backgroundFormatter [

	^ backgroundFormatter
]

{ #category : 'accessing' }
CSSBackgroundFormatterTest >> backgroundFormatter: anObject [

	backgroundFormatter := anObject
]

{ #category : 'running' }
CSSBackgroundFormatterTest >> setUp [
	super setUp.
	self backgroundFormatter: CSSBackgroundFormatter new
]

{ #category : 'running' }
CSSBackgroundFormatterTest >> test01BackgroundColorShouldBeParsedCorrectly [
	| property result |
	result := Dictionary new.
	property := CSSProperty new
				propertyName: 'background-color';
				propertyString: 'blue';
				yourself.
	self backgroundFormatter parseTextAttributesFrom: property into: result.
	self assert: Color blue equals: (result at: #backgroundColor).
]

{ #category : 'running' }
CSSBackgroundFormatterTest >> test02BackgroundImageShouldBeParsedCorrectly [
	| property result |
	result := Dictionary new.
	property := CSSProperty new
				propertyName: 'background-image';
				propertyString: 'url(/foo.png)';
				yourself.
	self backgroundFormatter parseTextAttributesFrom: property into: result.
	self assert: '/foo.png' equals: (result at: #backgroundImage).
]

{ #category : 'running' }
CSSBackgroundFormatterTest >> test03BackgroundPositionShouldBeParsedCorrectly [
	| property result |
	result := Dictionary new.
	property := CSSProperty new
				propertyName: 'background-position';
				propertyString: '30px 40px';
				yourself.
	self backgroundFormatter parseTextAttributesFrom: property into: result.
	self assert: 30@40 equals: (result at: #backgroundPosition).
]

{ #category : 'running' }
CSSBackgroundFormatterTest >> test04BackgroundRepeatShouldBeParsedCorrectly [
	| property result |
	result := Dictionary new.
	property := CSSProperty new
				propertyName: 'background-repeat';
				propertyString: 'repeat-x';
				yourself.
	self backgroundFormatter parseTextAttributesFrom: property into: result.
	self assert: #repeatX equals: (result at: #backgroundRepeat).
]

{ #category : 'running' }
CSSBackgroundFormatterTest >> test05BackgroundShouldBeParsedCorrectly [
	| property result |
	result := Dictionary new.
	property := CSSProperty new
				propertyName: 'background';
				propertyString: 'blue url(/bar.png) 20px 30px/40px 10px no-repeat';
				yourself.
	self backgroundFormatter parseTextAttributesFrom: property into: result.
	
	self assert: Color blue equals: (result at: #backgroundColor);
		assert: '/bar.png' equals: (result at: #backgroundImage);
		assert: #noRepeat equals: (result at: #backgroundRepeat);
		assert: 20@30 equals: (result at: #backgroundPosition)
]
