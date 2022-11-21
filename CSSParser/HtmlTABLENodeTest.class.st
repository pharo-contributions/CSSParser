Class {
	#name : #HtmlTABLENodeTest,
	#superclass : #TestCase,
	#category : #'CSSParser-Tests'
}

{ #category : #testing }
HtmlTABLENodeTest >> test01TableShouldRenderAsHtmlTableMorph [

	self assert: HtmlTABLENode new getHtmlBlockMorph class equals: HtmlTableMorph
]

{ #category : #testing }
HtmlTABLENodeTest >> test02TableElementsInColumnShouldHaveSameXPositions [
| document table |
	document := HtmlDocument new.
	document parseContents: 
		(ReadStream on: '<table>
			<tr><td>First</td><td>Second item</td></tr>
			<tr><td>Third item</td><td>Fourth</td></tr>
			</table>').
	table := document children first getHtmlBlockMorph.
	table layoutInBounds: table bounds.
	self assert: table children first bounds origin x equals: table children third bounds origin x.
	self assert: table children second bounds origin x equals: table children fourth bounds origin x.
]

{ #category : #testing }
HtmlTABLENodeTest >> test03TableElementsInRowsShouldHaveSameYPositions [
| document table |
	document := HtmlDocument new.
	document parseContents: 
		(ReadStream on: '<table>
			<tr><td>First</td><td>Second item</td></tr>
			<tr><td>Third item</td><td>Fourth</td></tr>
			</table>').
	table := document children first getHtmlBlockMorph.
	table layoutInBounds: table bounds.
	self assert: table children first bounds origin y equals: table children second bounds origin y.
	self assert: table children third bounds origin y equals: table children fourth bounds origin y.
]

{ #category : #testing }
HtmlTABLENodeTest >> test04TableWithUnknownTagShouldntRaiseErrors [
	| document |
	document := HtmlDocument new.
	document parseContents: 
		(ReadStream on: '<table border="1">
            <caption>a caption for a table</caption>
            <tr>
                <td><i>italic text in a td cell</i></td>
            </tr>
        </table>').
	self shouldnt: [document children first getHtmlBlockMorph] raise: Error.
]
