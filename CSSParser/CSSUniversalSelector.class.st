Class {
	#name : #CSSUniversalSelector,
	#superclass : #CSSSelector,
	#instVars : [
		'selectors'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #'instance creation' }
CSSUniversalSelector class >> readFrom: in [

	in peek = $* ifTrue: [in next].
	^self new readAttributeSelectorsFrom: in
]

{ #category : #comparing }
CSSUniversalSelector >> = anObject [

	^self class = anObject class and: [self selectors = anObject selectors and:[self element = anObject element]]
]

{ #category : #accessing }
CSSUniversalSelector >> addSelector: aSelector [

	self selectors: (self selectors copyWith: aSelector) 
]

{ #category : #accessing }
CSSUniversalSelector >> classSelectors [

	^self selectors select:[:ea | ea isAttributeSelector and: [ea attribute asLowercase = 'class']]
]

{ #category : #accessing }
CSSUniversalSelector >> element [

	^nil
]

{ #category : #comparing }
CSSUniversalSelector >> hash [

	^(self class hash) + (self selectors hash) + (self element hash)
]

{ #category : #accessing }
CSSUniversalSelector >> idSelector [

	^self selectors detect:[:ea | ea isAttributeSelector and: [ea attribute asLowercase = 'id']] ifNone: [nil]
]

{ #category : #testing }
CSSUniversalSelector >> isCSS3 [

	^(self selectors detect:[:ea | ea isCSS3] ifNone: [nil]) notNil
]

{ #category : #testing }
CSSUniversalSelector >> isSimple [

	^true
]

{ #category : #testing }
CSSUniversalSelector >> isValid [

	^super isValid and: [(self selectors detect:[:ea | ea isValid not] ifNone: [nil]) isNil]
]

{ #category : #accessing }
CSSUniversalSelector >> keySelectors [

	^Array with: self
]

{ #category : #accessing }
CSSUniversalSelector >> matches: aNode [

	^(self selectors detect:[:ea | (ea matches: aNode) not] ifNone:[nil]) isNil
]

{ #category : #accessing }
CSSUniversalSelector >> printOn: aStream [

	aStream nextPut: $*.
	self selectors do: [:ea | ea printOn: aStream]
]

{ #category : #accessing }
CSSUniversalSelector >> readAttributeSelectorsFrom: in [

	| c |

	in skipSeparators.
	c := in peek.
	[c isNil or: [c isSeparator]] whileFalse:
	[
		c = $. ifTrue: [self addSelector: (CSSClassSelector readFrom: in)] ifFalse:[
		c = $# ifTrue: [self addSelector: (CSSIDSelector readFrom: in)] ifFalse:[
		c = $[ ifTrue: [self addSelector: (CSSAttributeSelector readFrom: in)] ifFalse:[
		c = $: ifTrue: [self addSelector: (CSSPseudoClassSelector readFrom: in)] ifFalse:[
		^self]]]].
		
		c := in peek.
	]
]

{ #category : #accessing }
CSSUniversalSelector >> selectors [
	"Answer the value of selectors"

	^ selectors isNil ifTrue: [#()] ifFalse: [selectors]
]

{ #category : #accessing }
CSSUniversalSelector >> selectors: anObject [
	"Set the value of selectors"

	selectors := anObject
]
