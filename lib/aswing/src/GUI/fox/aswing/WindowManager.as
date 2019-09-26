import GUI.fox.aswing.ASWingUtils;
import GUI.fox.aswing.BorderLayout;
import GUI.fox.aswing.MCPanel;

/**
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.WindowManager extends MCPanel {
	
	private static var instance:WindowManager;
	
	public static function getInstance():WindowManager {
		if (instance == null) {
			instance = new WindowManager();
		}
		return instance;
	}
	
	private function WindowManager(Void) {
		super(ASWingUtils.getRootMovieClip(), Stage.width, Stage.height);
		setLayout(new BorderLayout());
		Stage.addListener(createEventListener("onResize", onStageResize, this));
	}

	private function onStageResize():Void {
		bounds.width = Stage.width;
		bounds.height = Stage.height;	
		revalidate();
	}
}