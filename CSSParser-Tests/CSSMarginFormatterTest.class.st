Class {
	#name : 'CSSMarginFormatterTest',
	#superclass : 'CSSDistanceFormatterTest',
	#category : 'CSSParser-Tests-CSS-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'CSS-Tests'
}

{ #category : 'accessing' }
CSSMarginFormatterTest >> prefix [

	^ 'margin'
]

{ #category : 'running' }
CSSMarginFormatterTest >> setUp [
	super setUp.
	self formatter: CSSMarginFormatter new
]

{ #category : 'accessing' }
CSSMarginFormatterTest >> suffix [

	^ ''
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test01topAttributeShouldBeParsedCorrectly [ 

	super topAttributeShouldBeParsedCorrectly 
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test02rightAttributeShouldBeParsedCorrectly [ 

	super rightAttributeShouldBeParsedCorrectly 
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test03bottomAttributeShouldBeParsedCorrectly [ 

	super bottomAttributeShouldBeParsedCorrectly 
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test04leftAttributeShouldBeParsedCorrectly [ 

	super leftAttributeShouldBeParsedCorrectly 
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test05oneShorthandAttributeShouldBeParsedCorrectly [ 

	super oneShorthandAttributeShouldBeParsedCorrectly 
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test06twoShorthandAttributesShouldBeParsedCorrectly [ 

	super twoShorthandAttributesShouldBeParsedCorrectly 
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test07threeShorthandAttributesShouldBeParsedCorrectly [ 

	super threeShorthandAttributesShouldBeParsedCorrectly 
]

{ #category : 'testing' }
CSSMarginFormatterTest >> test08fourShorthandAttributesShouldBeParsedCorrectly [ 

	super fourShorthandAttributesShouldBeParsedCorrectly 
]
