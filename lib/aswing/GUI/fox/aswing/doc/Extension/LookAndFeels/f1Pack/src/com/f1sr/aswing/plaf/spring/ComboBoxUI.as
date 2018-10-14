/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.ASColor;
import org.aswing.border.LineBorder;
import org.aswing.JScrollPane;
import org.aswing.plaf.basic.BasicComboBoxUI;



 
class com.f1sr.aswing.plaf.spring.ComboBoxUI extends BasicComboBoxUI
{
	
    /**
     * Just override this method if you want other LAF drop down buttons.
     */
   
    
    private function getScollPane():JScrollPane{
    	if(scollPane == null){
    		scollPane = new JScrollPane(getPopupList());
    		scollPane.setBorder(new LineBorder(null,new ASColor(0x085004,100)));
    		scollPane.setOpaque(true);
    	}
    	return scollPane;
    }    
    

}