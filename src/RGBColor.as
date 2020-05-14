package  
{
	import flash.geom.ColorTransform;
	/**
	 * Converting between RGB and HSV color space
	 * RGBとHSVの相互変換
	 * http://www.technotype.net/tutorial/tutorial.php?fileId=%7BImage%20processing%7D&sectionId=%7B-converting-between-rgb-and-hsv-color-space%7D
	 * ...
	 * @author umhr
	 */
	public class RGBColor
	{
		private var _alpha:Number;
		private var _a:int;
		public var red:int;
		public var green:int;
		public var blue:int;
		public var hue:Number;
		public var saturation:Number;
		public var value:Number;
		private var _rgb:int;
		public var name:String;
		
		public function RGBColor(rgb:int = NaN) 
		{
			if (!isNaN(rgb)) {
				this.rgb = rgb;
			}
		}
		
		private function setHSV():void {
			
			var max:int = Math.max(red, green, blue);
			var min:int = Math.min(red, green, blue);
			
			// h
			if(max == min){
				hue = 0;
			}
			else if(max == red){
				hue = (60 * (green - blue) / (max - min) + 360) % 360;
			}
			else if(max == green){
				hue = (60 * (blue - red) / (max - min)) + 120;
			}
			else if(max == blue){
				hue = (60 * (red - green) / (max - min)) + 240;   
			}
			
			// s
			if(max == 0){
				saturation = 0;
			}
			else{
				saturation = (255 * ((max - min) / max));
			}
			
			// v
			value = max;
		}
		
		public function setByHSV(hue:int, saturation:int, value:int):void {
			
			this.hue = hue;
			this.saturation = saturation;
			this.value = value;
			
			var i:int = Math.floor(hue / 60) % 6;
			var f:Number = (hue / 60) - Math.floor(hue / 60);
			var p:int = Math.round(value * (1 - (saturation / 255)));
			var q:int = Math.round(value * (1 - (saturation / 255) * f));
			var t:int = Math.round(value * (1 - (saturation / 255) * (1 - f)));
			
			switch(i){
				case 0 : red = value; green = t; blue = p; break;
				case 1 : red = q; green = value; blue = p; break;
				case 2 : red = p; green = value; blue = t; break;
				case 3 : red = p; green = q; blue = value; break;
				case 4 : red = t; green = p; blue = value; break;
				case 5 : red = value; green = p; blue = q; break;
			}
			
			rgb = ColorUtils.rgbCombination(red, green, blue);
		}
		
		
		public function toString(radix:* = 10):String {
			return rgb.toString(radix);
		}
		
		/**
		 * 0～1の値を返します。
		 */
		public function get alpha():Number 
		{
			return _alpha;
		}
		public function set alpha(value:Number):void 
		{
			_alpha = value;
			_a = value * 255;
		}
		
		/**
		 * 0～255の値を返します。
		 */
		public function get a():int 
		{
			return _a;
		}
		public function set a(value:int):void 
		{
			_a = value;
			_alpha = value / 255;
		}
		
		public function get rgb():int 
		{
			return _rgb;
		}
		
		public function set rgb(value:int):void 
		{
			_rgb = value;
			red = value >> 16 & 0xFF;
			green = value >> 8 & 0xFF;
			blue = value & 0xFF;
			
			setHSV();
		}
		

		
	}

}