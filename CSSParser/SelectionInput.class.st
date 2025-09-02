"
allows a user to select from a number of options
"
Class {
	#name : 'SelectionInput',
	#superclass : 'FormInput',
	#instVars : [
		'name',
		'defaultValue',
		'listMorph',
		'values'
	],
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'instance creation' }
SelectionInput class >> name: name0  defaultValue: defaultValue  list: list  values: values [
	^self new name: name0  defaultValue: defaultValue  list: list  values: values
]

{ #category : 'handling input' }
SelectionInput >> active [
	^self name isNil not and: [listMorph getCurrentSelectionIndex > 0]
]

{ #category : 'handling input' }
SelectionInput >> name [
	^name
]

{ #category : 'private-initialization' }
SelectionInput >> name: name0  defaultValue: defaultValue0  list: list0 values: values0 [
	name := name0.
	defaultValue := defaultValue0.
	listMorph := list0.
	values := values0.
]

{ #category : 'handling input' }
SelectionInput >> reset [
	listMorph selection: defaultValue
]

{ #category : 'handling input' }
SelectionInput >> value [
	^values at: listMorph getCurrentSelectionIndex
]
