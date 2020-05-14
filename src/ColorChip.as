package  
{
	
	import flash.display.Sprite;
	/**
	 * ...
	 * @author umhr
	 */
	public class ColorChip extends Sprite 
	{
		public var rgbColor:RGBColor;
		public function ColorChip(rgbColor:RGBColor) 
		{
			this.rgbColor = rgbColor;
			name = rgbColor.name;
			init();
		}
		
		private function init():void {
			graphics.beginFill(rgbColor.rgb);
			//graphics.drawRect(-28, -3, 56, 6);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
		}
		
	}
	
}