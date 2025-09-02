Class {
	#name : 'RadioButtonInput',
	#superclass : 'FormInput',
	#instVars : [
		'inputSet',
		'state',
		'value',
		'button'
	],
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'instance creation' }
RadioButtonInput class >> inputSet: anInputSet  value: aString [
	^self new inputSet: anInputSet  value: aString

]

{ #category : 'private-initialization' }
RadioButtonInput >> button: aMorph [
	button := aMorph
]

{ #category : 'private-initialization' }
RadioButtonInput >> inputSet: anInputSet  value: aString [
	inputSet := anInputSet.
	value := aString.
	state := false.
]

{ #category : 'button state' }
RadioButtonInput >> pressed [
	^state
]

{ #category : 'button state' }
RadioButtonInput >> pressed: aBoolean [
	state := aBoolean.
	self changed: #pressed.
	button ifNotNil: [button step].
	^true
]

{ #category : 'button state' }
RadioButtonInput >> toggle [
	"my button has been clicked on!"

	self pressed: self pressed not.
	inputSet  buttonToggled: self.
	^true
]

{ #category : 'access' }
RadioButtonInput >> valueIfPressed [
	^value
]
