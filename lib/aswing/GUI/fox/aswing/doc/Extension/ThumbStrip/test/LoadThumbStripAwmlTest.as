/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.awml.AwmlLoader;
import org.aswing.awml.AwmlManager;
import org.aswing.awml.ParserFactory;
import org.aswing.JWindow;
import org.aswing.thumbstrip.awml.LoadThumbStripParser;

/**
 * AWML test class.
 *
 * @author Igor Sadovskiy
 */
class LoadThumbStripAwmlTest  {

    public static function main():Void{
        Stage.scaleMode = "noScale";
        Stage.align = "T";
        
        try{
            trace("try LoadThumbStripAwmlTest");
            var p:LoadThumbStripAwmlTest = new LoadThumbStripAwmlTest();
        }catch(e){
            trace("error : " + e);
        }
    }

    private var frame:JWindow;
    private var loader:AwmlLoader;
        
    public function LoadThumbStripAwmlTest() {
    	
    	ParserFactory.put("its", LoadThumbStripParser, ParserFactory.COMPONENT);
    	
        loader = new AwmlLoader(true);
        loader.addActionListener(onAwmlInit, this);
        loader.load("../res/its.xml");
    }
    
    private function onAwmlInit(loader:AwmlLoader):Void {
    	
    	try{
    		
	        frame = AwmlManager.getWindow("frame");
	        frame.setLocation(100, 100);
	        frame.show();
	        
	        //ImageThumbStrip(AwmlManager.getComponent("thumb")).setScrollBarPosition(ImageThumbStrip.SCROLLBAR_RIGHT);
	        
	        trace("done LoadThumbStripAwmlTest");
		}catch(e){
            trace("error : " + e);
        }	        
    } 
        
}
