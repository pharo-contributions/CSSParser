Class {
	#name : #CSSLangSelector,
	#superclass : #CSSPseudoClassSelector,
	#category : #'CSSParser-CSS'
}

{ #category : #accessing }
CSSLangSelector >> language [
	"Answer the value of language"

	^ self arguments
]
