Class {
	#name : #CSSBorderWidthFormatterTest,
	#superclass : #CSSDistanceFormatterTest,
	#category : #'CSSParser-CSS-Tests'
}

{ #category : #accessing }
CSSBorderWidthFormatterTest >> prefix [

	^ 'border'
]

{ #category : #running }
CSSBorderWidthFormatterTest >> setUp [
	self formatter: CSSBorderWidthFormatter new
]

{ #category : #accessing }
CSSBorderWidthFormatterTest >> suffix [

	^ '-width'
]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test01topAttributeShouldBeParsedCorrectly [ 

	super topAttributeShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test02rightAttributeShouldBeParsedCorrectly [ 

	super rightAttributeShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test03bottomAttributeShouldBeParsedCorrectly [ 

	super bottomAttributeShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test04leftAttributeShouldBeParsedCorrectly [ 

	super leftAttributeShouldBeParsedCorrectly 

]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test05oneShorthandAttributeShouldBeParsedCorrectly [ 

	super oneShorthandAttributeShouldBeParsedCorrectly 

]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test06twoShorthandAttributesShouldBeParsedCorrectly [ 

	super twoShorthandAttributesShouldBeParsedCorrectly 
]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test07threeShorthandAttributesShouldBeParsedCorrectly [ 

	super threeShorthandAttributesShouldBeParsedCorrectly 

]

{ #category : #testing }
CSSBorderWidthFormatterTest >> test08fourShorthandAttributesShouldBeParsedCorrectly [ 

	super fourShorthandAttributesShouldBeParsedCorrectly 

]
