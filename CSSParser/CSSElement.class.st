"
I am a base class for CSS parse nodes.
"
Class {
	#name : 'CSSElement',
	#superclass : 'HtmlParseNode',
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'testing' }
CSSElement >> isAtImportRule [

	^false
]

{ #category : 'testing' }
CSSElement >> isCSS [

	^true
]

{ #category : 'testing' }
CSSElement >> isProperty [

	^false
]

{ #category : 'testing' }
CSSElement >> isStyleRule [

	^false
]

{ #category : 'accessing' }
CSSElement >> stylesheetDocument [
	self parent 
		ifNil: [ ^ nil ]
		ifNotNil: [ ^ self parent stylesheetDocument ]
]

{ #category : 'accessing' }
CSSElement >> tag [
	^'css'
]

{ #category : 'accessing' }
CSSElement >> validateAgainstDTD: aDTD [
]
