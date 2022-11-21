Class {
	#name : #HtmlHRNode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #rendering }
HtmlHRNode >> addToFormatter: formatter [
	formatter hr
]

{ #category : #accessing }
HtmlHRNode >> tag [
	^ 'hr'
]
