/*
	The MIT License (MIT)

	Copyright (c) 2015 eltorqiro
	Modified Copyright (c) 2018 SecretFox

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
*/
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