Class {
	#name : 'CSSRelationshipSelector',
	#superclass : 'CSSSelector',
	#instVars : [
		'selectors'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSRelationshipSelector class >> operator [

	self subclassResponsibility
]

{ #category : 'accessing' }
CSSRelationshipSelector class >> operators [

	| out |
	out := WriteStream on: String new.
	self subclasses do:[:ea | out nextPutAll: ea operator].
	^out contents
]

{ #category : 'instance creation' }
CSSRelationshipSelector class >> selectorForOperator: aString [

	^(self subclasses detect:[:ea | ea operator = aString] ifNone: [CSSDescendantSelector]) new
]

{ #category : 'comparing' }
CSSRelationshipSelector >> = anObject [

	^ self class = anObject class and: [self selectors = anObject selectors]
]

{ #category : 'accessing' }
CSSRelationshipSelector >> addSelector: aSelector [

	self selectors: (self selectors copyWith: aSelector)
]

{ #category : 'comparing' }
CSSRelationshipSelector >> hash [

	^(self class hash) + (selectors hash)
]

{ #category : 'accessing' }
CSSRelationshipSelector >> isCSS3 [

	^(self selectors detect:[:ea | ea isCSS3] ifNone: [nil]) notNil
]

{ #category : 'testing' }
CSSRelationshipSelector >> isRelationshipSelector [

	^true
]

{ #category : 'accessing' }
CSSRelationshipSelector >> isValid [

	^super isValid and: [(self selectors detect:[:ea | ea isValid not] ifNone: [nil]) isNil]
]

{ #category : 'accessing' }
CSSRelationshipSelector >> keySelectors [

	^self selectors last keySelectors
]

{ #category : 'accessing' }
CSSRelationshipSelector >> operator [

	^self class operator
]

{ #category : 'accessing' }
CSSRelationshipSelector >> printOn: aStream [

	selectors do:
	[:ea | 
		ea printOn: aStream. 
		ea == selectors last 
			ifFalse: [aStream nextPutAll: self operator]
	]
]

{ #category : 'accessing' }
CSSRelationshipSelector >> removeLastSelector [

	| last |
	last := selectors last.
	self selectors: (selectors first: (selectors size-1)).
	^last
]

{ #category : 'accessing' }
CSSRelationshipSelector >> selectors [
	"Answer the value of selectors"

	^ selectors isNil ifTrue:[#()] ifFalse: [selectors]
]

{ #category : 'accessing' }
CSSRelationshipSelector >> selectors: anObject [
	"Set the value of selectors"

	selectors := anObject
]

{ #category : 'accessing' }
CSSRelationshipSelector >> selectorsMatching: aBlock [

	| col |
	col := OrderedCollection new.

	(aBlock value: self) ifTrue: [col add: self].
	self selectors do: [:ea | col addAll: (ea selectorsMatching: aBlock)].
	^col asArray
]
