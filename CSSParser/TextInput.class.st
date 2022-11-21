"
a textual input; it takes text input straight from the user via a PluggableText
"
Class {
	#name : #TextInput,
	#superclass : #FormInput,
	#instVars : [
		'name',
		'defaultValue',
		'textMorph'
	],
	#category : #'CSSParser-Forms'
}

{ #category : #'instance creation' }
TextInput class >> name: name0  defaultValue: defaultValue  textMorph: textMorph [
	^self new name: name0  defaultValue: defaultValue  textMorph: textMorph
	
]

{ #category : #'input handling' }
TextInput >> name [
	^name
]

{ #category : #'private-initialization' }
TextInput >> name: name0  defaultValue: defaultValue0  textMorph: textMorph0 [
	name := name0.
	defaultValue := defaultValue0.
	textMorph := textMorph0.
]

{ #category : #'input handling' }
TextInput >> reset [
	textMorph setText: defaultValue.
	"UO 6/23/2003 - We have to set the model also. setText: is not doing that"
	textMorph model contents: defaultValue
]

{ #category : #'input handling' }
TextInput >> value [
	textMorph hasUnacceptedEdits ifTrue: [ textMorph accept ].
	^textMorph getText asString withInternetLineEndings
]
