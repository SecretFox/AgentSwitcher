import org.aswing.AbstractButton;
import org.aswing.BorderLayout;
import org.aswing.Container;
import org.aswing.Event;
import org.aswing.JButton;
import org.aswing.JFrame;
import org.aswing.JScrollPane;
import org.aswing.JTextArea;
import org.aswing.SoftBoxLayout;
import org.aswing.geom.Rectangle;
import org.aswing.ASWingUtils;
/**
 * @author Hukuang
 */
class ThisWindTest {
	
	public static function main(root:MovieClip) :Void {
		// buttons frame
		var buttonsframe:JFrame = new JFrame("Log a item.", null, true);
		
		var c:Container = buttonsframe.getContentPane();
		c.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
		
		var debug:JButton = new JButton("DEBUG");
		var info:JButton = new JButton("INFO");
		var warnning:JButton = new JButton("WARNNING");
		var severe:JButton = new JButton("SEVERE");
		
		c.append(debug);
		c.append(info);
		c.append(warnning);
		c.append(severe);
		
		debug.addEventListener(AbstractButton.ON_RELEASE, function (e:Event) {
			trace ("Debug : a DEBUG message\nmulti-line");
		});
		info.addEventListener(AbstractButton.ON_RELEASE, function (e:Event) {
			trace ("Info : a INFO message");
		});
		warnning.addEventListener(AbstractButton.ON_RELEASE, function (e:Event) {
			trace ("Warnning : a WARNNING message");
		});
		severe.addEventListener(AbstractButton.ON_RELEASE, function (e:Event) {
			trace ("Severe : a SEVERE message");
		});
		
		buttonsframe.pack();
		buttonsframe.setVisible(true);
		
		// custom frame
		var customframe:JFrame = new JFrame("log your custom message");
		var customTA:JTextArea = new JTextArea("warn:Input your custom message here", 3, 30);
		var customBtn:JButton = new JButton("Log custom message");
		
		var c2:Container = customframe.getContentPane();
		c2.append(new JScrollPane(customTA), BorderLayout.CENTER);
		c2.append(customBtn, BorderLayout.SOUTH);
		
		customBtn.addEventListener(AbstractButton.ON_RELEASE, function (e:Event) {
			trace (customTA.getText());
		});
		
		customframe.pack();
		var bounds:Rectangle = ASWingUtils.getVisibleMaximizedBounds();
		customframe.setLocation(bounds.width-customframe.getWidth(), 0);//set to top-right
		customframe.setVisible(true);
	}
}
