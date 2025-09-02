Class {
	#name : 'HtmlDTDConstruct',
	#superclass : 'Object',
	#instVars : [
		'tag'
	],
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'instance creation' }
HtmlDTDConstruct class >> readExpression: in [

	| s |

	in skipSeparators.
	^in peek = $( ifTrue:
	[
		s := in upTo: $).
		(s,')',(in upTo: $ ))
	]
	ifFalse:
	[
		in upTo: $ .
	]
]

{ #category : 'accessing' }
HtmlDTDConstruct >> tag [
	"Answer the value of tag"

	^ tag
]

{ #category : 'accessing' }
HtmlDTDConstruct >> tag: anObject [
	"Set the value of tag"

	tag := HtmlDTDMatchExpression on: anObject trimBoth
]

{ #category : 'accessing' }
HtmlDTDConstruct >> tagMatches: anObject [

	^tag allowsItem: anObject
]
