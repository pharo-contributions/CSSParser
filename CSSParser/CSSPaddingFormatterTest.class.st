Class {
	#name : #CSSPaddingFormatterTest,
	#superclass : #CSSDistanceFormatterTest,
	#category : #'CSSParser-CSS-Tests'
}

{ #category : #accessing }
CSSPaddingFormatterTest >> prefix [

	^ 'padding'
]

{ #category : #running }
CSSPaddingFormatterTest >> setUp [
	self formatter: CSSPaddingFormatter new
]

{ #category : #accessing }
CSSPaddingFormatterTest >> suffix [

	^ ''
]

{ #category : #testing }
CSSPaddingFormatterTest >> test01topAttributeShouldBeParsedCorrectly [ 

	super topAttributeShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSPaddingFormatterTest >> test02rightAttributeShouldBeParsedCorrectly [ 

	super rightAttributeShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSPaddingFormatterTest >> test03bottomAttributeShouldBeParsedCorrectly [ 

	super bottomAttributeShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSPaddingFormatterTest >> test04leftAttributeShouldBeParsedCorrectly [ 

	super leftAttributeShouldBeParsedCorrectly 

]

{ #category : #testing }
CSSPaddingFormatterTest >> test05oneShorthandAttributeShouldBeParsedCorrectly [ 

	super oneShorthandAttributeShouldBeParsedCorrectly 

]

{ #category : #testing }
CSSPaddingFormatterTest >> test06twoShorthandAttributesShouldBeParsedCorrectly [ 

	super twoShorthandAttributesShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSPaddingFormatterTest >> test07threeShorthandAttributesShouldBeParsedCorrectly [ 

	super threeShorthandAttributesShouldBeParsedCorrectly 

]

{ #category : #testing }
CSSPaddingFormatterTest >> test08fourShorthandAttributesShouldBeParsedCorrectly [ 

	super fourShorthandAttributesShouldBeParsedCorrectly 

]
