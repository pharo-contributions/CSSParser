"
an input instance for a form.  A form takes its input from a collection of FormInputs; each FormInput has a name and can retrieve a textual value.  WHen a form is submitted, these name-value associations are gathered together and passed to an HTTP server.
"
Class {
	#name : 'FormInput',
	#superclass : 'Object',
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'input handling' }
FormInput >> active [
	"whether this input is currently providing an input"
	^self name isNil not
]

{ #category : 'testing' }
FormInput >> isRadioButtonSetInput [
	^false
]

{ #category : 'input handling' }
FormInput >> name [
	"name associated with this input"
	^self subclassResponsibility
]

{ #category : 'input handling' }
FormInput >> reset [
	"reset to a default value"
	
]

{ #category : 'input handling' }
FormInput >> value [
	"value associated with this input"
	^self subclassResponsibility
]
