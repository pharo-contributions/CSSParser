Class {
	#name : 'CSSPseudoClassSelector',
	#superclass : 'CSSSelector',
	#instVars : [
		'pseudoClassName',
		'arguments'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSPseudoClassSelector class >> readFrom: in [

	| cls obj out |
	in next = $: ifFalse: [self halt].
	out := WriteStream on: String new.
	"out nextPutAll: 'CSS'."
	out nextPut: in next asUppercase.
	[in peek notNil and: [in peek isLetter or: [in peek = $-]]] whileTrue: 
	[
		in peek = $- 
			ifTrue: [in next. out nextPut: in next asUppercase] 
			ifFalse: [out nextPut: in next]
	].
	"out nextPutAll: 'Selector'."

	cls := (Smalltalk at: ('CSS',(out contents),'Selector') asSymbol ifAbsent: [self]).
	cls = self ifTrue: [obj := cls new pseudoClassName: out contents] ifFalse: [obj := cls new].
	in skipSeparators.
	in peek = $( ifTrue:[ in next. obj arguments: (in upTo: $) )].
	^obj
]

{ #category : 'accessing' }
CSSPseudoClassSelector >> arguments [
	"Answer the value of arguments"

	^ arguments
]

{ #category : 'accessing' }
CSSPseudoClassSelector >> arguments: anObject [
	"Set the value of arguments"

	arguments := anObject
]

{ #category : 'testing' }
CSSPseudoClassSelector >> matches: aNode [

	^false
]

{ #category : 'accessing' }
CSSPseudoClassSelector >> printOn: aStream [

	| s |

	s := self pseudoClassName asString.
	aStream nextPut: $: ; nextPutAll: s asLowercase
]

{ #category : 'accessing' }
CSSPseudoClassSelector >> pseudoClassName [
	"Answer the value of pseudoClassName"

	^ pseudoClassName isNil 
		ifFalse: [pseudoClassName] 
		ifTrue: 
		[
			| nm in out |
			nm := self class name asString.
			nm := nm last: (nm size - ('CSS' size)).
			nm := nm first: (nm size - ('Selector' size)).
			out := WriteStream on: (String new: nm size *2).
			in := ReadStream on: nm.
			out nextPut: in next asLowercase.
			[in atEnd] whileFalse:
			[
				in peek isUppercase 
					ifTrue: [out nextPut: $-. out nextPut: in next asLowercase]
					ifFalse:[out nextPut: in next].
			].
			out contents
		]
]

{ #category : 'accessing' }
CSSPseudoClassSelector >> pseudoClassName: anObject [
	"Set the value of pseudoClassName"

	pseudoClassName := anObject
]
