"
a stream on Text's which keeps track of the last attribute put; new characters are added with those attributes.

instance vars:

	characters - a WriteStream of the characters in the stream
	attributeRuns - a RunArray with the attributes for the stream
	currentAttributes - the attributes to be used for new text
	attributesChanged - whether the attributes have changed since the last addition
"
Class {
	#name : #AttributedTextStream,
	#superclass : #Stream,
	#instVars : [
		'characters',
		'attributeRuns',
		'attributeValues',
		'currentAttributes',
		'currentRun'
	],
	#category : #'CSSParser-Formatter'
}

{ #category : #'instance creation' }
AttributedTextStream class >> new [	
	^ self basicNew initialize
]

{ #category : #'instance creation' }
AttributedTextStream class >> new: n [
	
	^self basicNew 
		initialize: n;
		yourself
]

{ #category : #accessing }
AttributedTextStream >> contents [	
	| ans |	
	currentRun > 0 ifTrue:[		
		attributeValues nextPut: currentAttributes.		
		attributeRuns nextPut: currentRun.		
		currentRun := 0].	
	ans := Text string: characters contents  runs: 		
			(RunArray runs: 
				attributeRuns contents values: 
					attributeValues contents).	
	^ans
]

{ #category : #'character writing' }
AttributedTextStream >> cr [
	"Append a carriage return character to the receiver."

	self nextPut: Character cr
]

{ #category : #'character writing' }
AttributedTextStream >> crlf [
	"Append a carriage return and a line feed to the receiver."

	self nextPut: Character cr; nextPut: Character lf
]

{ #category : #accessing }
AttributedTextStream >> currentAttributes [	
	^ currentAttributes
]

{ #category : #accessing }
AttributedTextStream >> currentAttributes: newAttributes [
	"set the current attributes"	
	(currentRun > 0 and:[currentAttributes ~= newAttributes]) ifTrue:[		
		attributeRuns nextPut: currentRun.	
		attributeValues nextPut: currentAttributes.
		currentRun := 0.	].	
	currentAttributes := newAttributes.
]

{ #category : #initialization }
AttributedTextStream >> initialize [	
	characters := WriteStream on: String new.	
	currentAttributes := OrderedCollection new.	
	currentRun := 0.	
	attributeValues := WriteStream on: (Array new: 50).	
	attributeRuns := WriteStream on: (Array new: 50).	
]

{ #category : #'initialize-release' }
AttributedTextStream >> initialize: n [

	super initialize.
	characters := (String new: n) writeStream.
	currentAttributes := #().
	currentRun := 0.
	attributeValues := (Array new: (n min: 10)) writeStream.
	attributeRuns := (Array new: (n min: 10)) writeStream
]

{ #category : #'character writing' }
AttributedTextStream >> lf [
	"Append a line feed character to the receiver."

	self nextPut: Character lf
]

{ #category : #accessing }
AttributedTextStream >> next: anInteger putAll: aString startingAt: startIndex [

	"add an entire string with the same attributes"
	anInteger > 0 ifFalse: [ ^aString ].
	currentRun := currentRun + anInteger.
	^characters 
		next: anInteger
		putAll: aString
		startingAt: startIndex
]

{ #category : #accessing }
AttributedTextStream >> nextPut: aChar [	
	currentRun := currentRun + 1.	
	characters nextPut: aChar
]

{ #category : #accessing }
AttributedTextStream >> nextPutAll: aString [	
	"add an entire string with the same attributes"	
	currentRun := currentRun + aString size.	
	characters nextPutAll: aString.
]

{ #category : #accessing }
AttributedTextStream >> size [	
	^ characters size
]

{ #category : #accessing }
AttributedTextStream >> withAttribute: attribute do: aBlock [

	^self withAttributes: { attribute } do: aBlock
]

{ #category : #accessing }
AttributedTextStream >> withAttributes: attributes do: aBlock [

	| previousAttributes |
	previousAttributes := currentAttributes.
	[
		self currentAttributes: attributes.
		aBlock value ]
			ensure: [ self currentAttributes: previousAttributes ]
]
