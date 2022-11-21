"
I am here to provide a printString method for CSSPropertys that are added by addDefaultStyle in HtmlNodes.

Instance Variables

"
Class {
	#name : #CSSDefaultProperty,
	#superclass : #CSSProperty,
	#category : #'CSSParser-CSS'
}

{ #category : #printing }
CSSDefaultProperty >> printOn: aStream [
	aStream nextPutAll: (self propertyName, ':', self propertyString)
	
]
