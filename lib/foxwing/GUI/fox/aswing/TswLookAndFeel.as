import GUI.fox.aswing.tswlaf.CheckBoxIcon;
import GUI.fox.aswing.tswlaf.TitleBarUI;
import GUI.fox.aswing.plaf.asw.ASWingLookAndFeel;
import GUI.fox.aswing.UIDefaults;
import GUI.fox.aswing.plaf.ASFontUIResource;
/**
 * ...
 * @author Sykja
 Modified by Fox
 */
class GUI.fox.aswing.TswLookAndFeel extends ASWingLookAndFeel
{
	var changes:String = "";
	public function TswLookAndFeel() 
	{
		super();
	}
	
	public function getDefaults():UIDefaults
	{
		var table:UIDefaults = super.getDefaults();
		var keys:Array = table.keys().sort();
		var transformed = { };
		
		for(var i = 0; i < keys.length; ++i)
		{
			var value = table.get(keys[i]);
			if (value["getRGB"] && !transformed[value])
			{
				var col = value["getRGB"]();
				var newcol = 0xFFFFFF - col;
				//var newcolres = new ASColorUIResource(newcol, value["getAlpha"]());
				//table.put(keys[i], newcolres);
				changes += "C " + keys[i] + " changed from " + value + " to ";
				value["setRGB"](newcol);
				transformed[value] = true;
				//table.put(keys[i], value);
				changes += value + "\n";
			}
			else
			{
				changes += "- "+keys[i] + " kept " + value + "\n";
			}
		}
		table.put("Frame.titleBarUI", TitleBarUI);//Removes maximize button from the titlebar
		table.put("CheckBox.icon", CheckBoxIcon);
		
		///replace tahoma with standardfont
		var Font:ASFontUIResource = new ASFontUIResource("_StandardFont", 11);
		table.put("Frame.font", Font);
		table.put("Button.font", Font);
		table.put("ToggleButton.font", Font);
		table.put("RadioButton.font", Font);
		table.put("CheckBox.font", Font);
		table.put("TabbedPane.font", Font);
		table.put("ScrollBar.font", Font);
		table.put("Label.font", Font);
		table.put("ToolTip.font", Font);
		table.put("List.font", Font);
		table.put("TextField.font", Font);
		table.put("TextArea.font", Font);
		table.put("ComboBox.font", Font);
		table.put("Table.font", Font);
		table.put("TableHeader.font", Font);
		table.put("Slider.font", Font);
		table.put("Adjuster.font", Font);
		table.put("ColorSwatches.font", Font);
		table.put("ColorMixer.font", Font);
		table.put("ColorChooser.font", Font);
		table.put("Tree.font", Font);
		table.put("MenuItem.font", Font);
		table.put("MenuItem.acceleratorFont", Font);
		table.put("CheckBoxMenuItem.font", Font);
		table.put("CheckBoxMenuItem.acceleratorFont", Font);
		table.put("RadioButtonMenuItem.font", Font);
		table.put("RadioButtonMenuItem.acceleratorFont", Font);
		table.put("Menu.font", Font);
		table.put("Menu.acceleratorFont", Font);
		table.put("PopupMenu.font", Font);
		table.put("MenuBar.font", Font);
		table.put("SplitPane.font", Font);
		return table;
	}
}