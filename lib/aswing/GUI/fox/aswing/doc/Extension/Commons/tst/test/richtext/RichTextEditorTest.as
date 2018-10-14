/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.BorderLayout;
import org.aswing.Box;
import org.aswing.Container;
import org.aswing.debug.console.BuildInConsole;
import org.aswing.JButton;
import org.aswing.JFrame;
import org.aswing.JScrollPane;
import org.aswing.JTextArea;
import org.aswing.richtext.RichTextArea;
import org.aswing.richtext.RichTextEditorToolBar;

/**
 * @author iiley
 */
class test.richtext.RichTextEditorTest extends JFrame {
	
	private var textArea:RichTextArea;
	
	public function RichTextEditorTest() {
		super("RichTextEditorTest");
		
		var toolBar:RichTextEditorToolBar = new RichTextEditorToolBar();
		var textArea1:RichTextArea = new RichTextArea();
		var textArea2:RichTextArea = new RichTextArea();
		textArea1.addConnectionToEditorToolBar(toolBar);
		textArea2.addConnectionToEditorToolBar(toolBar);
		
		getContentPane().append(toolBar, BorderLayout.NORTH);
		
		var pane:Container = Box.createVerticalBox(2);
		pane.append(new JScrollPane(textArea1));
		pane.append(new JScrollPane(textArea2));
		
		getContentPane().append(pane, BorderLayout.CENTER);
		
		textArea = textArea1;
		var button:JButton = new JButton("View Html Text");
		button.addActionListener(__viewHtmlText, this);
		getContentPane().append(button, BorderLayout.SOUTH);
	}

	private function __viewHtmlText() : Void {
		var frame:JFrame = new JFrame("Html Text");
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		var text:JTextArea = new JTextArea(textArea.getHtmlText(), 10, 20);
		text.setWordWrap(true);
		frame.setContentPane(new JScrollPane(text));
		frame.pack();
		frame.show();
	}
	
    public static function main():Void{
        Stage.scaleMode = "noScale";
        Stage.align = "TL";
        try{
            trace("try RichTextEditorTest");
            var p:RichTextEditorTest = new RichTextEditorTest();
            p.setLocation(50, 50);
            p.setSize(400, 350);
            p.show();
            trace("done RichTextEditorTest");
            
            BuildInConsole.info("test info");
            BuildInConsole.debug("test bebug");
            BuildInConsole.warnning("test warnning");
            BuildInConsole.error("test error");
            BuildInConsole.showConsoleDialog(_root);
        }catch(e){
            trace("error : " + e);
        }
    }

}