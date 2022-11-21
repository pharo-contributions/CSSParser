Class {
	#name : #HtmlINPUTNode,
	#superclass : #HtmlDOMNode,
	#instVars : [
		'value'
	],
	#category : #'CSSParser-DOM'
}

{ #category : #rendering }
HtmlINPUTNode >> addCheckBoxButtonToFormatter: formatter [
	| name formData checked button buttonInput |

	"dig up relevant attributes"
	name := self attributes at: 'name' ifAbsent: [nil].
	name ifNil: [ ^self ].
	value := self attributes at: 'value' ifAbsent: [nil].
	value ifNil: [ ^value ].
	
	formData := self associatedForm.
	formData ifNil:  [ ^self ].

	checked := (self attributes at: 'checked' ifAbsent: [nil]) isNil not.

	"set up the form input"
	buttonInput := ToggleButtonInput name: name value: value checkedByDefault: checked.
	formData addInput: buttonInput.

	"create the actual button"
	button := UpdatingThreePhaseButtonMorph checkBox.
	button target: buttonInput;
		getSelector: #pressed;
		actionSelector: #toggle.
	buttonInput button: button.
	formatter addMorph: button.



]

{ #category : #rendering }
HtmlINPUTNode >> addFileInputToFormatter: formatter [
	"is it a submit button?"
	| inputMorph size fileInput |
	inputMorph := PluggableTextMorph on: StringHolder new text: #contents accept: #acceptContents:.
	size := (self attributes at: 'size' ifAbsent: ['12']) asNumber.
	inputMorph extent: (size*10@20).
	fileInput := FileInput name: self name textMorph: inputMorph.
	formatter addMorph: inputMorph;
		addMorph: ((PluggableButtonMorph on: fileInput getState: nil action: #browse)
				label: 'Browse').
	self associatedForm addInput: fileInput
]

{ #category : #rendering }
HtmlINPUTNode >> addImageButtonToFormatter: formatter [
	"is it a submit button?"
	| formData imageUrl morph |
	(imageUrl := self attributes at: 'src' ifAbsent: [nil]) ifNil: [^self].
	formatter baseUrl
		ifNotNil: [imageUrl := imageUrl asUrlRelativeTo: formatter baseUrl].

	morph := DownloadingImageMorph new.
	morph defaultExtent: self imageExtent.
	morph altText: self alt.
	morph url: imageUrl.

	value := self attributes at: 'name' ifAbsent: ['Submit'].
	formData := self associatedForm.
	morph
		on: #mouseUp
		send: #mouseUpFormData:event:linkMorph:
		to: self
		withValue: formData.
	formatter addIncompleteMorph: morph

]

{ #category : #rendering }
HtmlINPUTNode >> addRadioButtonToFormatter: formatter [
	| name formData checked buttonSet button buttonInput |

	"dig up relevant attributes"
	name := self attributes at: 'name' ifAbsent: [nil].
	name ifNil: [ ^self ].
	value := self attributes at: 'value' ifAbsent: [nil].
	value ifNil: [ ^value ].
	
	formData := self associatedForm.
	formData ifNil:  [ ^self ].

	checked := self attributes at: 'checked' ifAbsent: [nil].


	"find or create the set of buttons with our same name"
	buttonSet := formData inputs detect: [ :i | i isRadioButtonSetInput and: [ i name = name ] ] ifNone: [ nil ].
	buttonSet ifNil: [ 
		"create a new button set"
		buttonSet := RadioButtonSetInput name: name.
		formData addInput: buttonSet. ].

	"set up the form input"
	buttonInput := RadioButtonInput  inputSet: buttonSet value: value.
	buttonSet addInput: buttonInput.
	checked ifNotNil: [
		buttonSet  defaultButton: buttonInput ].

	"create the actual button"
	button := UpdatingThreePhaseButtonMorph radioButton.
	button target: buttonInput;
		getSelector: #pressed;
		actionSelector: #toggle.
	buttonInput button: button.
	formatter addMorph: button.



]

{ #category : #rendering }
HtmlINPUTNode >> addTextInputToFormatter: formatter [
	"is it a submit button?"
	| inputMorph size |
	inputMorph := PluggableTextMorphSubmitOnEnter on: StringHolder new text: #contents accept: #acceptContents: acceptTarget: self associatedForm acceptAction: #submitAsync.
	self type = 'password'
		ifTrue: [inputMorph font: (StrikeFont passwordFontSize: 12)].
	size := (self attributes at: 'size' ifAbsent: ['12']) asNumber.
	inputMorph extent: (size*10@20).
	formatter addMorph: inputMorph.
	self associatedForm addInput:
		(TextInput name: self name defaultValue: self defaultValue  textMorph: inputMorph).
]

{ #category : #rendering }
HtmlINPUTNode >> addToFormatter: formatter [
	| form |
	form := self associatedForm.
	form ifNil: [
		"not in a form.  It's bogus HTML but try to survive"
		^self ].

	"is it a submit button?"
	self type = 'submit' ifTrue: [
		formatter addMorph: ((PluggableButtonMorph on: form getState: nil action: #submitAsync) label: (self attributes at: 'value' ifAbsent: ['Submit'])).
		^self ].

	self type = 'image'
		ifTrue: [^self addImageButtonToFormatter: formatter].

	(self type = 'text' or: [self type = 'password'] or: [self type = 'search'])
		ifTrue: [^self addTextInputToFormatter: formatter].

	self type = 'hidden' ifTrue: [
		form addInput: (HiddenInput name: self name  value: self defaultValue).
		^self ].

	self type = 'radio' ifTrue: [ 
		^self addRadioButtonToFormatter: formatter ].

	self type = 'checkbox' ifTrue: [ 
		^self addCheckBoxButtonToFormatter: formatter ].

	self type = 'file' ifTrue: [ 
		^self addFileInputToFormatter: formatter ].

	formatter addString: '[form input of type: ', self type, ']'.
]

{ #category : #accessing }
HtmlINPUTNode >> alt [
	(self type = 'image')
		ifTrue: [^self attributes at: 'alt' ifAbsent: ['[image]']]
		ifFalse: [^self attributes at: 'alt' ifAbsent: ['']]
]

{ #category : #accessing }
HtmlINPUTNode >> defaultValue [
	^(self attributes at: 'value' ifAbsent: ['']) asUnHtml
]

{ #category : #accessing }
HtmlINPUTNode >> imageExtent [
	"the image extent, according to the WIDTH and HEIGHT attributes.  returns nil if either WIDTH or HEIGHT is not specified"
	| widthText heightText |
	widthText := self attributes at: 'width' ifAbsent: [ ^nil ].
	heightText := self attributes at: 'height' ifAbsent: [ ^nil ].
	^ widthText asNumber @ heightText asNumber
]

{ #category : #events }
HtmlINPUTNode >> mouseUpEvent: arg1 linkMorph: arg2 formData: arg3 [
	"Reorder the arguments for existing event handlers"
	(arg3 isMorph and:[arg3 eventHandler notNil]) ifTrue:[arg3 eventHandler fixReversedValueMessages].
	^self mouseUpFormData: arg1 event: arg2 linkMorph: arg3
]

{ #category : #events }
HtmlINPUTNode >> mouseUpFormData: formData event: event linkMorph: linkMorph [
	| aPoint |
	aPoint := event cursorPoint - linkMorph topLeft.
	formData addInput: (HiddenInput name: (value, '.x') value: aPoint x asInteger asString).
	formData addInput: (HiddenInput name: (value, '.y') value: aPoint y asInteger asString).
	formData submitAsync
]

{ #category : #testing }
HtmlINPUTNode >> name [
	^self attributes at: 'name' ifAbsent: [nil]
]

{ #category : #accessing }
HtmlINPUTNode >> tag [
	^ 'input'
]

{ #category : #accessing }
HtmlINPUTNode >> type [
	^(self attributes at:'type' ifAbsent: ['text']) asLowercase
]
