/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.FlowLayout;
import org.aswing.JButton;
import org.aswing.JCheckBox;
import org.aswing.JFrame;
import org.aswing.JRadioButton;
import org.aswing.JSlider;
import org.aswing.JTextArea;
import org.aswing.JTextField;
import org.aswing.UIManager;

import com.iiley.aswing.laf.comeny.ComenyLookAndFeel;

/**
 * @author iiley
 */
class test.Test extends JFrame {
	private var button1:JButton;
	private var button2:JButton;
	
	public function Test(){
		super("Comeny LAF");
		
		button1 = new JButton("Button 1");
		button2 = new JButton("Button 2");
		//button2.setEnabled(false);
		getContentPane().setLayout(new FlowLayout());
		getContentPane().append(button1);
		getContentPane().append(button2);
		getContentPane().append(new JTextField("", 8));
		getContentPane().append(new JTextArea("", 3, 8));
		
		var radio1:JRadioButton = new JRadioButton("Radio1");
		var radio2:JRadioButton = new JRadioButton("Radio2");
		radio2.setEnabled(false);
		radio2.setSelected(true);
		getContentPane().append(radio1);
		getContentPane().append(radio2);
		
		var check1:JCheckBox = new JCheckBox("JCheckBox1");
		var check2:JCheckBox = new JCheckBox("JCheckBox2");
		check1.setEnabled(false);
		check1.setSelected(true);
		getContentPane().append(check1);
		getContentPane().append(check2);
		
		var slider:JSlider = new JSlider();
		getContentPane().append(slider);
	}
	
	
	/**
	 * @param args
	 */
	public static function main():Void {
		Stage.scaleMode = "noScale";
		trace("Test trace");
		try{
			UIManager.setLookAndFeel(new ComenyLookAndFeel());
			var fj:Test = new Test();
			fj.setBounds(10, 10, 400, 360);
			fj.setVisible(true);
		}catch(e:Error){
			trace("/e/ Error : " + e);
		}
	}

}