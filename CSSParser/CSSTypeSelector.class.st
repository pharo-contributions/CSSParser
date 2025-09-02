Class {
	#name : 'CSSTypeSelector',
	#superclass : 'CSSUniversalSelector',
	#instVars : [
		'element'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSTypeSelector class >> readFrom: in [

	| out |
	out := WriteStream on: String new.
	(in atEnd not and: [in peek isLetter]) ifTrue: 
	[
		out nextPut: in next.
		[in atEnd not and: [in peek isLetter or: [in peek isDigit or:['-_' includes: in peek]]]] 
			whileTrue:[out nextPut: in next].
	]
	ifFalse: [self halt].
	^self new element: out contents; readAttributeSelectorsFrom: in
]

{ #category : 'accessing' }
CSSTypeSelector >> element [
	"Answer the value of element"

	^ element
]

{ #category : 'accessing' }
CSSTypeSelector >> element: anObject [
	"Set the value of element"

	element := anObject
]

{ #category : 'testing' }
CSSTypeSelector >> isTypeSelector [

	^true
]

{ #category : 'accessing' }
CSSTypeSelector >> matches: aNode [

	aNode isCSS ifTrue: [^false].
	^(aNode dtd isXML 
		ifTrue:[element = aNode tag] 
		ifFalse: [element asLowercase = aNode tag]) and: [super matches: aNode]
]

{ #category : 'accessing' }
CSSTypeSelector >> printOn: aStream [

	aStream nextPutAll: self element.
	self selectors do:[:ea | ea printOn: aStream]
]
