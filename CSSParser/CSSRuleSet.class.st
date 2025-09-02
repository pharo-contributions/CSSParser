"
(1) The selector uses an ID. (Example: #foo)
(2) The selector doesn't have an ID but uses a class. (Example: .foo)
(3) The selector has no class or ID but specifies a tag name. (Example: div)
(4) The selector specifies none of these things. (Example: *[disabled])
"
Class {
	#name : 'CSSRuleSet',
	#superclass : 'Object',
	#instVars : [
		'idSelectors',
		'classSelectors',
		'tagSelectors',
		'otherSelectors'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSRuleSet >> candidateRulesForNode: aNode [

	| id classes list |

	id := aNode id.
	list := OrderedCollection new.
	list addAll: otherSelectors.
	aNode id isNil ifFalse:
	[
		list addAll: (idSelectors at: id ifAbsent:[#()]).
	].
	classes := aNode classes.
	(classes isNil or: [classes isEmpty]) ifFalse:
	[
		classes do: [:ea | list addAll: (classSelectors at: ea ifAbsent: [#()])]. 
	].
	list addAll: (tagSelectors at: aNode tag asLowercase ifAbsent: [#()]).
	^list
]

{ #category : 'accessing' }
CSSRuleSet >> classSelectors [
	"Answer the value of classSelectors"

	^ classSelectors
]

{ #category : 'accessing' }
CSSRuleSet >> classSelectors: anObject [
	"Set the value of classSelectors"

	classSelectors := anObject
]

{ #category : 'accessing' }
CSSRuleSet >> idSelectors [
	"Answer the value of idSelectors"

	^ idSelectors
]

{ #category : 'accessing' }
CSSRuleSet >> idSelectors: anObject [
	"Set the value of idSelectors"

	idSelectors := anObject
]

{ #category : 'initialize-release' }
CSSRuleSet >> initialize [

	super initialize.
	idSelectors := Dictionary new.
	classSelectors := Dictionary new.
	tagSelectors := Dictionary new.
	otherSelectors := OrderedCollection new.
]

{ #category : 'accessing' }
CSSRuleSet >> otherSelectors [
	"Answer the value of otherSelectors"

	^ otherSelectors
]

{ #category : 'accessing' }
CSSRuleSet >> otherSelectors: anObject [
	"Set the value of otherSelectors"

	otherSelectors := anObject
]

{ #category : 'accessing' }
CSSRuleSet >> tagSelectors [
	"Answer the value of tagSelectors"

	^ tagSelectors
]

{ #category : 'accessing' }
CSSRuleSet >> tagSelectors: anObject [
	"Set the value of tagSelectors"

	tagSelectors := anObject
]
