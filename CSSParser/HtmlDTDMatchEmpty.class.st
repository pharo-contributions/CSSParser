Class {
	#name : #HtmlDTDMatchEmpty,
	#superclass : #HtmlDTDMatchExpression,
	#classVars : [
		'Empty'
	],
	#category : #'CSSParser-Validator'
}

{ #category : #accessing }
HtmlDTDMatchEmpty class >> empty [

	^Empty isNil ifTrue: [Empty := self new] ifFalse: [Empty]
]

{ #category : #accessing }
HtmlDTDMatchEmpty >> allowedElements [

	^#()
]

{ #category : #matching }
HtmlDTDMatchEmpty >> allowsItem: aTag [

	^false
]

{ #category : #'initialize-release' }
HtmlDTDMatchEmpty >> initialize [

	super initialize.
	expression := 'EMPTY'
]

{ #category : #accessing }
HtmlDTDMatchEmpty >> isEmpty [

	^true
]

{ #category : #printing }
HtmlDTDMatchEmpty >> printOn: aStream [

	aStream nextPutAll: 'EMPTY'
]

{ #category : #matching }
HtmlDTDMatchEmpty >> validateChildren: aStream ofNode: aNode [

	^(aStream atEnd) 
		ifTrue: [true] 
		ifFalse:
		[
			aNode addError: (HtmlTagMustBeEmptyError new).
			false
		]

]
