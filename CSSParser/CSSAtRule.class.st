Class {
	#name : 'CSSAtRule',
	#superclass : 'CSSRule',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSAtRule class >> named: aString [

	| out cls |

	out := WriteStream on: String new.
	out nextPutAll: 'CSSAt'.
	out nextPut: aString first asUppercase.
	out nextPutAll: (aString last: aString size -1).
	out nextPutAll: 'Rule'.

	cls := Smalltalk at: out contents asSymbol ifAbsent:[nil].
	
	cls ifNil: [^CSSAtIgnoreRule new].
	^cls new
]

{ #category : 'parsing' }
CSSAtRule >> parseContents: aStream [

	| s |

	s := aStream upTo: $;.
	(s includes: ${) ifTrue: [aStream position: self start. aStream upTo: $}].
	self end: aStream position.
	
]
