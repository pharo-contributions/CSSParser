"
An input field for <INPUT TYPE=""file"">
Support for uploading files using HTTP/multipart forms
Appearance/behavior as in NS/MS browsers
(i.e., separate filename entry box and browse files button)
"
Class {
	#name : 'FileInput',
	#superclass : 'TextInput',
	#category : 'CSSParser-Forms',
	#package : 'CSSParser',
	#tag : 'Forms'
}

{ #category : 'instance creation' }
FileInput class >> name: aString textMorph: aTextMorph [
	^self name: aString defaultValue: '' textMorph: aTextMorph
]

{ #category : 'accessing' }
FileInput >> browse [
	| file |
	file := (StandardFileMenu oldFileFrom: self directory) ifNil: [^nil].
	file directory isNil ifTrue: [^ nil].

	textMorph setText: (file directory pathName, FileDirectory slash, file name);
		hasUnacceptedEdits: true;
		accept
]

{ #category : 'accessing' }
FileInput >> directory [
	^FileDirectory forFileName: self filename
]

{ #category : 'accessing' }
FileInput >> filename [
	textMorph hasUnacceptedEdits ifTrue: [ textMorph accept ].
	^textMorph getText asString withInternetLineEndings
]

{ #category : 'accessing' }
FileInput >> localFilename [
	^FileDirectory localNameFor: self filename
]

{ #category : 'accessing' }
FileInput >> url [
	^FileUrl pathParts: ((self directory pathParts) copyWith: self localFilename)
]

{ #category : 'accessing' }
FileInput >> value [
	^MIMEDocument contentType: (MIMEDocument guessTypeFromName: self filename)
		content: nil
		url: self url
]
