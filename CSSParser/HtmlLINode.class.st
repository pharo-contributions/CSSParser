Class {
	#name : #HtmlLINode,
	#superclass : #HtmlDOMNode,
	#category : #'CSSParser-DOM'
}

{ #category : #accessing }
HtmlLINode >> endStyles: aFormatter [
	aFormatter endListItem.
]

{ #category : #accessing }
HtmlLINode >> startStyles: aFormatter [
	(self attributes includesKey: 'value')
		ifTrue: [aFormatter startListItemWithValue: (self attributes at: 'value')]
		ifFalse: [aFormatter startListItem].
]

{ #category : #accessing }
HtmlLINode >> tag [
	^ 'li'
]
