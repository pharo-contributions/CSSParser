Class {
	#name : 'HtmlParseNode',
	#superclass : 'Object',
	#instVars : [
		'children',
		'parent',
		'errors',
		'start',
		'end',
		'tag'
	],
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'instance creation' }
HtmlParseNode class >> start: s end: e [

	^self new start: s; end: e
]

{ #category : 'accessing' }
HtmlParseNode >> addChild: aNode [

	self children: (self children copyWith: aNode).
	aNode parent: self.
]

{ #category : 'accessing' }
HtmlParseNode >> addError: anError [

	anError parent: self.
	self errors: (self errors copyWith: anError)
]

{ #category : 'accessing' }
HtmlParseNode >> allErrors [

	| collection |

	self errors do:[:ea | ea position isNil ifTrue: [ea position: self start]].
	collection := OrderedCollection new.
	collection addAll: (self errors).
	self children do:[:ea | collection addAll: ea allErrors].
	^collection asArray
]

{ #category : 'accessing' }
HtmlParseNode >> allErrorsMatching: aBlock [

	| errs |

	errs := OrderedCollection new.

	self nodesDo: [:ea | ea errors do:[:er | (aBlock value: er) ifTrue: [errs add: er]]].

	^errs asArray
]

{ #category : 'accessing' }
HtmlParseNode >> asString [

	| |

	^(self prefix, self innerContents, self suffix)
		
]

{ #category : 'accessing' }
HtmlParseNode >> children [
	"Answer the value of children"

	^ children isNil ifTrue: [#()] ifFalse: [children]
]

{ #category : 'accessing' }
HtmlParseNode >> children: anObject [
	"Set the value of children"

	children := anObject.
	children do:[:ea | ea parent: self]
]

{ #category : 'accessing' }
HtmlParseNode >> content [

	^self parent ifNil: [''] ifNotNil: [self parent content]
]

{ #category : 'accessing' }
HtmlParseNode >> detectAncestor: aBlock [

	| p |

	p := self.
	[p notNil] whileTrue: [(aBlock value: p) ifTrue: [^p]. p := p parent].
	^p

	
]

{ #category : 'accessing' }
HtmlParseNode >> document [

	^self parent document
]

{ #category : 'accessing' }
HtmlParseNode >> end [
	"Answer the value of end"

	^ end
]

{ #category : 'accessing' }
HtmlParseNode >> end: anObject [
	"Set the value of end"

	end := anObject
]

{ #category : 'accessing' }
HtmlParseNode >> errors [
	"Answer the value of errors"

	^ errors isNil ifTrue: [#()] ifFalse: [errors]
]

{ #category : 'accessing' }
HtmlParseNode >> errors: anObject [
	"Set the value of errors"

	errors := anObject
]

{ #category : 'accessing' }
HtmlParseNode >> firstAncestor: aString [

	| p |

	p := self parent.
	[p notNil] whileTrue: [p tag = aString ifTrue: [^p]. p := p parent].
	^p

	
]

{ #category : 'accessing' }
HtmlParseNode >> hasAncestor: aString [

	^(self firstAncestor: aString) notNil
]

{ #category : 'testing' }
HtmlParseNode >> innerContents [

	| in | 

	^self children isEmpty 
		ifTrue: ['']
		ifFalse: 
		[
			in := ReadStream on: self content.
			in position: self children first start.
			in next: (self children last end - self children first start).
		]
]

{ #category : 'accessing' }
HtmlParseNode >> innerId [

	^(self uniqueId, '-inner')
]

{ #category : 'testing' }
HtmlParseNode >> isCDATA [

	^false
]

{ #category : 'testing' }
HtmlParseNode >> isCSS [

	^false
]

{ #category : 'testing' }
HtmlParseNode >> isComment [

	^false
]

{ #category : 'testing' }
HtmlParseNode >> isDocument [

	^false
]

{ #category : 'testing' }
HtmlParseNode >> isHTML [

	^false
]

{ #category : 'accessing' }
HtmlParseNode >> isImplied [
	
	^false
]

{ #category : 'testing' }
HtmlParseNode >> isStyleSheet [

	^false
]

{ #category : 'accessing' }
HtmlParseNode >> level [

	| level p |
	level := 0.
	p := self.
	[p notNil] whileTrue: [p := p parent. p notNil ifTrue:[level := level + 1]].
	^level
]

{ #category : 'iterating' }
HtmlParseNode >> nodesDo: aBlock [

	aBlock value: self.
	self children do:[:ea | ea nodesDo: aBlock].
]

{ #category : 'iterating' }
HtmlParseNode >> nodesSelect: aBlock [

	| col |

	col := OrderedCollection new.
	self nodesDo:[:ea | (aBlock value: ea) ifTrue: [col add: ea]].
	^col asArray
]

{ #category : 'accessing' }
HtmlParseNode >> parent [
	"Answer the value of parent"

	^ parent isNil ifTrue: [nil] ifFalse: [parent first]
]

{ #category : 'accessing' }
HtmlParseNode >> parent: anObject [
	"Set the value of parent"

	parent := WeakArray with: anObject
]

{ #category : 'parsing' }
HtmlParseNode >> parseContents: aStream [

	self subclassResponsibility
]

{ #category : 'accessing' }
HtmlParseNode >> prefix [

	| in theEnd |

	in := ReadStream on: self content.
	in position: self start.	
	theEnd := self children isEmpty ifTrue:[self end] ifFalse:[self children first start].

	^in next: (theEnd - self start)
]

{ #category : 'accessing' }
HtmlParseNode >> prefixId [

	^self uniqueId
]

{ #category : 'accessing' }
HtmlParseNode >> rawContent [

	| in |

	in := ReadStream on: self document content.
	in position: self start.
	(self isComment or: [self parent ifNotNil: [self parent isComment]])
		ifTrue: [^ (in next: (self end - self start))]
		ifFalse: [^ (in next: (self end - self start)) asUnHtml].
]

{ #category : 'accessing' }
HtmlParseNode >> start [
	"Answer the value of start"

	^ start
]

{ #category : 'accessing' }
HtmlParseNode >> start: anObject [
	"Set the value of start"

	start := anObject
]

{ #category : 'accessing' }
HtmlParseNode >> startForNextElement [

	^self children isEmpty ifTrue:
	[
		| in |
		in := ReadStream on: self document content.
		in position: start.
		in upTo: $>.
		in position
	]
	ifFalse:
	[
		self children last end
	]
]

{ #category : 'accessing' }
HtmlParseNode >> suffix [

	| in theStart |

	in := ReadStream on: self content.

	theStart := self children isEmpty ifTrue:[self end] ifFalse:[self children last end].
	in position: theStart.	
	^in next: (0 max: (self end - theStart))
]

{ #category : 'accessing' }
HtmlParseNode >> suffixId [

	^(self uniqueId, '-end')
]

{ #category : 'accessing' }
HtmlParseNode >> tag [
	"Answer the value of tag"

	^ tag isNil ifFalse: [tag asLowercase] ifTrue: [tag]  
]

{ #category : 'accessing' }
HtmlParseNode >> uniqueId [

	^(self parent uniqueId, '.', ((self parent children indexOf: self) asString))
]
