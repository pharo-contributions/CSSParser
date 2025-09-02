Class {
	#name : 'HtmlTagImproperlyNestedError',
	#superclass : 'HtmlTagStructureError',
	#instVars : [
		'wrongTag'
	],
	#category : 'CSSParser-DOM-Errors',
	#package : 'CSSParser',
	#tag : 'DOM-Errors'
}

{ #category : 'printing' }
HtmlTagImproperlyNestedError >> printOn: aStream [

	| rule |

	self parent tag printOn: aStream.
	aStream nextPutAll: ' found within tag: '.
	self parent parent tag printOn: aStream.

	rule := (self parent dtd elementForTag: self parent parent dtdTag).
	rule notNil ifTrue:
	[
		aStream nextPutAll: '. Tag Rule: '.
		rule contentRule printOn: aStream.
	]
	
]

{ #category : 'accessing' }
HtmlTagImproperlyNestedError >> wrongTag [
	"Answer the value of wrongTag"

	^ wrongTag
]

{ #category : 'accessing' }
HtmlTagImproperlyNestedError >> wrongTag: anObject [
	"Set the value of wrongTag"

	wrongTag := anObject
]
