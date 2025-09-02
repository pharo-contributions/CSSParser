Class {
	#name : 'HtmlDTDElement',
	#superclass : 'HtmlDTDConstruct',
	#instVars : [
		'dtd',
		'startIsOptional',
		'endIsOptional',
		'contentRule',
		'allowedElements'
	],
	#category : 'CSSParser-Validator',
	#package : 'CSSParser',
	#tag : 'Validator'
}

{ #category : 'instance creation' }
HtmlDTDElement class >> fromParsedString: aString [

	| in tag start end contents |

	in := ReadStream on: aString.

	tag := self readExpression: in.
	start := self readExpression: in.
	end := self readExpression: in.
	contents := in upToEnd trimBoth.

	^self new tag: tag;
		startIsOptional: start;
		endIsOptional: end;
		contentRule: contents		
]

{ #category : 'accessing' }
HtmlDTDElement >> allowsTag: aTag [

	^contentRule allowsItem: aTag
]

{ #category : 'accessing' }
HtmlDTDElement >> cacheAllowedElementsForDTD: aDTD [

	| |

	allowedElements isNil ifTrue:
	[
		allowedElements := Set new.

		allowedElements addAll: self contentRule allowedElements.

		allowedElements copy do: 
		[:ea | 
			ea isLiteral ifTrue: 
			[
				| el |
				el := aDTD elementForTag: ea expression.
				el startIsOptional ifTrue:
					[allowedElements addAll: (el cacheAllowedElementsForDTD: aDTD)]
			]
		]
	].

	^allowedElements
]

{ #category : 'accessing' }
HtmlDTDElement >> contentRule [
	"Answer the value of contentRule"

	^ contentRule
]

{ #category : 'accessing' }
HtmlDTDElement >> contentRule: anObject [
	"Set the value of contentRule"

	contentRule := HtmlDTDMatchExpression on: anObject
]

{ #category : 'accessing' }
HtmlDTDElement >> endIsOptional [
	"Answer the value of endIsOptional"

	^ endIsOptional first = $O
]

{ #category : 'accessing' }
HtmlDTDElement >> endIsOptional: anObject [
	"Set the value of endIsOptional"

	endIsOptional := anObject
]

{ #category : 'accessing' }
HtmlDTDElement >> isEmpty [

	^contentRule isEmpty
]

{ #category : 'accessing' }
HtmlDTDElement >> printOn: aStream [

	aStream nextPutAll: 'E('.
	tag printOn: aStream.
	aStream space; 
	nextPutAll: startIsOptional; space;
	nextPutAll: endIsOptional; space.
	contentRule printOn: aStream.
	aStream nextPut: $)
]

{ #category : 'accessing' }
HtmlDTDElement >> startIsOptional [
	"Answer the value of startIsOptional"

	^ startIsOptional first = $O
]

{ #category : 'accessing' }
HtmlDTDElement >> startIsOptional: anObject [
	"Set the value of startIsOptional"

	startIsOptional := anObject
]
