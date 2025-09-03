Class {
	#name : 'CSSStyleResolverTest',
	#superclass : 'TestCase',
	#instVars : [
		'styleResolver'
	],
	#category : 'CSSParser-Tests-CSS-Tests',
	#package : 'CSSParser-Tests',
	#tag : 'CSS-Tests'
}

{ #category : 'running' }
CSSStyleResolverTest >> setUp [
	self setUp.
	self styleResolver: CSSStyleResolver new
]

{ #category : 'accessing' }
CSSStyleResolverTest >> styleResolver [

	^ styleResolver
]

{ #category : 'accessing' }
CSSStyleResolverTest >> styleResolver: anObject [

	styleResolver := anObject
]

{ #category : 'testing' }
CSSStyleResolverTest >> test01StylesShouldBeForwardedToTheCorrectFormatter [
	| result mappings |
	mappings := { 
		{CSSFontFormatter. {'font'. 'font-style'. 'font-weight'. 'font-size'}}.
		{CSSColorFormatter. {'cOlOr'}}.
		{CSSDisplayFormatter. {'display'}}}.
	
	mappings do: [:mapping |
		mapping last do: [:attributeName |
			| prop |
			prop := CSSProperty propertyNamed: attributeName.
			result := self styleResolver getFormatterFor: prop.

			self assert: result class equals: mapping first ] ]
]

{ #category : 'testing' }
CSSStyleResolverTest >> test02LastRuleShouldOverrideAllOthers [
	"https://developer.mozilla.org/en-US/docs/Web/CSS/Shorthand_properties"
	| props node |

	props := CSSStyleRule new 
		addProperty: ((CSSProperty propertyNamed: 'font-style') propertyString: 'italic');
		addProperty: ((CSSProperty propertyNamed: 'font-weight') propertyString: 'bold');
		addProperty: ((CSSProperty propertyNamed: 'font') propertyString: 'normal').
	
	node := HtmlDOMNode new 
				addStyle: props;
				yourself.
		
	self styleResolver evaluateLocalStylesFor: node.

	self assert: (node computedStyles at: #italic) equals: false.
	self assert: (node computedStyles at: #bold) equals: false
]

{ #category : 'testing' }
CSSStyleResolverTest >> test03CSSRulesShouldBeWrittenToComputedStyles [
	| props node |

	props := CSSStyleRule new 
		addProperty: ((CSSProperty propertyNamed: 'color') propertyString: '#fff');
		addProperty: ((CSSProperty propertyNamed: 'font-weight') propertyString: 'bold').
	
	node := HtmlDOMNode new 
				addStyle: props;
				yourself.
		
	self styleResolver evaluateLocalStylesFor: node.

	self assert: (node computedStyles at: #bold) equals: true.
	self assert: (node computedStyles at: #color) equals: Color white
]

{ #category : 'testing' }
CSSStyleResolverTest >> test04UndefinedCSSAttributeShouldBeInheritedFromParentElement [
	| props node |

	props := CSSStyleRule new
		addProperty: ((CSSProperty propertyNamed: 'font-weight') propertyString: 'bold').
	
	node := HtmlDOMNode new.
	HtmlDOMNode new 
		addStyle: props;
		children: { node }.	

	self assert: (self styleResolver getStyle: #bold for: node) equals: true
]

{ #category : 'testing' }
CSSStyleResolverTest >> test05NotInheritableCSSAttributesShouldNotBeInheritedFromParentElement [
	| props node |

	props := CSSStyleRule new
		addProperty: ((CSSProperty propertyNamed: 'display') propertyString: 'block').
	
	node := HtmlDOMNode new.
	HtmlDOMNode new 
		addStyle: props;
		children: { node }.	

	self assert: (self styleResolver getStyle: #bold for: node) equals: nil
]

{ #category : 'testing' }
CSSStyleResolverTest >> test06InheritedCSSAttributeShouldBeCached [
	| node parent |
	
	node := HtmlDOMNode new.
	parent := HtmlDOMNode new 
		computedStyles: (Dictionary newFrom: { #bold -> true });
		children: { node }.

	self styleResolver getStyle: #bold for: node.	
	parent computedStyles at: #bold put: false.
	self assert: (self styleResolver getStyle: #bold for: node) equals: true
]
