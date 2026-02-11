Extension { #name : 'String' }

{ #category : '*CSSParser' }
String >> asUnHtml [
	"Strip out all Html stuff (commands in angle brackets <>) and convert
    the characters &<> back to their real value. Leave actual cr and tab as
    they were in text."

	| in out char rest entities decoded |
	in := self readStream.
	out := String new writeStream.

	entities := Dictionary new
		            at: 'amp' put: '&';
		            at: 'lt' put: '<';
		            at: 'gt' put: '>';
		            at: 'quot' put: '"';
		            at: 'apos' put: '''';
		            yourself.

	[ in atEnd ] whileFalse: [
			in peek = $<
				ifTrue: [ "Absorber la balise <...> en entier"
						in next. "consomme le <"
						in upTo: $> "ignore tout jusqu'à >" ]
				ifFalse: [
						(char := in next) = $&
							ifTrue: [
									rest := in upTo: $;. "tout ce qu'il y a après & jusqu'à ;"
									decoded := entities at: rest ifAbsent: [
											           (rest beginsWith: '#')
												           ifTrue: [
														           | numberString |
														           numberString := (rest size > 1 and: [
															                            rest second asLowercase
															                            = $x ])
															                           ifTrue: [
															                           '16r'
															                           ,
															                           rest allButFirst allButFirst ]
															                           ifFalse: [ rest allButFirst ].
														           Character value: numberString asNumber ]
												           ifFalse: '&' , rest , ';' ].
									out nextPutAll: decoded asString ]
							ifFalse: [ out nextPut: char ] ] ].
	^ out contents
]

{ #category : '*CSSParser' }
String >> content [

	^self
]

{ #category : '*CSSParser' }
String >> unquoted [

	^self withoutQuoting
]
