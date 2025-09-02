Class {
	#name : 'HtmlTagMissingStartError',
	#superclass : 'HtmlTagStructureError',
	#instVars : [
		'position',
		'tag'
	],
	#category : 'CSSParser-DOM-Errors',
	#package : 'CSSParser',
	#tag : 'DOM-Errors'
}

{ #category : 'testing' }
HtmlTagMissingStartError >> isStructuralError [

	^true
]

{ #category : 'accessing' }
HtmlTagMissingStartError >> position [
	"Answer the value of position"

	^ position
]

{ #category : 'accessing' }
HtmlTagMissingStartError >> position: anObject [
	"Set the value of position"

	position := anObject.
	"self halt."


]

{ #category : 'accessing' }
HtmlTagMissingStartError >> printOn: aStream [

	aStream nextPutAll: 'Closing tag: '.
	self tag printOn: aStream.
	aStream nextPutAll: ' with no start found'
]

{ #category : 'accessing' }
HtmlTagMissingStartError >> tag [
	"Answer the value of tag"

	^ tag
]

{ #category : 'accessing' }
HtmlTagMissingStartError >> tag: anObject [
	"Set the value of tag"

	tag := anObject
]

{ #category : 'accessing' }
HtmlTagMissingStartError >> uniqueId [

	^super uniqueId, '-end'
]
