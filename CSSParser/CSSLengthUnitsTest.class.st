Class {
	#name : #CSSLengthUnitsTest,
	#superclass : #TestCase,
	#instVars : [
		'cssformatter'
	],
	#category : #'CSSParser-CSS-Tests'
}

{ #category : #running }
CSSLengthUnitsTest >> setUp [
	super setUp.
	cssformatter := CSSFormatter new
]

{ #category : #testing }
CSSLengthUnitsTest >> test01EmShouldBeParsedCorrectly [
	| size |
	size := '2em'.
	self deny: (cssformatter isAbsoluteSize: size);
	       assert: (cssformatter isRelativeSize: size);
	       assert: (CSSFontFormatter defaultSize * 2)
			equals: (cssformatter relativeSizeToPx: size
									parentAndDefaultSize: CSSFontFormatter defaultSize);
	       assert: 2
			equals: (cssformatter relativeSizeToPx: size parentAndDefaultSize: 1)
]

{ #category : #testing }
CSSLengthUnitsTest >> test02ExShouldBeParsedCorrectly [
	| size |
	size := '5ex'.
	self deny: (cssformatter isAbsoluteSize: size);
	       assert: (cssformatter isRelativeSize: size);
	       assert: (CSSFontFormatter defaultSize * 5)
			equals: (cssformatter relativeSizeToPx: size
									parentAndDefaultSize: CSSFontFormatter defaultSize);
	       assert: 10
			equals: (cssformatter relativeSizeToPx: size parentAndDefaultSize: 2)
]

{ #category : #testing }
CSSLengthUnitsTest >> test03PercentageShouldBeParsedCorrectly [
	| size |
	size := '120%'.
	self deny: (cssformatter isAbsoluteSize: size);
	       assert: (cssformatter isRelativeSize: size);
	       assert: (CSSFontFormatter defaultSize * 1.2)
			equals: (cssformatter relativeSizeToPx: size
									parentAndDefaultSize: CSSFontFormatter defaultSize);
	       assert: 1.2
			equals: (cssformatter relativeSizeToPx: size parentAndDefaultSize: 1) asFloat
]

{ #category : #testing }
CSSLengthUnitsTest >> test04CmShouldBeParsedCorrectly [
	| size |
	size := '1.5cm'.
	self deny: (cssformatter isRelativeSize: size);
	       assert: (cssformatter isAbsoluteSize: size);
	       assert: (1.5 / 2.54 * TextStyle pixelsPerInch)
			equals: (cssformatter absoluteSizeToPx: size defaultSize: nil)
]

{ #category : #testing }
CSSLengthUnitsTest >> test05MmShouldBeParsedCorrectly [
	| size |
	size := '3mm'.
	self deny: (cssformatter isRelativeSize: size);
	       assert: (cssformatter isAbsoluteSize: size);
	       assert: (3 / 25.4 * TextStyle pixelsPerInch)
			equals: (cssformatter absoluteSizeToPx: size defaultSize: nil)
]

{ #category : #testing }
CSSLengthUnitsTest >> test06InShouldBeParsedCorrectly [
	| size |
	size := '0.3in'.
	self deny: (cssformatter isRelativeSize: size);
	       assert: (cssformatter isAbsoluteSize: size);
	       assert: (0.3 * TextStyle pixelsPerInch)
			equals: (cssformatter absoluteSizeToPx: size defaultSize: nil)
]

{ #category : #testing }
CSSLengthUnitsTest >> test07PtShouldBeParsedCorrectly [
	| size |
	size := '12pt'.
	self deny: (cssformatter isRelativeSize: size);
	       assert: (cssformatter isAbsoluteSize: size);
	       assert: (12 / 72 * TextStyle pixelsPerInch)
			equals: (cssformatter absoluteSizeToPx: size defaultSize: nil)
]

{ #category : #testing }
CSSLengthUnitsTest >> test08PcShouldBeParsedCorrectly [
	| size |
	size := '3pc'.
	self deny: (cssformatter isRelativeSize: size);
	       assert: (cssformatter isAbsoluteSize: size);
	       assert: (3 / 6 * TextStyle pixelsPerInch)
			equals: (cssformatter absoluteSizeToPx: size defaultSize: nil)
]

{ #category : #testing }
CSSLengthUnitsTest >> test09SmallerShouldBeParsedCorrectly [
	| size |
	size := 'smaller'.
	self assert: (cssformatter isRelativeSize: size);
	       deny: (cssformatter isAbsoluteSize: size);
	       assert: (0.7 * 16)
			equals: (cssformatter relativeSizeToPx: 'smaller' parentAndDefaultSize: 16)
]

{ #category : #testing }
CSSLengthUnitsTest >> test10LargerShouldBeParsedCorrectly [
	| size |
	size := 'larger'.
	self assert: (cssformatter isRelativeSize: size);
	       deny: (cssformatter isAbsoluteSize: size);
	       assert: (1.3 * 16)
			equals: (cssformatter relativeSizeToPx: 'larger' parentAndDefaultSize: 16)
]
