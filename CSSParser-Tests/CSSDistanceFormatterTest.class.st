Class {
	#name : 'CSSDistanceFormatterTest',
	#superclass : 'TestCase',
	#instVars : [
		'formatter'
	],
	#category : 'CSSParser-Tests-CSS-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'CSS-Tests'
}

{ #category : 'accessing' }
CSSDistanceFormatterTest >> bottomAttribute [

	^ self prefix, '-bottom', self suffix
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> bottomAttributeShouldBeParsedCorrectly [

	| aProperty aResult |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self bottomAttribute asSymbol;
				propertyString: '40px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 40 equals: (aResult at: self bottomAttribute asSymbol)
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> completeAttribute [

	^ self prefix, self suffix
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> formatter [

	^ formatter 
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> formatter: aFormatter [

	formatter := aFormatter 
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> fourShorthandAttributesShouldBeParsedCorrectly [

	| aProperty aResult |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self completeAttribute asSymbol;
				propertyString: '90px 100px 110px 120px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 90 equals: (aResult at: self topAttribute asSymbol).
	self assert: 100 equals: (aResult at: self rightAttribute asSymbol).
	self assert: 110 equals: (aResult at: self bottomAttribute asSymbol).
	self assert: 120 equals: (aResult at: self leftAttribute asSymbol)
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> leftAttribute [

	^ self prefix, '-left', self suffix
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> leftAttributeShouldBeParsedCorrectly [

	| aProperty aResult |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self leftAttribute asSymbol;
				propertyString: '50px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 50 equals: (aResult at: self leftAttribute asSymbol)
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> oneShorthandAttributeShouldBeParsedCorrectly [

	| aProperty aResult |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self completeAttribute asSymbol;
				propertyString: '60px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 60 equals: (aResult at: self topAttribute asSymbol).
	self assert: 60 equals: (aResult at: self rightAttribute asSymbol).
	self assert: 60 equals: (aResult at: self bottomAttribute asSymbol).
	self assert: 60 equals: (aResult at: self leftAttribute asSymbol)
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> prefix [

	self subclassResponsibility
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> rightAttribute [

	^ self prefix, '-right', self suffix
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> rightAttributeShouldBeParsedCorrectly [

	| aProperty aResult |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self rightAttribute asSymbol;
				propertyString: '30px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 30 equals: (aResult at: self rightAttribute asSymbol)
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> suffix [

	self subclassResponsibility
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> threeShorthandAttributesShouldBeParsedCorrectly [

	| aProperty aResult |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self completeAttribute asSymbol;
				propertyString: '80px 90px 100px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 80 equals: (aResult at: self topAttribute asSymbol).
	self assert: 90 equals: (aResult at: self rightAttribute asSymbol).
	self assert: 100 equals: (aResult at: self bottomAttribute asSymbol).
	self assert: 90 equals: (aResult at: self leftAttribute asSymbol)
]

{ #category : 'accessing' }
CSSDistanceFormatterTest >> topAttribute [

	^ self prefix, '-top', self suffix
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> topAttributeShouldBeParsedCorrectly [

	| aProperty aResult  |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self topAttribute asSymbol;
				propertyString: '20px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 20 equals: (aResult at: self topAttribute asSymbol)
]

{ #category : 'testing' }
CSSDistanceFormatterTest >> twoShorthandAttributesShouldBeParsedCorrectly [

	| aProperty aResult |

	aResult := Dictionary new.
	aProperty := CSSProperty new
				propertyName: self completeAttribute asSymbol;
				propertyString: '70px 80px';
				yourself.
	self formatter parseTextAttributesFrom: aProperty into: aResult.
	self assert: 70 equals: (aResult at: self topAttribute asSymbol).
	self assert: 80 equals: (aResult at: self rightAttribute asSymbol).
	self assert: 70 equals: (aResult at: self bottomAttribute asSymbol).
	self assert: 80 equals: (aResult at: self leftAttribute asSymbol)
]
