package  
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import com.bit101.components.RadioButton;
	import com.bit101.components.Style;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	/**
	 * ...
	 * @author umhr
	 */
	public class ColorCanvas extends Sprite 
	{
		
		private var _centerInformation:CenterInformation = new CenterInformation();
		private var _colorChipList:Vector.<ColorChip> = new Vector.<ColorChip>();
		private var _currentRadio:String;
		public function ColorCanvas() 
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
			
			var rgbColorList:Vector.<RGBColor> = ColorPalette.rgbColorList;
			
			_centerInformation.x = stage.stageWidth * 0.5;
			_centerInformation.y = stage.stageHeight * 0.5;
			addChild(_centerInformation);
			
			var n:int = rgbColorList.length;
			for (var i:int = 0; i < n; i++) 
			{
				addColorCircle(rgbColorList[i]);
			}
			setPosition("Hue");
			addRadioButton();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
		}
		
		private function addRadioButton():void 
		{
			Style.embedFonts = false;
			Style.fontSize = 12;
			Style.BACKGROUND = 0xFF0000;
			Style.LABEL_TEXT = 0xFFFFFF;
			new RadioButton(this, 8, 10, "Hue(色相)", true, onRadio);
			new RadioButton(this, 8, 30, "Saturation(彩度)", false, onRadio);
			new RadioButton(this, 8, 50, "Value(明度)", false, onRadio);
			new RadioButton(this, 8, 70, "Name", false, onRadio);
		}
		
		private function onRadio(event:MouseEvent):void 
		{
			var radioButton:RadioButton = event.target as RadioButton;
			var name:String = radioButton.label;
			name = name.split("(")[0];
			setPosition(name);
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			var object:* = getObjectsUnderPoint(new Point(mouseX, mouseY)).pop();
			
			if (object == "[object ColorChip]") {
				
				var n:int = _colorChipList.length;
				for (var i:int = 0; i < n; i++) 
				{
					_colorChipList[i].filters = [];
				}
				
				
				var colorChip:ColorChip = object as ColorChip;
				colorChip.filters = [new DropShadowFilter(0)];
				var rgbColor:RGBColor = colorChip.rgbColor;
				_centerInformation.setRGBColor(rgbColor);
			}
			
		}
		
		private function addColorCircle(rgbColor:RGBColor):void 
		{
			var colorChip:ColorChip = new ColorChip(rgbColor);
			colorChip.x = stage.stageWidth * 0.5;
			colorChip.y = stage.stageHeight * 0.5;
			addChild(colorChip);
			
			_colorChipList.push(colorChip);
		}
		
		private function setPosition(name:String):void {
			
			if (_currentRadio == name) {
				return;
			}
			_currentRadio = name;
			
			
			var colorChip:ColorChip;
			var d:Number;
			var n:int = _colorChipList.length;
			var num:Number;
			var indexList:Vector.<int> = ColorPalette["indexListBy" + name];
			
			var tweenList:Array/*Tween24*/ = [];
			
			var k:int;
			for (var i:int = 0; i < n; i++) 
			{
				d = i % 3;
				num = i / n;
				k = indexList[i];
				
				tweenList[i] = Tween24.tween(_colorChipList[k], 0.5, Ease24._2_QuadOut);
				tweenList[i].x(stage.stageWidth * 0.5 + Math.cos(num * 2 * Math.PI) * (170 + d * 22));
				tweenList[i].y(stage.stageHeight * 0.5 + Math.sin(num * 2 * Math.PI) * (170 + d * 22));
				tweenList[i].delay(d * 0.1);
			}
			Tween24.parallel.apply(null, tweenList).play();
			
		}
	}
	
}