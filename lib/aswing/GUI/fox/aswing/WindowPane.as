import GUI.fox.aswing.BorderLayout;
import GUI.fox.aswing.Container;
import GUI.fox.aswing.LayoutManager;

/**
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.WindowPane extends Container {
	
	function WindowPane(layout:LayoutManager) {
		super();
		
		if (layout == undefined) layout = new BorderLayout();
		setLayout(layout);
		//setBorder(new LineBorder(null, ASColor.BLUE));
		setClipMasked(false);
	}

}