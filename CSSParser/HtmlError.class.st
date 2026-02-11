Class {
	#name : 'HtmlError',
	#superclass : 'Object',
	#instVars : [
		'parent'
	],
	#category : 'CSSParser-DOM-Errors',
	#package : 'CSSParser',
	#tag : 'DOM-Errors'
}

{ #category : 'testing' }
HtmlError >> isAttributeError [

	^false
]

{ #category : 'testing' }
HtmlError >> isCSSError [

	^false
]

{ #category : 'testing' }
HtmlError >> isCaseError [

	^false
]

{ #category : 'testing' }
HtmlError >> isFatal [

	^false
]

{ #category : 'testing' }
HtmlError >> isStructuralError [

	^false
]

{ #category : 'testing' }
HtmlError >> isSyntaxError [

	^false
]

{ #category : 'testing' }
HtmlError >> isTagError [

	^false
]

{ #category : 'accessing' }
HtmlError >> parent [
	"Answer the value of parent"

	^ parent isNil ifTrue: [nil] ifFalse: [parent first]
]

{ #category : 'accessing' }
HtmlError >> parent: anObject [
	"Set the value of parent"

	parent := WeakArray with: anObject
]

{ #category : 'accessing' }
HtmlError >> position [

	^self parent start
]

{ #category : 'printing' }
HtmlError >> printOn: aStream [

	self class printOn: aStream. 
	aStream nextPutAll: ': Character: '.
	self position printOn: aStream.
	aStream space.
]

{ #category : 'accessing' }
HtmlError >> tag [

	^self parent tag
]

{ #category : 'accessing' }
HtmlError >> title [

	| tt |
	tt := self class name. 
	^(tt last: tt size - 4) asUppercase 
	
]

{ #category : 'testing' }
HtmlError >> uniqueId [

	^self parent uniqueId
]
