import GUI.fox.aswing.tswlaf.CheckBoxIcon;
import GUI.fox.aswing.tswlaf.TitleBarUI;
import GUI.fox.aswing.plaf.asw.ASWingLookAndFeel;
import GUI.fox.aswing.UIDefaults;
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
		
		table.put("CheckBox.icon", CheckBoxIcon);
		table.put("Frame.titleBarUI", TitleBarUI);//Removes maximize button from the titlebar

		
		return table;
	}
}