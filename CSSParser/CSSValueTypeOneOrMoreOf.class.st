Class {
	#name : 'CSSValueTypeOneOrMoreOf',
	#superclass : 'CSSValueTypeConstraint',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSValueTypeOneOrMoreOf class >> type [

	^$+
]

{ #category : 'testing' }
CSSValueTypeOneOrMoreOf >> addValues: aCollection fromStream: in [

	| one pos |
	one := false.
	[
		pos := in position.
		type addValues: aCollection fromStream: in
	] whileTrue: [one := true].
	in position: pos.
	^one
]
