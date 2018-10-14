/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.BorderLayout;
import org.aswing.Container;
import org.aswing.JScrollPane;
import org.aswing.richtext.RichTextArea;
import org.aswing.richtext.RichTextEditorToolBar;

/**
 * RichTextEditor contains a <code>RichTextArea</code> and a <code>RichTextEditorToolBar</code> 
 * to make user can edite texts.
 * 
 * @author iiley
 */
class org.aswing.richtext.RichTextEditor extends Container {
	private var toolBar:RichTextEditorToolBar;
	private var textArea:RichTextArea;
	
	public function RichTextEditor() {
		super();
		setLayout(new BorderLayout());
		
		toolBar = new RichTextEditorToolBar();
		textArea = new RichTextArea();
		
		append(toolBar, BorderLayout.NORTH);
		append(new JScrollPane(textArea), BorderLayout.CENTER);
		
		textArea.addConnectionToEditorToolBar(toolBar);
	}
	
	public function getRichTextArea():RichTextArea{
		return textArea;
	}
	
	public function getRichEditorToolBar():RichTextEditorToolBar{
		return toolBar;
	}
}