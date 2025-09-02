Class {
	#name : 'CSSDistanceFormatter',
	#superclass : 'CSSFormatter',
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'constants' }
CSSDistanceFormatter class >> attributePrefix [

	self subclassResponsibility 
]

{ #category : 'constants' }
CSSDistanceFormatter class >> attributeSuffix [

	self subclassResponsibility
]

{ #category : 'accessing' }
CSSDistanceFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			self class attributePrefix, self class attributeSuffix 				-> 	[ :aProperty :aContext | self readShorthandAttributesFrom: aProperty propertyString to: aContext ].
			self class attributePrefix, '-top', self class attributeSuffix		-> 	[ :aProperty :aContext | self put: aProperty propertyString at: 'top', self class attributeSuffix to: aContext ].
			self class attributePrefix, '-right', self class attributeSuffix 		->	[ :aProperty :aContext | self put: aProperty propertyString at: 'right', self class attributeSuffix to: aContext ].
			self class attributePrefix, '-bottom', self class attributeSuffix	->	[ :aProperty :aContext | self put: aProperty propertyString at: 'bottom', self class attributeSuffix to: aContext ].
			self class attributePrefix, '-left'	, self class attributeSuffix		-> 	[ :aProperty :aContext | self put: aProperty propertyString at: 'left', self class attributeSuffix to: aContext ]
		}]
]

{ #category : 'parsing' }
CSSDistanceFormatter >> put: aPropertyValue at: anAttribute to: aContext [

	| aPrefixedAttribute valueInPixel |
	
	aPrefixedAttribute := self class attributePrefix, '-', anAttribute asSymbol.	
	self isAbsoluteSize: aPropertyValue ifTrue: [
		valueInPixel := self absoluteSizeToPx: aPropertyValue defaultSize: 0.
		super put: valueInPixel at: aPrefixedAttribute to: aContext].
	self isRelativeSize: aPropertyValue ifTrue: [
		valueInPixel := self relativeSizeToPx: aPropertyValue parentAndDefaultSize: self rootValueForEm.
		super put: valueInPixel at: aPrefixedAttribute to: aContext].
	

]

{ #category : 'parsing' }
CSSDistanceFormatter >> readFourAttributesFrom: aPropertyValue to: aContext [

		(aPropertyValue splitOn: ' ') doWithIndex: [:each :index |
			(index = 1) 
				ifTrue: [ self put: each at: 'top', self class attributeSuffix to: aContext ].
			(index = 2) 
				ifTrue: [ self put: each at: 'right', self class attributeSuffix to: aContext ].
			(index = 3) 
				ifTrue: [ self put: each at: 'bottom', self class attributeSuffix to: aContext ].
			(index = 4) 
				ifTrue: [ self put: each at: 'left', self class attributeSuffix to: aContext ]
		]
]

{ #category : 'parsing' }
CSSDistanceFormatter >> readOneAttributeFrom: aPropertyValue to: aContext [

		self put: aPropertyValue at: 'top', self class attributeSuffix to: aContext.
		self put: aPropertyValue at: 'right', self class attributeSuffix to: aContext. 
		self put: aPropertyValue at: 'bottom', self class attributeSuffix to: aContext. 
		self put: aPropertyValue at: 'left', self class attributeSuffix to: aContext
]

{ #category : 'parsing' }
CSSDistanceFormatter >> readShorthandAttributesFrom: aPropertyValue to: aContext [

	| aPropertyCount |
	
	aPropertyCount := (aPropertyValue splitOn: ' ') size.

	(aPropertyCount = 1)
		ifTrue:  [ self readOneAttributeFrom: aPropertyValue to: aContext ].
	(aPropertyCount = 2)
		ifTrue:  [ self readTwoAttributesFrom: aPropertyValue to: aContext ].
	(aPropertyCount = 3)
		ifTrue:  [ self readThreeAttributesFrom: aPropertyValue to: aContext ].
	(aPropertyCount = 4)
		ifTrue:  [ self readFourAttributesFrom: aPropertyValue to: aContext ]
]

{ #category : 'parsing' }
CSSDistanceFormatter >> readThreeAttributesFrom: aPropertyValue to: aContext [

		(aPropertyValue splitOn: ' ') doWithIndex: [:each :index |
			(index = 1) 
				ifTrue: [ self put: each at: 'top', self class attributeSuffix to: aContext ].
			(index = 2) 
				ifTrue: [ 
					self put: each at: 'right', self class attributeSuffix to: aContext.
					self put: each at: 'left', self class attributeSuffix to: aContext
				].
			(index = 3) 
				ifTrue: [ self put: each at: 'bottom', self class attributeSuffix to: aContext ]
		]
]

{ #category : 'parsing' }
CSSDistanceFormatter >> readTwoAttributesFrom: aPropertyValue to: aContext [

		(aPropertyValue splitOn: ' ') doWithIndex: [:each :index |
			(index = 1) 
				ifTrue: [ 
					self put: each at: 'top', self class attributeSuffix to: aContext.
					self put: each at: 'bottom', self class attributeSuffix to: aContext
				].
			(index = 2) 
				ifTrue: [ 
					self put: each at: 'right', self class attributeSuffix to: aContext. 
					self put: each at: 'left', self class attributeSuffix to: aContext
				]
		]
]
