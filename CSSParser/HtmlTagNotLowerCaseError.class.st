Class {
	#name : #HtmlTagNotLowerCaseError,
	#superclass : #HtmlError,
	#instVars : [
		'tag'
	],
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #testing }
HtmlTagNotLowerCaseError >> isCaseError [

	^true
]

{ #category : #printing }
HtmlTagNotLowerCaseError >> printOn: aStream [

	self parent rawTag printOn: aStream.
	aStream nextPutAll: ' should probably be '.
	self parent tag printOn: aStream.
]

{ #category : #accessing }
HtmlTagNotLowerCaseError >> tag [
	"Answer the value of tag"

	^ tag
]

{ #category : #accessing }
HtmlTagNotLowerCaseError >> tag: anObject [
	"Set the value of tag"

	tag := anObject
]
