/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.plaf.basic.BasicTextAreaUI;


class com.f1sr.aswing.plaf.spring.SaladTextAreaUI extends BasicTextAreaUI {
	
	private var saladTextAreaUI:SaladTextAreaUI;
	
	public function createInstance():SaladTextAreaUI{
		if(saladTextAreaUI == null){
			saladTextAreaUI = new SaladTextAreaUI();
		}
		return saladTextAreaUI;
	}
	
	public function SaladTextAreaUI() {
		super();
	}

}