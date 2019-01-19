import flash.geom.Point;
class com.fox.Utils.Common {

	public function Common() {
	}

	public static function getOnScreen( mc:MovieClip) : Point {
		var pointy:Point = new Point(mc._x, mc._y);
		if ( mc._x < 0 ) pointy.x = 0;
		else if ( mc._x + mc._width > Stage.visibleRect.width ) pointy.x = Stage.visibleRect.width - mc._width;
		if ( mc._y < 0 ) pointy.y = 0;
		else if ( mc._y + mc._height > Stage.visibleRect.height ) pointy.y = Stage.visibleRect.height - mc._height;
		return pointy;
	}
}