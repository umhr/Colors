package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	public class CenterInformation extends Sprite 
	{
		public var _textField:TextField = new TextField();
		public function CenterInformation() 
		{
			init();
		}
		private function init():void 
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			addTextField();
		}
		
		private function addTextField():void 
		{
			var textFormat:TextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
			textFormat.align = TextFormatAlign.CENTER;
			_textField.defaultTextFormat = textFormat;
			_textField.text = "\n\n\n\n";
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.width = 200;
			_textField.autoSize = "center";
			_textField.x = -_textField.width * 0.5;
			_textField.y = -_textField.height * 0.5;
			_textField.filters = [new DropShadowFilter(0, 0, 0x000000, 1, 4, 4, 2)];
			addChild(_textField);
		}
		
		public function setRGBColor(rgbColor:RGBColor):void {
			graphics.clear();
			graphics.beginFill(rgbColor.rgb);
			graphics.drawCircle(0, 0, 100);
			graphics.endFill();
			
			var text:String = "";
			text += "Name:" + rgbColor.name + "\n";
			text += "RGB:0x" + rgbColor.rgb.toString(16).toUpperCase() + "\n";
			text += "Hue:" + Math.floor(rgbColor.hue) + "\n";
			text += "Saturation:" + Math.floor(rgbColor.saturation) + "\n";
			text += "Value:" + Math.floor(rgbColor.value) + "\n";
			
			_textField.text = text;
		}
	}
	
}