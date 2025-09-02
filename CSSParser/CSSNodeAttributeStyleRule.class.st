Class {
	#name : 'CSSNodeAttributeStyleRule',
	#superclass : 'CSSStyleRule',
	#instVars : [
		'content'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSNodeAttributeStyleRule >> content [

	^content
]

{ #category : 'accessing' }
CSSNodeAttributeStyleRule >> content: aString [

	content := '[style="',aString,'"]{',aString,'}'.
	self start: 1.
	self end: content size.
	self parseContents: (ReadStream on: content)
]

{ #category : 'accessing' }
CSSNodeAttributeStyleRule >> printOn: aStream [

	aStream nextPutAll: self content
]
