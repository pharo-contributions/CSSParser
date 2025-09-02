"
a ""hidden"" input.  It never actually appear on a formatted page, and the user can't change the input value.
"
Class {
	#name : 'HiddenInput',
	#superclass : 'FormInput',
	#instVars : [
		'name',
		'value'
	],
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'instance creation' }
HiddenInput class >> name: name0  value: value [
	^self new name: name0  value: value
]

{ #category : 'input handling' }
HiddenInput >> name [
	^name
]

{ #category : 'private-initialization' }
HiddenInput >> name: name0  value: value0 [
	name := name0.	
	value := value0.
]

{ #category : 'input handling' }
HiddenInput >> value [
	^value
]
