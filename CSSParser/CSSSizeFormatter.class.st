Class {
	#name : #CSSSizeFormatter,
	#superclass : #CSSFormatter,
	#category : #'CSSParser-Formatter'
}

{ #category : #accessing }
CSSSizeFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			'height'		-> 	[ :aProperty :aContext | self put: aProperty propertyString asInteger at: #height to: aContext ].
			'width'		-> 	[ :aProperty :aContext | self readWidthFrom: aProperty to: aContext ]
		}]
]

{ #category : #parsing }
CSSSizeFormatter >> parseTextAttributesFrom: aCSSProperty into: aContext [

	(aCSSProperty propertyName = 'height' and: [ self isNumber: aCSSProperty propertyString ])
		ifTrue: [ aContext at: #height put: aCSSProperty propertyString asInteger ].
	aCSSProperty propertyName = 'width'
		ifTrue: [
			aContext at: #absoluteWidth put: nil.
			aContext at: #relativeWidth put: nil.
			
			aCSSProperty propertyString = 'auto' ifTrue: [
				aContext at: #absoluteWidth put: #auto.
				^ self].
			
			self isRelativeSize: aCSSProperty propertyString ifTrue: [
				"hope it's percent"
				aContext at: #relativeWidth put: aCSSProperty propertyString asInteger.
				^ self].
			self isAbsoluteSize: aCSSProperty propertyString 
				ifTrue: [ aContext at: #absoluteWidth put: 
					(self absoluteSizeToPx: aCSSProperty propertyString defaultSize: 0) ] ]
]

{ #category : #parsing }
CSSSizeFormatter >> readWidthFrom: aCSSProperty to: aContext [

	aContext at: #absoluteWidth put: nil.
	aContext at: #relativeWidth put: nil.
			
	aCSSProperty propertyString = 'auto' ifTrue: [
		aContext at: #absoluteWidth put: #auto.
		^ self].
		
	self isRelativeSize: aCSSProperty propertyString ifTrue: [
		"hope it's percent"
		aContext at: #relativeWidth put: aCSSProperty propertyString asInteger.
		^ self].
	self isAbsoluteSize: aCSSProperty propertyString 
		ifTrue: [ aContext at: #absoluteWidth put: 
			(self absoluteSizeToPx: aCSSProperty propertyString defaultSize: 0) 
	]
]
