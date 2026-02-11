Class {
	#name : 'CSSBackgroundFormatter',
	#superclass : 'CSSFormatter',
	#category : 'CSSParser-Formatter',
	#package : 'CSSParser',
	#tag : 'Formatter'
}

{ #category : 'accessing' }
CSSBackgroundFormatter >> attributeMap [

	^ attributeMap ifNil: [ attributeMap := Dictionary newFrom: {
			'background' 			-> 	[ :aProperty :aContext | self readBackgroundAttribute: aProperty propertyString of: aProperty to: aContext ].
			'background-image'		-> 	[ :aProperty :aContext | self readBackgroundImageAttribute: aProperty propertyString of: aProperty to: aContext].
			'background-color' 		->	[ :aProperty :aContext | self readBackgroundColorAttribute: aProperty propertyString to: aContext ].
			'background-repeat' 	->	[ :aProperty :aContext | self readBackgroundRepeatAttribute: aProperty propertyString to: aContext ].
			'background-position'	-> 	[ :aProperty :aContext | self readBackgroundPositionAttribute: aProperty propertyString to: aContext ]
		}]
]

{ #category : 'parsing' }
CSSBackgroundFormatter >> isValidRepeatValue: aString [

	^ {'repeat'. 'repeat-x'. 'repeat-y'. 'no-repeat'. 'initial'. 'inherit'} includes: aString
]

{ #category : 'parsing' }
CSSBackgroundFormatter >> parseTextAttributesFrom: aCSSProperty into: aContext [
	
	aCSSProperty propertyName = 'background'
		ifTrue: [ self readBackgroundAttribute: aCSSProperty propertyString of: aCSSProperty to: aContext ].
	aCSSProperty propertyName = 'background-image'
		ifTrue: [ self readBackgroundImageAttribute: aCSSProperty propertyString of: aCSSProperty to: aContext ].
	aCSSProperty propertyName  = 'background-color'
		ifTrue: [ self readBackgroundColorAttribute: aCSSProperty propertyString to: aContext ].
	aCSSProperty propertyName = 'background-repeat'
		ifTrue: [ self readBackgroundRepeatAttribute: aCSSProperty propertyString to: aContext ].
	aCSSProperty propertyName = 'background-position'
		ifTrue: [ self readBackgroundPositionAttribute: aCSSProperty propertyString to: aContext ]
]

{ #category : 'parsing' }
CSSBackgroundFormatter >> readBackgroundAttribute: propertyValue of: aCSSProperty to: aContext [ 
	| shorthandContext positionValues |
	shorthandContext := Dictionary newFrom: {
		#backgroundRepeat -> #repeat.
		#backgroundImage -> nil.
		#backgroundColor -> Color transparent.
		#backgroundPosition -> (0@0).
	}.
	positionValues := OrderedCollection new.
	
	(propertyValue splitOn: ' ') doWithIndex: [:each :index |
		(each beginsWith: 'url') 
			ifTrue: [ self readBackgroundImageAttribute: each of: aCSSProperty to: shorthandContext ]
			ifFalse: [
		(self isValidRepeatValue: each) 
			ifTrue: [ self readBackgroundRepeatAttribute: each to: shorthandContext ]
			ifFalse: [
		(((positionValues size < 2) and: [ each asInteger notNil ]) and: [ each first ~= $#])
			ifTrue: [ positionValues add: each ]
			ifFalse: [
		(index = 1) 
			ifTrue: [self readBackgroundColorAttribute: each to: shorthandContext ]]]]].
	positionValues size = 2 ifTrue: [ 
		self readBackgroundPositionAttribute: positionValues first, ' ', 
			positionValues second to: shorthandContext ].
	
	aContext addAll: shorthandContext
]

{ #category : 'parsing' }
CSSBackgroundFormatter >> readBackgroundColorAttribute: propertyValue to: aContext [ 
	aContext at: #backgroundColor put: (Color fromHTMLString: propertyValue).
]

{ #category : 'parsing' }
CSSBackgroundFormatter >> readBackgroundImageAttribute: propertyValue of: aCSSProperty to: aContext [ 
	(propertyValue beginsWith: 'url')
		ifTrue: [ 
			| openBracketPosition closingBracketPosition urlString url |
			((propertyValue findString: 'data:image') ~= 0) ifTrue: [ ^ self ].
			openBracketPosition := propertyValue findString: '(' startingAt: 4.
			closingBracketPosition := propertyValue findLastOccurrenceOfString: ')' 
													   startingAt: openBracketPosition.

			openBracketPosition < closingBracketPosition ifFalse: [ ^ self ].

			urlString := (propertyValue copyFrom: openBracketPosition + 1 to: closingBracketPosition - 1) 
					trimBoth: [:char | (char isSeparator or: [char = $"]) or: [char = $']].
			url := urlString.
			aCSSProperty stylesheetDocument ifNotNil: [ :stylesheet | 
				"url := url asUrlRelativeTo: stylesheet absoluteUrl "
				url := stylesheet absoluteUrl asUrl / url asRelativeUrl 
			].
			aContext at: #backgroundImage put: url ]
]

{ #category : 'parsing' }
CSSBackgroundFormatter >> readBackgroundPositionAttribute: propertyValue to: aContext [
	| values position |
	values := propertyValue splitOn: ' '.
	position := 0@0.
	(self isNumber: values first) ifTrue: [position := position + ( values first asNumber @ 0)].
	values size > 1 ifTrue: [
		(self isNumber: values second) ifTrue: [position := position + ( 0 @ values second asNumber )]].
	
	aContext at: #backgroundPosition put: position
]

{ #category : 'parsing' }
CSSBackgroundFormatter >> readBackgroundRepeatAttribute: propertyString to: aContext [
	| values |
	values := Dictionary newFrom: {
		'no-repeat' -> #noRepeat.
		'repeat-x' -> #repeatX.
		'repeat-y' -> #repeatY.
		'repeat' -> #repeat
	}.
	values at: propertyString asLowercase
		ifPresent: [:value | aContext at: #backgroundRepeat put: value ]
]
