Class {
	#name : 'BaselineOfCSSParser',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCSSParser',
	#package : 'BaselineOfCSSParser'
}

{ #category : 'baselines' }
BaselineOfCSSParser >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [ 
		spec package: 'CSSParser'.
		spec package: 'CSSParser-Tests' ]
]
