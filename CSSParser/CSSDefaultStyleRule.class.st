Class {
	#name : 'CSSDefaultStyleRule',
	#superclass : 'CSSStyleRule',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'instance creation' }
CSSDefaultStyleRule class >> fromDictionary: aStyleDictionary [

	| rule |
	rule := self new.
	aStyleDictionary keysAndValuesDo: 
		[:name :value | rule addProperty: ((CSSDefaultProperty propertyNamed: name) propertyString: value)].
	^ rule
]

{ #category : 'printing' }
CSSDefaultStyleRule >> printOn: aStream [

	| first |
	aStream nextPutAll: '{'.
	first := true.
	self properties do: [:p |
		first ifTrue: [ first := false ] ifFalse: [aStream nextPutAll: ';'].
		p printOn: aStream].
	aStream nextPutAll: '}'
]
