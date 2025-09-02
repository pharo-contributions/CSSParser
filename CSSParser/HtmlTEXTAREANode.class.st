Class {
	#name : 'HtmlTEXTAREANode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlTEXTAREANode >> addToFormatter: formatter [
	| inputMorph |
	self associatedForm ifNil: [
		"not in a form.  It's bogus HTML but try to survive"
		^self ].

	formatter ensureNewlines: 1.
	inputMorph := PluggableTextMorph on: StringHolder new text: #contents accept: #acceptContents:.
	inputMorph extent: (self columns * 5) @ (self rows * inputMorph scrollDeltaHeight).
	inputMorph retractable: false.
	formatter addMorph: inputMorph.
	self associatedForm addInput: (TextInput name: self name  defaultValue:  self innerContents  textMorph: inputMorph).
	formatter ensureNewlines: 1.
]

{ #category : 'accessing' }
HtmlTEXTAREANode >> columns [
	| a |
	a := self attributes at: 'cols' ifAbsent: ['20'].
	^(Integer readFrom: (ReadStream on: a)) max: 5
]

{ #category : 'testing' }
HtmlTEXTAREANode >> name [
	^self attributes at: 'name' ifAbsent: [nil]
]

{ #category : 'accessing' }
HtmlTEXTAREANode >> rows [
	| a |
	a := self attributes at: 'rows' ifAbsent: ['2'].
	^(Integer readFrom: (ReadStream on: a)) max: 1
]

{ #category : 'accessing' }
HtmlTEXTAREANode >> tag [
	^ 'textarea'
]
