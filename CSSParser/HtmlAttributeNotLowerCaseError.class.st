Class {
	#name : #HtmlAttributeNotLowerCaseError,
	#superclass : #HtmlAttributeError,
	#category : #'CSSParser-DOM-Errors'
}

{ #category : #testing }
HtmlAttributeNotLowerCaseError >> isCaseError [
]

{ #category : #testing }
HtmlAttributeNotLowerCaseError >> printOn: aStream [

	| |
	self attribute printOn: aStream.
	aStream nextPutAll: ' should be '.
	self attribute asLowercase printOn: aStream.
	aStream nextPutAll: ' in '.
	self parent prefix printOn: aStream" Valid attributes are: '.
	attrList := self parent dtd attrListForTag: self parent dtdTag.
	(attrList attributes collect:[:ea | ea attribute]) printOn: aStream."
]
