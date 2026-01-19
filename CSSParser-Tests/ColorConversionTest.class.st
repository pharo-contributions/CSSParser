Class {
	#name : 'ColorConversionTest',
	#superclass : 'TestCase',
	#category : 'CSSParser-Tests-Extensions',
	#package : 'CSSParser-Tests',
	#tag : 'Extensions'
}

{ #category : 'testing' }
ColorConversionTest >> test01ConvertNameToColor [
	| colorLists |
	colorLists := OrderedCollection new.
	colorLists
		add: Color htmlColors1;
		add: Color htmlColors2.
	colorLists do: [:colorList | 
		colorList keysAndValuesDo: [ :colorName :rgb |
			self assert: (Color fromHTMLString: colorName) 
				 equals: (Color r: rgb first / 255 g: rgb second / 255 b: rgb third / 255).
		].
	].
	self assert: (Color r: 1 g: 0 b: 0) equals: (Color fromHTMLString: 'Red').
]

{ #category : 'testing' }
ColorConversionTest >> test02ConvertHexRGBToColor [
		
	self assert: (Color fromHTMLString: '#fff') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: '#FFF') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: '#000') equals: (Color r: 0 g: 0 b: 0).
	self assert: (Color fromHTMLString: '#f08') equals: (Color r: 1 g: 0 b: 0.534).
	self assert: (Color fromHTMLString: '#abcdef') equals: (Color r: 171/255 g: 205/255 b:239/255)
]

{ #category : 'testing' }
ColorConversionTest >> test03ConvertHexRRGGBBToColor [
		
	self assert: (Color fromHTMLString: '#ffffff') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: '#FFFFFF') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: '#000000') equals: (Color r: 0 g: 0 b: 0).
	self assert: (Color fromHTMLString: '#ff0088') equals: (Color r: 1 g: 0 b: 0.534).
	self assert: (Color fromHTMLString: '#abcdef') equals: (Color r: 0.671 g: 0.804 b: 0.937).
]

{ #category : 'testing' }
ColorConversionTest >> test04ConvertRGBDecimalFunctionToColor [
		
	self assert: (Color fromHTMLString: 'rgb(255, 255, 255)') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: 'rgb(255,255,255)') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: 'rgb(0, 0, 0)') equals: (Color r: 0 g: 0 b: 0).
	self assert: (Color fromHTMLString: 'rgb(255, 0, 136)') equals: (Color r: 1 g: 0 b: 0.534).
	self assert: (Color fromHTMLString: 'rgb(300, -10, 136)') equals: (Color r: 1 g: 0 b: 0.534).
]

{ #category : 'testing' }
ColorConversionTest >> test05ConvertRGBPercentFunctionToColor [
		
	self assert: (Color fromHTMLString: 'rgb(100%, 100%, 100%)') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: 'rgb(100%,100%,100%)') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: 'rgb(0%, 0%, 0%)') equals: (Color r: 0 g: 0 b: 0).
	self assert: (Color fromHTMLString: 'rgb(100%, 0%, 35%)') equals: (Color r: 1 g: 0 b: 0.35).
	self assert: (Color fromHTMLString: 'rgb(300%, -10%, 35%)') equals: (Color r: 1 g: 0 b: 0.35).
]

{ #category : 'testing' }
ColorConversionTest >> test06CSS2ColorNamesEqualsOfficialW3List [
		
	self assert: (Color fromHTMLString: 'aqua') equals: (Color r: 0 g: 1 b: 1).
	self assert: (Color fromHTMLString: 'black') equals: (Color r: 0 g: 0 b: 0).
	self assert: (Color fromHTMLString: 'blue') equals: (Color r: 0 g: 0 b: 1).
	self assert: (Color fromHTMLString: 'fuchsia') equals: (Color r: 1 g: 0 b: 1).
	self assert: (Color fromHTMLString: 'gray') equals: (Color r: 0.502 g: 0.502 b: 0.502).
	self assert: (Color fromHTMLString: 'green') equals: (Color r: 0 g: 0.502 b: 0).
	self assert: (Color fromHTMLString: 'lime') equals: (Color r: 0 g: 1 b: 0).
	self assert: (Color fromHTMLString: 'maroon') equals: (Color r: 0.502 g: 0 b: 0).
	self assert: (Color fromHTMLString: 'navy') equals: (Color r: 0 g: 0 b: 0.502).
	self assert: (Color fromHTMLString: 'olive') equals: (Color r: 0.502 g: 0.502 b: 0).
	self assert: (Color fromHTMLString: 'orange') equals: (Color r: 1 g: 0.647 b: 0).
	self assert: (Color fromHTMLString: 'purple') equals: (Color r: 0.502 g: 0 b: 0.502).
	self assert: (Color fromHTMLString: 'red') equals: (Color r: 1 g: 0 b: 0).
	self assert: (Color fromHTMLString: 'silver') equals: (Color r: 0.753 g: 0.753 b: 0.753).
	self assert: (Color fromHTMLString: 'teal') equals: (Color r: 0 g: 0.502 b: 0.502).
	self assert: (Color fromHTMLString: 'white') equals: (Color r: 1 g: 1 b: 1).
	self assert: (Color fromHTMLString: 'yellow') equals: (Color r: 1 g: 1 b: 0).
]
