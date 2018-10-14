/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.Container;
import org.aswing.JFrame;
import org.aswing.JScrollPane;
import org.aswing.richtext.RichTextArea;
import org.aswing.SoftBox;

/**
 * @author iiley
 */
class test.richtext.RichTextTest extends JFrame {
	

	public function RichTextTest() {
		super("RichTextTest");
		
		var pane:Container = SoftBox.createVerticalBox(2);
		var o:Object = pane;
		o.isTracksViewportWidth = function(){ return true; };
		
		var area:RichTextArea = new RichTextArea();
		area.setHtmlText("<P ALIGN='LEFT'><FONT FACE='Times New Roman' SIZE='12' COLOR='#FF0000' LETTERSPACING='0' KERNING='0'>1. This is a test one line with red color!<FONT COLOR='#0B333C'></FONT></FONT></P><P ALIGN='LEFT'><FONT FACE='Times New Roman' SIZE='20' COLOR='#0B333C' LETTERSPACING='0' KERNING='0'>2. This is second line with bold and italic and size 20.<FONT SIZE='12'></FONT></FONT></P><P ALIGN='LEFT'><FONT FACE='Courier New' SIZE='20' COLOR='#0B333C' LETTERSPACING='0' KERNING='0'>3. This is third line with another font.</FONT></P>");
		pane.append(area);
		
		area = new RichTextArea();
		area.setHtmlText("<P ALIGN='LEFT'><FONT FACE='Times New Roman' SIZE='22' COLOR='#FF0000' LETTERSPACING='0' KERNING='0'>1. This is a test one line with red color!<FONT COLOR='#0B333C'></FONT></FONT></P><P ALIGN='LEFT'><FONT FACE='Times New Roman' SIZE='30' COLOR='#0B333C' LETTERSPACING='0' KERNING='0'>2. This is second line with bold and italic and size 30.<FONT SIZE='12'></FONT></FONT></P><P ALIGN='LEFT'><FONT FACE='Courier New' SIZE='30' COLOR='#0B333C' LETTERSPACING='0' KERNING='0'>3. This is third line with another font.</FONT></P>");
		pane.append(area);
		
		setContentPane(new JScrollPane(pane));
	}

	
    public static function main():Void{
        Stage.scaleMode = "noScale";
        Stage.align = "TL";
        try{
            trace("try UBBTextEditorTest");
            var p:RichTextTest = new RichTextTest();
            p.setLocation(50, 50);
            p.setSize(500, 350);
            p.show();
            trace("done UBBTextEditorTest");
        }catch(e){
            trace("error : " + e);
        }
    }
}