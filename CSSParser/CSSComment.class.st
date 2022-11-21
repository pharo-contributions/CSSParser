Class {
	#name : #CSSComment,
	#superclass : #CSSElement,
	#category : #'CSSParser-CSS'
}

{ #category : #testing }
CSSComment >> isAtImportRule [

	^false
]

{ #category : #parsing }
CSSComment >> parseContents: aStream [

	aStream skip: 2.
	[aStream atEnd] whileFalse:
	[
		(aStream peek = $* and: [aStream next. aStream peek = $/]) ifTrue:
		[
			aStream next.
			^self end: aStream position
		]
		ifFalse:
		[
			aStream next = $\ ifTrue: [aStream next].
		]
	].
	self end: aStream position.
]

{ #category : #accessing }
CSSComment >> tag [

	^'comment'
]
