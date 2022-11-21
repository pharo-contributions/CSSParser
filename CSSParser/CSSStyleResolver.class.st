Class {
	#name : #CSSStyleResolver,
	#superclass : #Object,
	#instVars : [
		'cssPrefixMap',
		'domNode'
	],
	#category : #'CSSParser-Formatter'
}

{ #category : #'instance creation' }
CSSStyleResolver class >> for: aDomNode [
	^ self new
		domNode: aDomNode;
		yourself
]

{ #category : #constants }
CSSStyleResolver class >> inheritableAttributes [
	"The following CSS Attributes are inheritable:"
	"'azimuth', 'border-collapse', 'border-spacing', 'caption-side', 'color', 'cursor', 'direction', 'elevation', 'empty-cells', 'font-family', 'font-size', 'font-style', 'font-variant', 'font-weight', 'font', 'letter-spacing', 'line-height', 'list-style-image', 'list-style-position', 'list-style-type', 'list-style', 'orphans', 'pitch-range', 'pitch', 'quotes', 'richness', 'speak-header', 'speak-numeral', 'speak-punctuation', 'speak', 'speak-rate', 'stress', 'text-align', 'text-indent', 'text-transform', 'visibility', 'voice-family', 'volume', 'white-space', 'widows', 'word-spacing'"
	^ #( #italic. #bold. #fontSize. #color. #fontFamily. #textAlign)
]

{ #category : #'formatter-resolution' }
CSSStyleResolver >> cssPrefixMap [
	^ cssPrefixMap ifNil: [
		| sizeFormatter |
		sizeFormatter := CSSSizeFormatter new.
		cssPrefixMap := Dictionary newFrom: {
			'font' -> CSSFontFormatter new.
			'text' -> CSSTextFormatter new.
			'color' -> CSSColorFormatter new.
			'display' -> CSSDisplayFormatter new.
			'list' -> CSSListFormatter new.
			'background' -> CSSBackgroundFormatter new.
			'padding' -> CSSPaddingFormatter new.
			'margin' -> CSSMarginFormatter new.
			'border' -> CSSBorderWidthFormatter new.
			'position' -> CSSPositionFormatter new.
			'float' -> CSSPositionFormatter new.
			'height' -> sizeFormatter.
			'width' -> sizeFormatter.
		}]
]

{ #category : #accessing }
CSSStyleResolver >> domNode: anObject [

	domNode := anObject
]

{ #category : #'private-resolution' }
CSSStyleResolver >> evaluateLocalStylesFor: aDomNode [
	| styles |
	styles := Dictionary new.
	
	aDomNode styles do: [:style | 
		style properties do: [:prop | self parseCSSProperty: prop of: aDomNode into: styles ]].
	aDomNode computedStyles: styles
]

{ #category : #'formatter-resolution' }
CSSStyleResolver >> getFormatterFor: aCSSProperty [
	| prefix |
	prefix := self getPrefixOf: aCSSProperty propertyName asLowercase.
	^ self cssPrefixMap at: prefix ifAbsent: [nil]
]

{ #category : #'formatter-resolution' }
CSSStyleResolver >> getPrefixOf: aString [

	^(aString substrings: '-') first.
]

{ #category : #resolution }
CSSStyleResolver >> getStyle: attributeKey [
	
	^ self getStyle: attributeKey for: domNode
]

{ #category : #resolution }
CSSStyleResolver >> getStyle: attributeKey for: aDomNode [
	
	aDomNode computedStyles ifNil: [ self evaluateLocalStylesFor: aDomNode ].
	^ self resolveStyle: attributeKey for: aDomNode
]

{ #category : #resolution }
CSSStyleResolver >> ifStyleNotNil: attributeKey do: aBlock [

	(self getStyle: attributeKey) ifNotNilDo: [ :attribValue | ^aBlock value: attribValue ]
]

{ #category : #resolution }
CSSStyleResolver >> ifStyleNotNil: attributeKey do: aBlock ifNil: anotherBlock [

	(self getStyle: attributeKey) ifNil: [^anotherBlock value] ifNotNilDo: [ :attribValue | ^aBlock value: attribValue ]
]

{ #category : #'private-resolution' }
CSSStyleResolver >> parseCSSProperty: aCSSProperty of: aDomNode into: aContext [
	
	(self getFormatterFor: aCSSProperty)
		ifNotNil: [:formatter | 
			formatter parseTextAttributesFrom: aCSSProperty 
					    into: aContext 
					    withParentAttributeResolver: [:attr | self resolveParentAttribute: attr of: aDomNode ]]
]

{ #category : #'private-resolution' }
CSSStyleResolver >> resolveParentAttribute: attributeKey of: aDomNode [
	^ aDomNode parent
			ifNil: [ nil ]
			ifNotNil: [ self getStyle: attributeKey for: aDomNode parent ]
]

{ #category : #'private-resolution' }
CSSStyleResolver >> resolveStyle: attributeKey for: aDomNode [
	| parentStyle |
	(aDomNode computedStyles includesKey: attributeKey)
		ifTrue: [ ^ aDomNode computedStyles at: attributeKey ].

	(self class inheritableAttributes includes: attributeKey) ifFalse: [ ^ nil ].
	aDomNode parent ifNil: [ ^ nil ].

	parentStyle := self getStyle: attributeKey for: aDomNode parent.
	aDomNode computedStyles at: attributeKey put: parentStyle.
	^ parentStyle
]
