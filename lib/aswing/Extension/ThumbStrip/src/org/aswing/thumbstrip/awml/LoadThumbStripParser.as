import org.aswing.awml.AwmlNamespace;
import org.aswing.thumbstrip.awml.ThumbStripParser;
import org.aswing.thumbstrip.LoadThumbStrip;

/**
 * @author Igor Sadovskiy
 */
class org.aswing.thumbstrip.awml.LoadThumbStripParser extends ThumbStripParser {
	
	private static var ATTR_BASE_URL:String = "base-url";
	private static var ATTR_USE_BASE_URL:String = "use-base-url";
	private static var ATTR_USE_URL_AS_TITLE:String = "use-url-as-title";
	private static var ATTR_LOAD_MODE:String = "load-mode";
	private static var ATTR_PARTIAL_LOAD_AMOUNT:String = "partial-load-amount";
	
	private static var LOAD_MODE_ALL:String = "all";
	private static var LOAD_MODE_PARTIAL:String = "partial";
	private static var LOAD_MODE_VISIBLE:String = "visible";
	
	public function LoadThumbStripParser(Void) {
		super();
	}

    public function parse(awml:XMLNode, its:LoadThumbStrip, namespace:AwmlNamespace) {
    	
    	if (its == null) {
    		its = new LoadThumbStrip();	
    	} 
    	
        super.parse(awml, its, namespace);
        
		its.setBaseUrl(getAttributeAsString(awml, ATTR_BASE_URL, its.getBaseUrl()));
		its.setUseBaseUrl(getAttributeAsBoolean(awml, ATTR_USE_BASE_URL, its.isUseBaseUrl()));
		its.setUseUrlAsTitle(getAttributeAsBoolean(awml, ATTR_USE_URL_AS_TITLE, its.isUseUrlAsTitle()));
        its.setPartialLoadAmount(getAttributeAsNumber(awml, ATTR_PARTIAL_LOAD_AMOUNT, its.getPartialLoadAmount()));
        
        var loadMode:String = getAttributeAsString(awml, ATTR_LOAD_MODE, null);
        switch (loadMode) {
        	case LOAD_MODE_ALL:
        		its.setImageLoadMode(LoadThumbStrip.LOAD_ALL);
        		break; 	
        	case LOAD_MODE_PARTIAL:
        		its.setImageLoadMode(LoadThumbStrip.LOAD_PARTIAL);
        		break; 	
        	case LOAD_MODE_VISIBLE:
        		its.setImageLoadMode(LoadThumbStrip.LOAD_VISIBLE);
        		break; 	
        }
        
        // TODO image list
        // TODO selection
        
        return its;
	}

}