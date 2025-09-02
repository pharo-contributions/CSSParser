Class {
	#name : 'CSSValueTypeNToMOf',
	#superclass : 'CSSValueTypeConstraint',
	#instVars : [
		'n',
		'm'
	],
	#category : 'CSSParser-CSS',
	#package : 'CSSParser',
	#tag : 'CSS'
}

{ #category : 'accessing' }
CSSValueTypeNToMOf class >> isSimple [

	^false
]

{ #category : 'instance creation' }
CSSValueTypeNToMOf class >> readFrom: in [

	in peek = ${ ifTrue:
	[
		| s n m |
		s := (in upTo: $}) findTokens: ', {}'.
		n := s first asNumber.
		m := s last asNumber.
		^((CSSValueTypeNToMOf new n: n) m: m)
	].
	^nil
]

{ #category : 'accessing' }
CSSValueTypeNToMOf class >> type [

	^${
]

{ #category : 'accessing' }
CSSValueTypeNToMOf >> addValues: aCollection fromStream: in [

	| pos |
	"At least n"
	n timesRepeat: 
	[
		pos := in position. 
		(self type addValues: aCollection fromStream: in) ifFalse: [in position: pos. ^false]
	].

	"Fulfilled the minimum - read up to m elements - result is success"
	m-n timesRepeat:
	[
		pos := in position.
		(self type addValues: aCollection fromStream: in) ifFalse: [in position: pos. ^true]
	].
	^true
]

{ #category : 'accessing' }
CSSValueTypeNToMOf >> m [
	"Answer the value of m"

	^ m
]

{ #category : 'accessing' }
CSSValueTypeNToMOf >> m: anObject [
	"Set the value of m"

	m := anObject
]

{ #category : 'accessing' }
CSSValueTypeNToMOf >> n [
	"Answer the value of n"

	^ n
]

{ #category : 'accessing' }
CSSValueTypeNToMOf >> n: anObject [
	"Set the value of n"

	n := anObject
]

{ #category : 'printing' }
CSSValueTypeNToMOf >> printOn: aStream [

	type printOn: aStream.
	aStream nextPut: ${; 
		nextPutAll: self n asString; 
		nextPut: $,; 
		nextPutAll: self m asString; 
		nextPut: $}.
]
