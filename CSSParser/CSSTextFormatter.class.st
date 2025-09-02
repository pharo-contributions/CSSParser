Class {
	#name : 'CSSTextFormatter',
	#superclass : 'CSSFormatter',
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'accessing' }
CSSTextFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			'text-decoration' 	-> 	[ :prop :fontAttribs | self readTextDecorationAttribute: prop propertyString to: fontAttribs ].
			'text-align' 			-> 	[ :prop :fontAttribs | self readTextAlignAttribute: prop propertyString to: fontAttribs ]
		}]
]

{ #category : 'parsing' }
CSSTextFormatter >> parseTextAttributesFrom: aCSSProperty into: aContext [
	(self attributeMap at: aCSSProperty propertyName ifAbsent: [nil])
		ifNotNil: [:process | process value: aCSSProperty value: aContext ]
]

{ #category : 'parsing' }
CSSTextFormatter >> readTextAlignAttribute: aString to: aContext [

	(aString substrings: ' ') do: [ :attribute | 
		(attribute = 'center') 
			ifTrue: [ self put: #centered at: #textAlign to: aContext ].
		((attribute = 'left') or: [attribute = 'start']) 
			ifTrue: [ self put: #leftFlush at: #textAlign to: aContext ].
		((attribute = 'right') or: [attribute = 'end']) 
			ifTrue: [ self put: #rightFlush at: #textAlign to: aContext ].
		(attribute = 'justify') 
			ifTrue: [ self put: #justified at: #textAlign to: aContext ]]

]

{ #category : 'parsing' }
CSSTextFormatter >> readTextDecorationAttribute: aString to: aContext [

	(aString substrings: ' ') do: [ :attribute | 
		(attribute = 'underline') 
			ifTrue: [ self put: true at: #underlined to: aContext ].
		(attribute = 'line-through') 
			ifTrue: [ self put: true at: #struckOut to: aContext ]
	]
]
