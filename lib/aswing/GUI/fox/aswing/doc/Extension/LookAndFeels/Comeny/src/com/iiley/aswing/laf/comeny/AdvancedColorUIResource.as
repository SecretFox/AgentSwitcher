/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.plaf.UIResource;
import org.aswing.util.AdvancedColor;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.AdvancedColorUIResource extends AdvancedColor implements UIResource {
	
	public function AdvancedColorUIResource(rgb:Number, alpha:Number){
		super(rgb, alpha);
	}
	
	public static function makeResource(c:ASColor):AdvancedColorUIResource{
		return new AdvancedColorUIResource(c.getRGB(), c.getAlpha());
	}
	
	public function hueAdjusted(factor:Number):AdvancedColorUIResource{
		return makeResource(super.hueAdjusted(factor));
	}

	public function luminanceAdjusted(factor:Number):AdvancedColorUIResource{
		return makeResource(super.luminanceAdjusted(factor));
	}

	public function saturationAdjusted(factor:Number):AdvancedColorUIResource{
		return makeResource(super.saturationAdjusted(factor));
	}	
}