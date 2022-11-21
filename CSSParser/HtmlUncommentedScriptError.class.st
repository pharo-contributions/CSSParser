Class {
	#name : #HtmlUncommentedScriptError,
	#superclass : #HtmlSyntaxError,
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #testing }
HtmlUncommentedScriptError >> isStructuralError [

	^true
]

{ #category : #printing }
HtmlUncommentedScriptError >> printOn: aStream [

	'Script should be surrounded by html comments: <!-- script -->' printOn: aStream.
]
