Class {
	#name : 'HtmlSTYLENode',
	#superclass : 'HtmlDOMNode',
	#category : 'CSSParser-DOM',
	#package : 'CSSParser',
	#tag : 'DOM'
}

{ #category : 'accessing' }
HtmlSTYLENode >> isCSS [

	^true
]

{ #category : 'accessing' }
HtmlSTYLENode >> isRenderedInline [
	^ true
]

{ #category : 'accessing' }
HtmlSTYLENode >> parseContents: aStream [

	| str  child |

	str := aStream upTo: $>.
	
	[(str asLowercase endsWith: ('</',self tag)) or: [aStream atEnd]] 
		whileFalse: [str := (str, '>', (aStream upTo: $>))].

	self end: aStream position.
	self endTagMissing: (str asLowercase endsWith: ('</',self tag)) not.
	child := CSSStyleSheet start: self startForNextElement end: (aStream position - (self tag size + 3)).
	self addChild: child.
	aStream position: child start.
	child parseContents: aStream.
	aStream position: self end.
	

]

{ #category : 'accessing' }
HtmlSTYLENode >> stylesheet [

	^self children first
]

{ #category : 'accessing' }
HtmlSTYLENode >> tag [
	^ 'style'
]

{ #category : 'accessing' }
HtmlSTYLENode >> validateAgainstDTD: aDTD [
]
