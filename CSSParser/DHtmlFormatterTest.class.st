Class {
	#name : #DHtmlFormatterTest,
	#superclass : #TestCase,
	#instVars : [
		'htmlFormatter'
	],
	#category : #'CSSParser-Tests'
}

{ #category : #accessing }
DHtmlFormatterTest >> htmlFormatter [

	^ htmlFormatter
]

{ #category : #accessing }
DHtmlFormatterTest >> htmlFormatter: anObject [

	htmlFormatter := anObject
]

{ #category : #running }
DHtmlFormatterTest >> setUp [
	self timeout: 300.
	self htmlFormatter: DHtmlFormatter new
]

{ #category : #testing }
DHtmlFormatterTest >> test03HtmlEntitiesShouldBeParsedCorrectly [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'&micro;').
	document addToFormatter: (self htmlFormatter).
	self assert: 'µ' equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test04DecimalHtmlEntitiesShouldBeParsedCorrectly [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'&#182;').
	document addToFormatter: (self htmlFormatter).
	self assert: '¶' equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test05HexadecimalHtmlEntitiesShouldBeParsedCorrectly [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'&#x00A7;').
	document addToFormatter: (self htmlFormatter).
	self assert: '§' equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test06NonHtmlEntitiesShouldBeReturned [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'&squeak;<!-- begin <Tag> end --> & text').
	document addToFormatter: (self htmlFormatter).
	self assert: '&squeak; & text' equals: self htmlFormatter text asString.
	self assert: '<!-- begin <Tag> end -->' equals: document children second rawContent.
]

{ #category : #testing }
DHtmlFormatterTest >> test07HtmlEntitiesShouldBeParsedEverywhere [
	| document |
	document := HtmlDocument new.
	document parseContents: 
		(ReadStream on: '<title>Test &auml;, &ouml; and &uuml;</title>',
			'<img src=''http:&#47;&#47;'' alt=''&#248; nothing''> </img>').
	self assert: '<title>Test ä, ö and ü</title>' equals: document children first asString.
	self assert: 'http://' equals: document children second src.
	self assert: 'ø nothing' equals: document children second alt.
]

{ #category : #testing }
DHtmlFormatterTest >> test08OrderedListsShouldHaveNumbers [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'<ol><li>First</li><li>Second</li></ol>').
	document addToFormatter: (self htmlFormatter).
	self assert:
	'1. First
2. Second
'
equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test09OrderedListsShouldHaveCustomizableStartValues [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'<ol start="5"><li>First</li><li>Second</li></ol>').
	document addToFormatter: (self htmlFormatter).
	self assert:
	'5. First
6. Second
'
equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test10OrderedListsShouldHaveCustomizableItemValues [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'<ol><li>First</li><li value="4">Second</li><li>Third</li></ol>').
	document addToFormatter: (self htmlFormatter).
	self assert:
	'1. First
4. Second
5. Third
'
equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test11OrderedListsShouldSupportListStyleTypeNone [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'<ol style="list-style-type:none"><li>First</li><li>Second</li><li>Third</li></ol>').
	document applyStyles.
	document addToFormatter: (self htmlFormatter).
	self assert:
	'First
Second
Third
'
equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test12UnorderedListsShouldSupportListStyleTypeNone [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on:'<ul style="list-style-type:none"><li>First</li><li>Second</li><li>Third</li></ul>').
	document applyStyles.
	document addToFormatter: (self htmlFormatter).
	self assert:
	'First
Second
Third
'
equals: self htmlFormatter text asString.
]

{ #category : #testing }
DHtmlFormatterTest >> test13CommentsShouldNotBeDisplayed [
	| document |
	document := HtmlDocument new.
	document parseContents: (ReadStream on: '<!-- Comment -->').
	document addToFormatter: (self htmlFormatter).
	self assert: '' equals: self htmlFormatter text asString.
]
