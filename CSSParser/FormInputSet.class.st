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
		'form'
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
FormInputSet >> form: aForm [
	form := aForm
]

{ #category : 'private-initialization' }
FormInputSet >> form: f  browser: b [
	inputs := OrderedCollection new.
	form := f.
	browser := b.
]

{ #category : 'initialization' }
FormInputSet >> initialize [ 
	super initialize.
	inputs := OrderedCollection new.
]

{ #category : 'adding inputs' }
FormInputSet >> inputs [
	"return a list of the list of inputs"
	^inputs
]

{ #category : 'action' }
FormInputSet >> reset [
	"reset all inputs to their default value"
	inputs do: [ :input | input reset ]
]
