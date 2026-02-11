Class {
	#name : 'HtmlTEXTAREANode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

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
