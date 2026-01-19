Class {
	#name : 'CSSError',
	#superclass : 'HtmlError',
	#category : 'CSSParser-CSS-Errors',
	#package : 'CSSParser',
	#tag : 'CSS-Errors'
}

{ #category : 'testing' }
CSSError >> isCSSError [

	^true
]

{ #category : 'printing' }
CSSError >> printOn: aStream [

	super printOn: aStream.

]

{ #category : 'accessing' }
CSSError >> title [

	| tt |
	tt := self class name. 
	^(tt last: tt size - 3) asUppercase 
	
]
