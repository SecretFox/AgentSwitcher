import org.aswing.border.TitledBorder;
import org.aswing.BorderLayout;
import org.aswing.ButtonGroup;
import org.aswing.FlowLayout;
import org.aswing.JButton;
import org.aswing.JFrame;
import org.aswing.JPanel;
import org.aswing.JRadioButton;
import org.aswing.JTextField;
import org.aswing.SoftBoxLayout;
import org.aswing.thumbstrip.LoadThumb;
import org.aswing.thumbstrip.LoadThumbStrip;
/**
 * @author Sadovskiy
 */
class LoadThumbStripTest {
	
	private static var instance:LoadThumbStripTest;
	
	public static function main(Void):Void {
		if (instance == null) {
			Stage.scaleMode = "noScale";
        	Stage.align = "TL";
			
			instance = new LoadThumbStripTest();
		} 
	}
	
	private var orientGroup:ButtonGroup;
	private var scrollPosGroup:ButtonGroup;
	
	private var frame:JFrame;
	private var mainPane:JPanel;
	private var thumb:LoadThumbStrip;
	private var centralPane:JPanel; 
	private var loadBtn:JButton;
	private var revalidateBtn:JButton;
	private var addBtn:JButton;
	private var orientPanel:JPanel;
	private var orientHoriz:JRadioButton;
	private var orientVert:JRadioButton;
	private var orientMulti:JRadioButton;
	private var scrollPosPanel:JPanel;
	private var scrollPosTop:JRadioButton;
	private var scrollPosLeft:JRadioButton;
	private var scrollPosRight:JRadioButton;
	private var scrollPosBottom:JRadioButton;
	private var selectionPanel:JPanel;
	private var selectionText:JTextField;
	
	private function LoadThumbStripTest(Void) {
		
		thumb = new LoadThumbStrip();
		thumb.setPreferredSize(200, 200);
		thumb.setThumbPreferredSize(200, 200);
		thumb.setHighlightEnabled(true);
		thumb.setUseUrlAsTitle(false);
		thumb.setPartialLoadAmount(3);
		thumb.setScrollBarPosition(LoadThumbStrip.SCROLLBAR_BOTTOM);
		thumb.setImageLoadMode(LoadThumbStrip.LOAD_ALL);
		thumb.addActionListener(onSelectionChanged, this);
		
		revalidateBtn = new JButton("Revalidate");
		revalidateBtn.addActionListener(onRevalidateClick, this);
		loadBtn = new JButton("Load");
		loadBtn.addActionListener(onLoadClick, this);
		addBtn = new JButton("Add");
		addBtn.addActionListener(onAddClick, this);
		
		orientHoriz = new JRadioButton("Horizontal");
		orientHoriz.setHorizontalAlignment(JRadioButton.LEFT);
		orientHoriz.addActionListener(doHorizontalOrientation, this);
		orientVert = new JRadioButton("Vertical");
		orientVert.setHorizontalAlignment(JRadioButton.LEFT);
		orientVert.addActionListener(doVerticalOrientation, this);
		orientMulti = new JRadioButton("Miltiline");
		orientMulti.setHorizontalAlignment(JRadioButton.LEFT);
		orientMulti.setEnabled(false);
		orientMulti.addActionListener(doMultilineOrientation, this);
		
		orientGroup = new ButtonGroup();
		orientGroup.append(orientHoriz);
		orientGroup.append(orientVert);
		orientGroup.append(orientMulti);
		orientHoriz.setSelected(true);
		
		orientPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
		orientPanel.setBorder(new TitledBorder(null, "Orientation"));
		orientPanel.append(orientHoriz);
		orientPanel.append(orientVert);
		orientPanel.append(orientMulti);

		scrollPosTop = new JRadioButton("Top");
		scrollPosTop.setHorizontalAlignment(JRadioButton.LEFT);
		scrollPosTop.addActionListener(doTopScrollPosition, this);
		scrollPosLeft = new JRadioButton("Left");
		scrollPosLeft.setHorizontalAlignment(JRadioButton.LEFT);
		scrollPosLeft.addActionListener(doLeftScrollPosition, this);
		scrollPosRight = new JRadioButton("Right");
		scrollPosRight.setHorizontalAlignment(JRadioButton.LEFT);
		scrollPosRight.addActionListener(doRightScrollPosition, this);
		scrollPosBottom = new JRadioButton("Bottom");
		scrollPosBottom.setHorizontalAlignment(JRadioButton.LEFT);
		scrollPosBottom.addActionListener(doBottomScrollPosition, this);
		
		scrollPosGroup = new ButtonGroup();
		scrollPosGroup.append(scrollPosTop);
		scrollPosGroup.append(scrollPosLeft);
		scrollPosGroup.append(scrollPosRight);
		scrollPosGroup.append(scrollPosBottom);
		scrollPosBottom.setSelected(true);
		
		scrollPosPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
		scrollPosPanel.setBorder(new TitledBorder(null, "Scroll Position"));
		scrollPosPanel.append(scrollPosTop);
		scrollPosPanel.append(scrollPosLeft);
		scrollPosPanel.append(scrollPosRight);
		scrollPosPanel.append(scrollPosBottom);
		
		selectionText = new JTextField();
		selectionText.setRestrict("0-9");
		selectionText.setPreferredSize(50,22);
		selectionText.addActionListener(onSelectionSet, this);
		
		selectionPanel = new JPanel(new FlowLayout());
		selectionPanel.setBorder(new TitledBorder(null, "Selection"));
		selectionPanel.append(selectionText);
		
		centralPane = new JPanel(new FlowLayout());
		centralPane.append(orientPanel);
		centralPane.append(scrollPosPanel);
		centralPane.append(selectionPanel);
		centralPane.append(loadBtn);
		centralPane.append(revalidateBtn);
		centralPane.append(addBtn);
		
		mainPane = new JPanel(new BorderLayout());
		mainPane.append(thumb, BorderLayout.SOUTH);
		mainPane.append(centralPane, BorderLayout.CENTER);
		
		frame = new JFrame(_root, "LoadThumbStripTest");
		frame.setState(JFrame.MAXIMIZED);
		frame.setResizable(true);
		frame.setClosable(false);
		frame.getContentPane().append(mainPane);
		
		frame.pack();
		frame.show();
		
		onLoadClick();
	}
	
	private function doHorizontalOrientation(Void):Void {
		thumb.setOrientation(LoadThumbStrip.HORIZONTAL);
	}

	private function doVerticalOrientation(Void):Void {
		thumb.setOrientation(LoadThumbStrip.VERTICAL);
	}

	private function doMultilineOrientation(Void):Void {
		thumb.setOrientation(LoadThumbStrip.BOTH);
	}

	private function doTopScrollPosition(Void):Void {
		thumb.setScrollBarPosition(LoadThumbStrip.SCROLLBAR_TOP);	
	}

	private function doLeftScrollPosition(Void):Void {
		thumb.setScrollBarPosition(LoadThumbStrip.SCROLLBAR_LEFT);	
	}

	private function doRightScrollPosition(Void):Void {
		thumb.setScrollBarPosition(LoadThumbStrip.SCROLLBAR_RIGHT);	
	}

	private function doBottomScrollPosition(Void):Void {
		thumb.setScrollBarPosition(LoadThumbStrip.SCROLLBAR_BOTTOM);	
	}
	
	private function onRevalidateClick(Void):Void {
		thumb.revalidate();
		thumb.repaint();	
	}
	
	private function onLoadClick(Void):Void {
		thumb.setBaseUrl("../res");
		thumb.setUseBaseUrl(true);
		//thumb.setImages(["image1.jpg", "image2.jpg", "image1.jpg", "image2.jpg", "image1.jpg", "image2.jpg", "image1.jpg"]);
		//thumb.setTitles(["test", "test2 test2 test2 test2"]);
	}
	
	public function onSelectionChanged(Void):Void {
		selectionText.setText(thumb.getSelectionIndex().toString());	
	}
	
	public function onSelectionSet(Void):Void {
		var index:Number = Number(selectionText.getText());
		thumb.setSelectionIndex(index);
		selectionText.setText(thumb.getSelectionIndex().toString());
	}
	
	private function onAddClick(Void):Void {
		var t:LoadThumb = new LoadThumb("../res/image1.jpg");
		t.load(); 
		thumb.appendThumb(t);
	}
}