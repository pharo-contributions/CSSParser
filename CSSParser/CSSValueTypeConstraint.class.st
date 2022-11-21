Class {
	#name : #CSSValueTypeConstraint,
	#superclass : #CSSValueType,
	#instVars : [
		'type'
	],
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSValueTypeConstraint class >> allTypes [

	^self subclasses collect:[:ea | ea type]
]

{ #category : #'instance creation' }
CSSValueTypeConstraint class >> forType: aCharacter [

	^self subclasses detect: [:ea | ea type = aCharacter] 
		ifNone: [self error: ('Type not found ', (aCharacter asString))]
	
]

{ #category : #accessing }
CSSValueTypeConstraint class >> isSimple [

	^true
]

{ #category : #'instance creation' }
CSSValueTypeConstraint class >> readFrom: in [

	| cls |

	cls := self forType: in peek.
	^cls isSimple 
		ifTrue: [in next. cls new]
		ifFalse: [cls readFrom: in]
]

{ #category : #printing }
CSSValueTypeConstraint >> printOn: aStream [

	self type printOn: aStream.
	aStream nextPut: self class type
]

{ #category : #accessing }
CSSValueTypeConstraint >> type [
	"Answer the value of type"

	^ type
]

{ #category : #accessing }
CSSValueTypeConstraint >> type: anObject [
	"Set the value of type"

	type := anObject
]
