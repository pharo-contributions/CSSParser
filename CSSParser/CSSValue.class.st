Class {
	#name : 'CSSValue',
	#superclass : 'Object',
	#instVars : [
		'valueString'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSValue class >> forType: aType [

	^self allSubclasses detect: [:ea | ea type = aType] ifNone: [nil]
]

{ #category : 'instance creation' }
CSSValue class >> fromString: aString [
	
	^self readFrom: (ReadStream on: aString)

]

{ #category : 'instance creation' }
CSSValue class >> readFrom: in [

	| out seps |
	out := WriteStream on: String new.
	seps := (Character separators, ';,').
	in skipSeparators.
	[in atEnd or:[seps includes: in peek]] whileFalse: [out nextPut: in next].
	out contents trimBoth size < 1 ifTrue: [^nil].
	^self new valueString: out contents
]

{ #category : 'accessing' }
CSSValue class >> type [

	| s in out |
	s := self name.
	s := s last: s size - 'CSS' size.
	s := s first: s size - 'Value' size.
	out := WriteStream on: String new.
	in := ReadStream on: s.
	out nextPut: $<; nextPut: in next asLowercase.
	[in atEnd] whileFalse: 
	[
		in peek isUppercase ifTrue: [out nextPut: $-]. 
		out nextPut: in next asLowercase
	].
	out nextPut: $>.
	^out contents 
]

{ #category : 'accessing' }
CSSValue >> isProperty [

	^false
]

{ #category : 'accessing' }
CSSValue >> isValid [

	self subclassResponsibility
]

{ #category : 'accessing' }
CSSValue >> value [

	self subclassResponsibility
]

{ #category : 'accessing' }
CSSValue >> valueString [
	"Answer the value of valueString"

	^ valueString
]

{ #category : 'accessing' }
CSSValue >> valueString: anObject [
	"Set the value of valueString"

	valueString := anObject
]
