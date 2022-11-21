Class {
	#name : #HtmlUnclosedProcessingDirectiveError,
	#superclass : #HtmlSyntaxError,
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #testing }
HtmlUnclosedProcessingDirectiveError >> isStructuralError [

	^true
]

{ #category : #testing }
HtmlUnclosedProcessingDirectiveError >> printOn: aStream [

	aStream nextPutAll: 'Processing directive not properly terminated.'
]
