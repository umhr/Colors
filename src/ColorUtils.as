package  
{
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author umhr
	 */
	public class ColorUtils 
	{
		
		public function ColorUtils() 
		{
			
		}
		
		static public function colorTransform(rgb:int):ColorTransform {	
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redMultiplier = colorTransform.blueMultiplier = colorTransform.greenMultiplier = 0;
			colorTransform.redOffset = rgb >> 16;//16bit右にずらす。
			colorTransform.greenOffset = rgb >> 8 & 0xff;//8bit右にずらして、下位8bitのみを取り出す。
			colorTransform.blueOffset = rgb & 0xff;//下位8bitのみを取り出す。
			return colorTransform;
		}
		
		static public function rgbCombination(red:int, green:int, blue:int):int {
			return red << 16 | green << 8 | blue;
		}
		/**
		 * rgbをargbにして返します。
		 * @param	rgb
		 * @param	alpha
		 * @return
		 */
		static public function addAlpha(rgb:uint, alpha:int = 0xFF):uint {
			return alpha << 24 | rgb;
		}
		
		static public function removeAlpha(argb:uint):int {
			return argb & 0xFFFFFF;
		}
		
		static public function rgbSeparater(rgb:int):Vector.<int> {
			return Vector.<int>([rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF]);
		}
		
		static public function rgbSeparaterArray(rgb:int):Array {
			return [rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF];
		}
		
		
		static public function rgbSeparaters(rgb:int, r:int, g:int, b:int):void {
			r = rgb >> 16 & 0xFF;
			g = rgb >> 8 & 0xFF;
			b = rgb & 0xFF;
		}
		
		/**
		 * フィールドカラーに変色します.
		 * 6桁16進数から、2桁ぶんずつを取り出す。 
		 * 色情報は24bit。r8bit+g8bit+b8bit。24桁の二進数 
		 * @param	rgb
		 * @param	ratio
		 * @return
		 */
		static public function colorTransformFromRGB(rgb:int, ratio:Number = 1):ColorTransform {	
			//ratioが1以外の場合、明度変更関数へ
			if(ratio != 1){rgb = rgbBrightness(rgb,ratio)};
			var color:ColorTransform = new ColorTransform();
			color.redMultiplier = color.blueMultiplier = color.greenMultiplier = 0;
			color.redOffset = rgb >> 16;//16bit右にずらす。
			color.greenOffset = rgb >> 8 & 0xff;//8bit右にずらして、下位8bitのみを取り出す。
			color.blueOffset = rgb & 0xff;//下位8bitのみを取り出す。
			return color;
		}
		
		/**
		 * 色の明度を相対的に変える関数。
		 * rgb値と割合を与えて、結果を返す。
		 * rgbは、0xffffff段階の値。
		 * ratioが0の時に0x000000に、1の時にそのまま、2の時には0xffffffになる。
		 * 相対的に、ちょっと暗くしたい時には、ratioを0.8に、
		 * ちょっと明るくしたい時にはratioを1.2などに設定する。
		 */
		static public function rgbBrightness(rgb:int, ratio:Number):int {
			if(ratio < 0 || 2 < ratio){ratio = 1;trace("function colorBrightness 範囲外")}
			var _r:int = rgb >> 16;//16bit右にずらす。
			var _g:int = rgb >> 8 & 0xff;//8bit右にずらして、下位8bitのみを取り出す。
			var _b:int = rgb & 0xff;//下位8bitのみを取り出す。
			if(ratio <= 1){
				_r *= ratio;
				_g *= ratio;
				_b *= ratio;
			}else{
				_r = (255 - _r)*(ratio-1)+_r;
				_g = (255 - _g)*(ratio-1)+_g;
				_b = (255 - _b)*(ratio-1)+_b;
			}
			return _r << 16 | _g << 8 | _b;
		}		
	}

}