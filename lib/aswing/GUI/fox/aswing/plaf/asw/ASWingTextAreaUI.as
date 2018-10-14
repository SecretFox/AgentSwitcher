import GUI.fox.aswing.plaf.basic.BasicTextAreaUI;

/**
 * @author Tomato
 */
class GUI.fox.aswing.plaf.asw.ASWingTextAreaUI extends BasicTextAreaUI {
	
	private var asWingTextAreaUI:ASWingTextAreaUI;
	
	public function createInstance():ASWingTextAreaUI{
		if(asWingTextAreaUI == null){
			asWingTextAreaUI = new ASWingTextAreaUI();
		}
		return asWingTextAreaUI;
	}
	
	public function ASWingTextAreaUI() {
		super();
	}

}