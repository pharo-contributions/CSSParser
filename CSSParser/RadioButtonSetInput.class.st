Class {
	#name : 'RadioButtonSetInput',
	#superclass : 'FormInput',
	#instVars : [
		'name',
		'buttons',
		'defaultButton'
	],
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'instance creation' }
RadioButtonSetInput class >> name: aString [
	^self new name: aString
]

{ #category : 'input handling' }
RadioButtonSetInput >> active [
	"we are active if and only if one of our buttons is pressed"
	self name isNil
		ifTrue: [^false].
	buttons do: [ :b |
		b pressed ifTrue: [ ^true ] ].
	^false
]

{ #category : 'access' }
RadioButtonSetInput >> addInput: buttonInput [
	buttons add: buttonInput
]

{ #category : 'input handling' }
RadioButtonSetInput >> buttonToggled: aButton [
	"a button was toggled; turn all other buttons off"
	buttons do: [ :b |
		b == aButton ifFalse: [
			b pressed: false  ] ].
]

{ #category : 'access' }
RadioButtonSetInput >> defaultButton: aButton [
	"set which button to toggle on after a reset"
	defaultButton := aButton
]

{ #category : 'testing' }
RadioButtonSetInput >> isRadioButtonSetInput [
	^true
]

{ #category : 'access' }
RadioButtonSetInput >> name [
	^name
]

{ #category : 'private-initialization' }
RadioButtonSetInput >> name: aString [
	name := aString.
	buttons := OrderedCollection new.
]

{ #category : 'input handling' }
RadioButtonSetInput >> reset [
	buttons do: [ :b |
		b pressed: (b == defaultButton) ].

]

{ #category : 'input handling' }
RadioButtonSetInput >> value [
	buttons do: [ :b |
		b pressed ifTrue: [ ^b valueIfPressed ] ].
	self error: 'asked for value when inactive!'.
]
