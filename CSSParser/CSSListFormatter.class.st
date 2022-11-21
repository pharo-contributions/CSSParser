Class {
	#name : #CSSListFormatter,
	#superclass : #CSSFormatter,
	#category : #'CSSParser-Formatter'
}

{ #category : #accessing }
CSSListFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			'list-style-type' 			-> 	[ :aProperty :aContext | self put: aProperty propertyString at: #'list-style-type' to: aContext ]
		}]
]

{ #category : #parsing }
CSSListFormatter >> parseTextAttributesFrom: aCSSProperty into: aContext [
	aCSSProperty propertyName = 'list-style-type' ifFalse: [^nil].
	aContext at: #'list-style-type' put: aCSSProperty propertyString.
]
