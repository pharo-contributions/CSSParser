Extension { #name : #Color }

{ #category : #'*CSSParser' }
Color class >> fromColorName: aString [
	(self rgbOf: aString) ifNotNil: [:rgb | ^Color r: rgb first / 255 g: rgb second / 255 b: rgb third / 255].
	^nil
]

{ #category : #'*CSSParser' }
Color class >> fromHTMLString: aString [
	(self fromColorName: aString) ifNotNil: [:color | ^color].
	(self fromHexRGBString: aString) ifNotNil: [:color | ^color].
	(self fromRGBPercentageFunction: aString) ifNotNil: [:color | ^color].
	(self fromRGBFunction: aString) ifNotNil: [:color | ^color].
	^ self fromString: aString
]

{ #category : #'*CSSParser' }
Color class >> fromHexRGBString: aString [
	| aColorHex |
	aString isEmptyOrNil ifTrue: [ ^nil ].
	aString first = $#
		ifTrue: [ aColorHex := aString allButFirst ]
		ifFalse: [ aColorHex := aString ].
		(aColorHex allSatisfy: [ :each | '0123456789ABCDEFabcdef' includes: each ])
			ifFalse: [ ^ nil ].

		(aColorHex size = 3)
			ifTrue: [
				| green red blue |
				red := (Integer readFrom: (aColorHex first: 1) base: 16) / 15.
				green := (Integer readFrom: (aColorHex copyFrom: 2 to: 2) base: 16) / 15.
				blue := (Integer readFrom: (aColorHex last: 1) base: 16) / 15.
				^self r: red g: green b: blue ].
		(aColorHex size = 6)
			ifTrue: [
				| green red blue |
				red := (Integer readFrom: (aColorHex first: 2) base: 16) / 255.
				green := (Integer readFrom: (aColorHex copyFrom: 3 to: 4) base: 16) / 255.
				blue := (Integer readFrom: (aColorHex last: 2) base: 16) / 255.
				^self r: red g: green b: blue ].

	^nil
]

{ #category : #'*CSSParser' }
Color class >> fromRGBFunction: aString [
	|r g b splitString|
	(aString beginsWith: 'rgb') ifTrue: 
	[splitString := aString substrings: ','.
	r := (splitString first trimBoth asInteger clampLow: 0 high: 255) / 255.
	g := (splitString second trimBoth asInteger clampLow: 0 high: 255) / 255.
	b := (splitString third trimBoth asInteger clampLow: 0 high: 255) / 255. 
	^ Color r: r g: g b: b.].
	^nil
	
]

{ #category : #'*CSSParser' }
Color class >> fromRGBPercentageFunction: aString [
	|r g b splitString|
	('*%*' match:  aString) ifTrue: 
	[splitString := aString substrings: ','.
	r := (splitString first trimBoth asInteger clampLow: 0 high: 100) / 100.
	g := (splitString second trimBoth asInteger clampLow: 0 high: 100) / 100.
	b := (splitString third trimBoth asInteger clampLow: 0 high: 100) / 100.
	^ Color r: r g: g b: b.].
	^nil
	
]

{ #category : #'*CSSParser' }
Color class >> htmlColors1 [
	| htmlcolors |
	
	htmlcolors := Dictionary new.
	htmlcolors
		add: 'aliceblue'->#(240 248 255);
		add: 'antiquewhite'->#(250 235 215);
		add: 'aqua'->#(0 255 255);
		add: 'aquamarine'->#(127 255 212);
		add: 'azure'->#(240 255 255);
		add: 'beige'->#(245 245 220);
		add: 'bisque'->#(255 228 196);
		add: 'black'->#(0 0 0);
		add: 'blanchedalmond'->#(255 235 205);
		add: 'blue'->#(0 0 255);
		add: 'blueviolet'->#(138 43 226);
		add: 'brown'->#(165 42 42);
		add: 'burlywood'->#(222 184 135);
		add: 'cadetblue'->#(95 158 160);
		add: 'chartreuse'->#(127 255 0);
		add: 'chocolate'->#(210 105 30);
		add: 'coral'->#(255 127 80);
		add: 'cornflowerblue'->#(100 149 237);
		add: 'cornsilk'->#(255 248 220);
		add: 'crimson'->#(220 20 60);
		add: 'cyan'->#(0 255 255);
		add: 'darkblue'->#(0 0 139);
		add: 'darkcyan'->#(0 139 139);
		add: 'darkgoldenrod'->#(184 134 11);
		add: 'darkgray'->#(169 169 169);
		add: 'darkgreen'->#(0 100 0);
		add: 'darkgrey'->#(169 169 169);
		add: 'darkkhaki'->#(189 183 107);
		add: 'darkmagenta'->#(139 0 139);
		add: 'darkolivegreen'->#(85 107 47);
		add: 'darkorange'->#(255 140 0);
		add: 'darkorchid'->#(153 50 204);
		add: 'darkred'->#(139 0 0);
		add: 'darksalmon'->#(233 150 122);
		add: 'darkseagreen'->#(143 188 143);
		add: 'darkslateblue'->#(72 61 139);
		add: 'darkslategray'->#(47 79 79);
		add: 'darkslategrey'->#(47 79 79);
		add: 'darkturquoise'->#(0 206 209);
		add: 'darkviolet'->#(148 0 211);
		add: 'deeppink'->#(255 20 147);
		add: 'deepskyblue'->#(0 191 255);
		add: 'dimgray'->#(105 105 105);
		add: 'dimgrey'->#(105 105 105);
		add: 'dodgerblue'->#(30 144 255);
		add: 'firebrick'->#(178 34 34);
		add: 'floralwhite'->#(255 250 240);
		add: 'forestgreen'->#(34 139 34);
		add: 'fuchsia'->#(255 0 255);
		add: 'gainsboro'->#(220 220 220);
		add: 'ghostwhite'->#(248 248 255);
		add: 'gold'->#(255 215 0);
		add: 'goldenrod'->#(218 165 32);
		add: 'gray'->#(128 128 128);
		add: 'green'->#(0 128 0);
		add: 'greenyellow'->#(173 255 47);
		add: 'grey'->#(128 128 128);
		add: 'honeydew'->#(240 255 240);
		add: 'hotpink'->#(255 105 180);
		add: 'indianred'->#(205 92 92);
		add: 'indigo'->#(75 0 130);
		add: 'ivory'->#(255 255 240);
		add: 'khaki'->#(240 230 140);
		add: 'lavender'->#(230 230 250);
		add: 'lavenderblush'->#(255 240 245);
		add: 'lawngreen'->#(124 252 0);
		add: 'lemonchiffon'->#(255 250 205);
		add: 'lightblue'->#(173 216 230);
		add: 'lightcoral'->#(240 128 128);
		add: 'lightcyan'->#(224 255 255);
		add: 'lightgoldenrodyellow'->#(250 250 210);
		add: 'lightgray'->#(211 211 211);
		add: 'lightgreen'->#(144 238 144);
		add: 'lightgrey'->#(211 211 211);
		add: 'lightpink'->#(255 182 193);
		add: 'lightsalmon'->#(255 160 122);
		add: 'lightseagreen'->#(32 178 170);
		add: 'lightskyblue'->#(135 206 250);
		add: 'lightslategray'->#(119 136 153);
		add: 'lightslategrey'->#(119 136 153);
		add: 'lightsteelblue'->#(176 196 222);
		add: 'lightyellow'->#(255 255 224);
		add: 'lime'->#(0 255 0);
		add: 'limegreen'->#(50 205 50);
		add: 'linen'->#(250 240 230);
		add: 'magenta'->#(255 0 255);
		add: 'maroon'->#(128 0 0);
		add: 'mediumaquamarine'->#(102 205 170);
		add: 'mediumblue'->#(0 0 205);
		add: 'mediumorchid'->#(186 85 211);
		add: 'mediumpurple'->#(147 112 219);
		add: 'mediumseagreen'->#(60 179 113);
		add: 'mediumslateblue'->#(123 104 238);
		add: 'mediumspringgreen'->#(0 250 154);
		add: 'mediumturquoise'->#(72 209 204);
		add: 'mediumvioletred'->#(199 21 133);
		add: 'midnightblue'->#(25 25 112);
		add: 'mintcream'->#(245 255 250);
		add: 'mistyrose'->#(255 228 225);
		add: 'moccasin'->#(255 228 181);
		add: 'navajowhite'->#(255 222 173);
		add: 'navy'->#(0 0 128);
		add: 'oldlace'->#(253 245 230);
		add: 'olive'->#(128 128 0);
		add: 'olivedrab'->#(107 142 35);
		add: 'orange'->#(255 165 0);
		add: 'orangered'->#(255 69 0);
		add: 'orchid'->#(218 112 214);
		add: 'palegoldenrod'->#(238 232 170);
		add: 'palegreen'->#(152 251 152);
		add: 'paleturquoise'->#(175 238 238);
		add: 'palevioletred'->#(219 112 147);
		add: 'papayawhip'->#(255 239 213);
		add: 'peachpuff'->#(255 218 185);
		add: 'peru'->#(205 133 63);
		add: 'pink'->#(255 192 203);
		add: 'plum'->#(221 160 221);
		add: 'powderblue'->#(176 224 230);
		add: 'purple'->#(128 0 128);
		add: 'red'->#(255 0 0);
		add: 'rosybrown'->#(188 143 143);
		add: 'royalblue'->#(65 105 225);
		add: 'saddlebrown'->#(139 69 19);
		add: 'salmon'->#(250 128 114);
		add: 'sandybrown'->#(244 164 96);
		add: 'seagreen'->#(46 139 87);
		add: 'seashell'->#(255 245 238);
		add: 'sienna'->#(160 82 45);
		add: 'silver'->#(192 192 192).
	^ htmlcolors
]

{ #category : #'*CSSParser' }
Color class >> htmlColors2 [
	| htmlcolors |
	
	htmlcolors := Dictionary new.
	htmlcolors
		add: 'skyblue'->#(135 206 235);
		add: 'slateblue'->#(106 90 205);
		add: 'slategray'->#(112 128 144);
		add: 'slategrey'->#(112 128 144);
		add: 'snow'->#(255 250 250);
		add: 'springgreen'->#(0 255 127);
		add: 'steelblue'->#(70 130 180);
		add: 'tan'->#(210 180 140);
		add: 'teal'->#(0 128 128);
		add: 'thistle'->#(216 191 216);
		add: 'tomato'->#(255 99 71);
		add: 'turquoise'->#(64 224 208);
		add: 'violet'->#(238 130 238);
		add: 'wheat'->#(245 222 179);
		add: 'white'->#(255 255 255);
		add: 'whitesmoke'->#(245 245 245);
		add: 'yellow'->#(255 255 0);
		add: 'yellowgreen'->#(154 205 50).
	 ^ htmlcolors
]

{ #category : #'*CSSParser' }
Color class >> rgbOf: aColorName [
	"Look in all lists as only 255 literals fit into one dictionary."
	(self htmlColors1 at: aColorName asLowercase ifAbsent: [nil]) ifNotNil: [ :rgb | ^ rgb].
	(self htmlColors2 at: aColorName asLowercase ifAbsent: [nil]) ifNotNil: [ :rgb | ^ rgb].
	^nil
]
