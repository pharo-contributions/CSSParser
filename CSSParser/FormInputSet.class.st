"
Holds the inputs for an instance of an HTML Form.  It has a link to the browser it will be displayed in, and it has a link to each of the input PluggableTextMorph's that it input will read from.

inputs - maps HtmlInput's into the text morphs which will input their value.
"
Class {
	#name : 'FormInputSet',
	#superclass : 'Model',
	#instVars : [
		'inputs',
		'browser',
		'form',
		'htmlMorph'
	],
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'instance creation' }
FormInputSet class >> forForm: form [
	"create a FormData for the given form"
	^self new form: form
]

{ #category : 'instance creation' }
FormInputSet class >> forForm: form  andBrowser: browser [
	"create a FormData for the given form and browser"
	^super new form: form  browser: browser
]

{ #category : 'adding inputs' }
FormInputSet >> addInput: anInput [
	inputs add: anInput
]

{ #category : 'accessing' }
FormInputSet >> browser [

	"get the browser object TextURL-style"

	htmlMorph ifNotNil: [ :m | 
		[ m ~= nil ] whileTrue: [ 
			(m hasProperty: #webBrowserView) ifTrue: [ ^ m model ].
			m owner ] ].
	^ nil
]

{ #category : 'accessing' }
FormInputSet >> form: aForm [
	form := aForm
]

{ #category : 'private-initialization' }
FormInputSet >> form: f  browser: b [
	inputs := OrderedCollection new.
	form := f.
	browser := b.
]

{ #category : 'initialize-release' }
FormInputSet >> initialize [ 
	super initialize.
	inputs := OrderedCollection new.
]

{ #category : 'adding inputs' }
FormInputSet >> inputs [
	"return a list of the list of inputs"
	^inputs
]

{ #category : 'accessing' }
FormInputSet >> morph: aHtmlMorph [
	htmlMorph := aHtmlMorph
]

{ #category : 'action' }
FormInputSet >> reset [
	"reset all inputs to their default value"
	inputs do: [ :input | input reset ]
]

{ #category : 'action' }
FormInputSet >> submitAsync [
	"collect inputs and instruct the browser to do a submission"
	| inputValues |
	inputValues := Dictionary new.
	inputs do: [ :input |
		input active ifTrue: [
			(inputValues includesKey: input name) ifFalse: [
				inputValues at: input name  put: (OrderedCollection new: 1) ].
			(inputValues at: input name)  add: input value ] ].
	"we need to have a OrderedCollection for each input key in order to complay with HTTPSocket interface"
	^ self browser submitFormWithInputsAsync: inputValues url: form url
		method: form method encoding: form encoding
]
