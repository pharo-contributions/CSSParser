"
an input from a toggle button
"
Class {
	#name : 'ToggleButtonInput',
	#superclass : 'FormInput',
	#instVars : [
		'button',
		'name',
		'value',
		'state',
		'checkedByDefault'
	],
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'instance creation' }
ToggleButtonInput class >> name: aName value: aValue checkedByDefault: aFlag [
	^ self new name: aName value: aValue checkedByDefault: aFlag
]

{ #category : 'input handling' }
ToggleButtonInput >> active [
	^self name isNil not and: [state]
]

{ #category : 'private-initialize' }
ToggleButtonInput >> button: aButtonMorph [
	button := aButtonMorph
]

{ #category : 'accessing' }
ToggleButtonInput >> name [
	^name
]

{ #category : 'private-initialize' }
ToggleButtonInput >> name: aName value: aValue checkedByDefault: aFlag [
	name := aName.
	value := aValue.
	checkedByDefault := aFlag.
	state := checkedByDefault
]

{ #category : 'button state' }
ToggleButtonInput >> pressed [
	^state
]

{ #category : 'button state' }
ToggleButtonInput >> pressed: aBoolean [
	state := aBoolean.
	self changed: #pressed.
	button ifNotNil: [button step].
	^true
]

{ #category : 'button state' }
ToggleButtonInput >> toggle [
	"my button has been clicked on!"

	self pressed: self pressed not.
	^true
]

{ #category : 'accessing' }
ToggleButtonInput >> value [
	^value
]
