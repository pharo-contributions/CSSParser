Class {
	#name : 'CSSColorFormatter',
	#superclass : 'CSSFormatter',
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'accessing' }
CSSColorFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			'color' 			-> 	[ :aProperty :aContext |  self readColorFrom: aProperty to: aContext ]
		}]
]

{ #category : 'parsing' }
CSSColorFormatter >> parseTextAttributesFrom: aCSSProperty into: aContext [
	aCSSProperty propertyName = 'color' ifFalse: [^nil].
	(Color fromHTMLString: aCSSProperty propertyString) ifNotNil:
		[:color | aContext at: #color put: color].
]

{ #category : 'parsing' }
CSSColorFormatter >> readColorFrom: aProperty to: aContext [

	(Color fromHTMLString: aProperty propertyString) 
		ifNotNil: [ :color | self put: color at: #color to: aContext ]
]
