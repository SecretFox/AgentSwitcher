/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/

import org.aswing.plaf.basic.BasicTextFieldUI;


class com.f1sr.aswing.plaf.spring.SaladTextFieldUI extends BasicTextFieldUI {
	
	private var saladTextUI:SaladTextFieldUI;
	
	public function createInstance():SaladTextFieldUI{
		if(saladTextUI == null){
			saladTextUI = new SaladTextFieldUI();
		}
		return saladTextUI;
	}
	
	public function SaladTextFieldUI() {
		super();
	}

}
