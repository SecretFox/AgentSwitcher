/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.ToggleButtonModel;
 
/**
 * The RadioButton model
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.RadioButtonModel extends ToggleButtonModel{

    /**
     * Creates a new RadioButton Model
     */
    public function RadioButtonModel() {
    	super();
    	allowUnselectAllInGroup = false;
    }

}
