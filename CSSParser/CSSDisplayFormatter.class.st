Class {
	#name : #CSSDisplayFormatter,
	#superclass : #CSSFormatter,
	#category : #'CSSParser-Formatter'
}

{ #category : #accessing }
CSSDisplayFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			'display'	-> 	[ :aProperty :aContext |  self readDisplayFrom: aProperty to: aContext ]
		}]
]

{ #category : #parsing }
CSSDisplayFormatter >> parseTextAttributesFrom: aCSSProperty into: aContext [
	aCSSProperty propertyName = 'display' ifTrue: [
		| values |
		values := Dictionary newFrom: {
			'inline' -> #inline.
			'inline-block' -> #inlineBlock.
			'block' -> #block.
			'table' -> #table.
			'table-row' -> #tableRow.
			'table-cell' -> #tableCell
		}.
		values at: aCSSProperty propertyString asLowercase
			ifPresent: [:value | aContext at: #display put: value ]
			ifAbsent: [ (aContext includesKey: #display) ifFalse: [ aContext at: #display put: #inline ]]]
]

{ #category : #parsing }
CSSDisplayFormatter >> readDisplayFrom: aCSSProperty to: aContext [

	| values |
	values := Dictionary newFrom: {
		'inline' -> #inline.
		'inline-block' -> #inlineBlock.
		'block' -> #block.
		'table' -> #table.
		'table-row' -> #tableRow.
		'table-cell' -> #tableCell
	}.
	values at: aCSSProperty propertyString asLowercase
		ifPresent: [:value | aContext at: #display put: value ]
		ifAbsent: [ (aContext includesKey: #display) ifFalse: [ aContext at: #display put: #inline ]]
]
