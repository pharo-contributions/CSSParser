Class {
	#name : #BaselineOfCSSParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfCSSParser
}

{ #category : #baselines }
BaselineOfCSSParser >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [ 
		spec package: 'CSSParser' ]
]
