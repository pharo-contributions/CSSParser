Class {
	#name : 'CSSAtImportRule',
	#superclass : 'CSSAtRule',
	#instVars : [
		'urlValue',
		'stylesheet'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'testing' }
CSSAtImportRule >> isAtImportRule [

	^true
]

{ #category : 'parsing' }
CSSAtImportRule >> parseContents: aStream [

	| s m |

	urlValue := CSSUriValue readFrom: aStream.	
	aStream skipSeparators.
	s := aStream upTo: $;.
	self end: aStream position.
	m := s findTokens: ', '.
	m size > 0 ifTrue: [self media: m].	

]

{ #category : 'accessing' }
CSSAtImportRule >> stylesheet [
	"Answer the value of styleSheet"

	stylesheet isNil ifTrue: [ stylesheet := CSSStyleSheet fromUrl: urlValue value parent: self].
	^stylesheet
]

{ #category : 'accessing' }
CSSAtImportRule >> stylesheet: anObject [
	"Set the value of styleSheet"

	stylesheet := anObject
]

{ #category : 'accessing' }
CSSAtImportRule >> urlValue [
	"Answer the value of urlValue"

	^ urlValue
]

{ #category : 'accessing' }
CSSAtImportRule >> urlValue: anObject [
	"Set the value of urlValue"

	urlValue := anObject
]
