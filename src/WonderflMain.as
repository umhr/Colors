package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0x777777, frameRate = 30)]
	public class WonderflMain extends Sprite 
	{
		
		public function WonderflMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			graphics.beginFill(0x777777);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			addChild(new ColorCanvas());
			
		}
		
	}
	
}


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
	 class ColorCanvas extends Sprite 
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
	 class CenterInformation extends Sprite 
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
	

	/**
	 * CSS色
	 * http://www.color-sample.com/popular/htmlcolor/
	 * ...
	 * @author umhr
	 */
	 class ColorPalette 
	{
		static public const ALICE_BLUE:int = 0xF0F8FF;
		static public const ANTIQUE_WHITE:int = 0xFAEBD7;
		static public const AQUA:int = 0x00FFFF;
		static public const AQUAMARINE:int = 0x7FFFD4;
		static public const AZURE:int = 0xF0FFFF;
		static public const BEIGE:int = 0xF5F5DC;
		static public const BISQUE:int = 0xFFE4C4;
		static public const BLACK:int = 0x000000;
		static public const BLANCHED_ALMOND:int = 0xFFEBCD;
		static public const BLUE:int = 0x0000FF;
		static public const BLUE_VIOLET:int = 0x8A2BE2;
		static public const BRASS:int = 0xB5A642;
		static public const BROWN:int = 0xA52A2A;
		static public const BURLY_WOOD:int = 0xDEB887;
		static public const CADET_BLUE:int = 0x5F9EA0;
		static public const CHARTREUSE:int = 0x7FFF00;
		static public const CHOCOLATE:int = 0xD2691E;
		static public const COOLCOPPER:int = 0xD98719;
		static public const COPPER:int = 0xBF00DF;
		static public const CORAL:int = 0xFF7F50;
		static public const CORNFLOWER:int = 0xBFEFDF;
		static public const CORNFLOWER_BLUE:int = 0x6495ED;
		static public const CORNSILK:int = 0xFFF8DC;
		static public const CRIMSON:int = 0xDC143C;
		static public const CYAN:int = 0x00FFFF;
		static public const DARK_BLUE:int = 0x00008B;
		static public const DARK_BROWN:int = 0xDA0B00;
		static public const DARK_CYAN:int = 0x008B8B;
		static public const DARK_GOLDENROD:int = 0xB8860B;
		static public const DARK_GRAY:int = 0xA9A9A9;
		static public const DARK_GREEN:int = 0x006400;
		static public const DARK_KHAKI:int = 0xBDB76B;
		static public const DARK_MAGENTA:int = 0x8B008B;
		static public const DARK_OLIVE_GREEN:int = 0x556B2F;
		static public const DARK_ORANGE:int = 0xFF8C00;
		static public const DARK_ORCHID:int = 0x9932CC;
		static public const DARK_RED:int = 0x8B0000;
		static public const DARK_SALMON:int = 0xE9967A;
		static public const DARK_SEA_GREEN:int = 0x8FBC8F;
		static public const DARK_SLATE_BLUE:int = 0x483D8B;
		static public const DARK_SLATE_GRAY:int = 0x2F4F4F;
		static public const DARK_TURQUOISE:int = 0x00CED1;
		static public const DARK_VIOLET:int = 0x9400D3;
		static public const DEEP_PINK:int = 0xFF1493;
		static public const DEEP_SKY_BLUE:int = 0x00BFFF;
		static public const DIM_GRAY:int = 0x696969;
		static public const DODGER_BLUE:int = 0x1E90FF;
		static public const FELDSPER:int = 0xFED0E0;
		static public const FIRE_BRICK:int = 0xB22222;
		static public const FLORAL_WHITE:int = 0xFFFAF0;
		static public const FOREST_GREEN:int = 0x228B22;
		static public const FUCHSIA:int = 0xFF00FF;
		static public const GAINSBORO:int = 0xDCDCDC;
		static public const GHOST_WHITE:int = 0xF8F8FF;
		static public const GOLD:int = 0xFFD700;
		static public const GOLDENROD:int = 0xDAA520;
		static public const GRAY:int = 0x808080;
		static public const GREEN:int = 0x008000;
		static public const GREEN_YELLOW:int = 0xADFF2F;
		static public const HONEYDEW:int = 0xF0FFF0;
		static public const HOT_PINK:int = 0xFF69B4;
		static public const INDIAN_RED:int = 0xCD5C5C;
		static public const INDIGO:int = 0x4B0082;
		static public const IVORY:int = 0xFFFFF0;
		static public const KHAKI:int = 0xF0E68C;
		static public const LAVENDER:int = 0xE6E6FA;
		static public const LAVENDER_BLUSH:int = 0xFFF0F5;
		static public const LAWN_GREEN:int = 0x7CFC00;
		static public const LEMON_CHIFFON:int = 0xFFFACD;
		static public const LIGHT_BLUE:int = 0xADD8E6;
		static public const LIGHT_CORAL:int = 0xF08080;
		static public const LIGHT_CYAN:int = 0xE0FFFF;
		static public const LIGHT_GOLDENROD_YELLOW:int = 0xFAFAD2;
		static public const LIGHT_GREEN:int = 0x90EE90;
		static public const LIGHT_GREY:int = 0xD3D3D3;
		static public const LIGHT_PINK:int = 0xFFB6C1;
		static public const LIGHT_SALMON:int = 0xFFA07A;
		static public const LIGHT_SEA_GREEN:int = 0x20B2AA;
		static public const LIGHT_SKY_BLUE:int = 0x87CEFA;
		static public const LIGHT_SLATE_GRAY:int = 0x778899;
		static public const LIGHT_STEEL_BLUE:int = 0xB0C4DE;
		static public const LIGHT_YELLOW:int = 0xFFFFE0;
		static public const LIME:int = 0x00FF00;
		static public const LIME_GREEN:int = 0x32CD32;
		static public const LINEN:int = 0xFAF0E6;
		static public const MAGENTA:int = 0xFF00FF;
		static public const MAROON:int = 0x800000;
		static public const MEDIUM_AQUAMARINE:int = 0x66CDAA;
		static public const MEDIUM_BLUE:int = 0x0000CD;
		static public const MEDIUM_ORCHID:int = 0xBA55D3;
		static public const MEDIUM_PURPLE:int = 0x9370DB;
		static public const MEDIUM_SEA_GREEN:int = 0x3CB371;
		static public const MEDIUM_SLATE_BLUE:int = 0x7B68EE;
		static public const MEDIUM_SPRING_GREEN:int = 0x00FA9A;
		static public const MEDIUM_TURQUOISE:int = 0x48D1CC;
		static public const MEDIUM_VIOLET_RED:int = 0xC71585;
		static public const MIDNIGHT_BLUE:int = 0x191970;
		static public const MINT_CREAM:int = 0xF5FFFA;
		static public const MISTY_ROSE:int = 0xFFE4E1;
		static public const MOCCASIN:int = 0xFFE4B5;
		static public const NAVAJO_WHITE:int = 0xFFDEAD;
		static public const NAVY:int = 0x000080;
		static public const OLD_LACE:int = 0xFDF5E6;
		static public const OLIVE:int = 0x808000;
		static public const OLIVE_DRAB:int = 0x6B8E23;
		static public const ORANGE:int = 0xFFA500;
		static public const ORANGE_RED:int = 0xFF4500;
		static public const ORCHID:int = 0xDA70D6;
		static public const PALE_GOLDENROD:int = 0xEEE8AA;
		static public const PALE_GREEN:int = 0x98FB98;
		static public const PALE_TURQUOISE:int = 0xAFEEEE;
		static public const PALE_VIOLET_RED:int = 0xDB7093;
		static public const PAPAYA_WHIP:int = 0xFFEFD5;
		static public const PEACH_PUFF:int = 0xFFDAB9;
		static public const PERU:int = 0xCD853F;
		static public const PINK:int = 0xFFC0CB;
		static public const PLUM:int = 0xDDA0DD;
		static public const POWDER_BLUE:int = 0xB0E0E6;
		static public const PURPLE:int = 0x800080;
		static public const RED:int = 0xFF0000;
		static public const RICHBLUE:int = 0x0CB0E0;
		static public const ROSY_BROWN:int = 0xBC8F8F;
		static public const ROYAL_BLUE:int = 0x4169E1;
		static public const SADDLE_BROWN:int = 0x8B4513;
		static public const SALMON:int = 0xFA8072;
		static public const SANDY_BROWN:int = 0xF4A460;
		static public const SEA_GREEN:int = 0x2E8B57;
		static public const SEASHELL:int = 0xFFF5EE;
		static public const SIENNA:int = 0xA0522D;
		static public const SILVER:int = 0xC0C0C0;
		static public const SKY_BLUE:int = 0x87CEEB;
		static public const SLATE_BLUE:int = 0x6A5ACD;
		static public const SLATE_GRAY:int = 0x708090;
		static public const SNOW:int = 0xFFFAFA;
		static public const SPRING_GREEN:int = 0x00FF7F;
		static public const STEEL_BLUE:int = 0x4682B4;
		static public const TAN:int = 0xD2B48C;
		static public const TEAL:int = 0x008080;
		static public const THISTLE:int = 0xD8BFD8;
		static public const TOMATO:int = 0xFF6347;
		static public const TURQUOISE:int = 0x40E0D0;
		static public const VIOLET:int = 0xEE82EE;
		static public const WHEAT:int = 0xF5DEB3;
		static public const WHITE:int = 0xFFFFFF;
		static public const WHITE_SMOKE:int = 0xF5F5F5;
		static public const YELLOW:int = 0xFFFF00;
		static public const YELLOW_GREEN:int = 0x9ACD32;
		
		/**
		 * 名前順リスト
		 */
		static public const NAME_LIST:Vector.<String> = Vector.<String>(["ALICE_BLUE", "ANTIQUE_WHITE", "AQUA", "AQUAMARINE", "AZURE", "BEIGE", "BISQUE", "BLACK", "BLANCHED_ALMOND", "BLUE", "BLUE_VIOLET", "BRASS", "BROWN", "BURLY_WOOD", "CADET_BLUE", "CHARTREUSE", "CHOCOLATE", "COOLCOPPER", "COPPER", "CORAL", "CORNFLOWER", "CORNFLOWER_BLUE", "CORNSILK", "CRIMSON", "CYAN", "DARK_BLUE", "DARK_BROWN", "DARK_CYAN", "DARK_GOLDENROD", "DARK_GRAY", "DARK_GREEN", "DARK_KHAKI", "DARK_MAGENTA", "DARK_OLIVE_GREEN", "DARK_ORANGE", "DARK_ORCHID", "DARK_RED", "DARK_SALMON", "DARK_SEA_GREEN", "DARK_SLATE_BLUE", "DARK_SLATE_GRAY", "DARK_TURQUOISE", "DARK_VIOLET", "DEEP_PINK", "DEEP_SKY_BLUE", "DIM_GRAY", "DODGER_BLUE", "FELDSPER", "FIRE_BRICK", "FLORAL_WHITE", "FOREST_GREEN", "FUCHSIA", "GAINSBORO", "GHOST_WHITE", "GOLD", "GOLDENROD", "GRAY", "GREEN", "GREEN_YELLOW", "HONEYDEW", "HOT_PINK", "INDIAN_RED", "INDIGO", "IVORY", "KHAKI", "LAVENDER", "LAVENDER_BLUSH", "LAWN_GREEN", "LEMON_CHIFFON", "LIGHT_BLUE", "LIGHT_CORAL", "LIGHT_CYAN", "LIGHT_GOLDENROD_YELLOW", "LIGHT_GREEN", "LIGHT_GREY", "LIGHT_PINK", "LIGHT_SALMON", "LIGHT_SEA_GREEN", "LIGHT_SKY_BLUE", "LIGHT_SLATE_GRAY", "LIGHT_STEEL_BLUE", "LIGHT_YELLOW", "LIME", "LIME_GREEN", "LINEN", "MAGENTA", "MAROON", "MEDIUM_AQUAMARINE", "MEDIUM_BLUE", "MEDIUM_ORCHID", "MEDIUM_PURPLE", "MEDIUM_SEA_GREEN", "MEDIUM_SLATE_BLUE", "MEDIUM_SPRING_GREEN", "MEDIUM_TURQUOISE", "MEDIUM_VIOLET_RED", "MIDNIGHT_BLUE", "MINT_CREAM", "MISTY_ROSE", "MOCCASIN", "NAVAJO_WHITE", "NAVY", "OLD_LACE", "OLIVE", "OLIVE_DRAB", "ORANGE", "ORANGE_RED", "ORCHID", "PALE_GOLDENROD", "PALE_GREEN", "PALE_TURQUOISE", "PALE_VIOLET_RED", "PAPAYA_WHIP", "PEACH_PUFF", "PERU", "PINK", "PLUM", "POWDER_BLUE", "PURPLE", "RED", "RICHBLUE", "ROSY_BROWN", "ROYAL_BLUE", "SADDLE_BROWN", "SALMON", "SANDY_BROWN", "SEA_GREEN", "SEASHELL", "SIENNA", "SILVER", "SKY_BLUE", "SLATE_BLUE", "SLATE_GRAY", "SNOW", "SPRING_GREEN", "STEEL_BLUE", "TAN", "TEAL", "THISTLE", "TOMATO", "TURQUOISE", "VIOLET", "WHEAT", "WHITE", "WHITE_SMOKE", "YELLOW", "YELLOW_GREEN"]);
		
		static private var _rgbColorList:Vector.<RGBColor>;
		
		static private var _rgbListByName:Vector.<int>;
		
		static private var _rgbListByValue:Vector.<int>;
		
		static private var _rgbListBySaturation:Vector.<int>;
		
		static private var _rgbListByHue:Vector.<int>;
		
		static private var _indexListByValue:Vector.<int>;
		
		static private var _indexListBySaturation:Vector.<int>;
		
		static private var _indexListByHue:Vector.<int>;
		
		static private var _indexListByName:Vector.<int>;
		
		/**
		 * 明度順リスト
		 */
		static public function get rgbListByName():Vector.<int> {
			if (_rgbListByName) {
				return _rgbListByName;
			}
			
			var n:int = rgbColorList.length;
			_rgbListByName = new Vector.<int>(n, true);
			_indexListByName = new Vector.<int>(n, true);
			for (var i:int = 0; i < n; i++) 
			{
				_rgbListByName[i] = _rgbColorList[i].rgb;
				_indexListByName[i] = i;
			}
			
			return _rgbListByName;
		}
		
		static public function get rgbListByValue():Vector.<int> {
			if (_rgbListByValue) {
				return _rgbListByValue;
			}
			return setList(_rgbListByValue, "value", "_indexListByValue");
		}
		
		static public function get rgbListByHue():Vector.<int> {
			if (_rgbListByHue) {
				return _rgbListByHue;
			}
			return setList(_rgbListByHue, "hue", "_indexListByHue");
		}
		
		static public function get rgbListBySaturation():Vector.<int> {
			if (_rgbListBySaturation) {
				return _rgbListBySaturation;
			}
			return setList(_rgbListBySaturation, "saturation", "_indexListBySaturation");
		}
		
		static private function setList(list:Vector.<int>, prop:String, indexName:String):Vector.<int> {
			var valueList:Array = [];
			var indexList:Vector.<int>;
			var n:int = rgbColorList.length;
			for (var i:int = 0; i < n; i++) 
			{
				valueList[i] = _rgbColorList[i][prop];
			}
			indexList = Vector.<int>(valueList.sort(Array.NUMERIC | Array.RETURNINDEXEDARRAY));
			
			list = new Vector.<int>(n, true);
			for (i = 0; i < n; i++) 
			{
				list[i] = _rgbColorList[indexList[i]].rgb;
			}
			
			ColorPalette[indexName] = indexList;
			
			return list;
		}
		
		static public function get rgbColorList():Vector.<RGBColor> {
			if (_rgbColorList) {
				return _rgbColorList;
			}
			
			var n:int = NAME_LIST.length;
			_rgbColorList = new Vector.<RGBColor>(n, true);
			for (var i:int = 0; i < n; i++) 
			{
				_rgbColorList[i] = new RGBColor(ColorPalette[NAME_LIST[i]]);
				_rgbColorList[i].name = NAME_LIST[i];
			}
			
			return _rgbColorList;
		}
		
		static public function get indexListByHue():Vector.<int> 
		{
			if (!_indexListByHue) {
				rgbListByHue;
			}
			return _indexListByHue;
		}
		
		static public function get indexListByName():Vector.<int> 
		{
			if (!_indexListByName) {
				rgbListByName;
			}
			return _indexListByName;
		}
		
		static public function get indexListBySaturation():Vector.<int> 
		{
			if (!_indexListBySaturation) {
				rgbListBySaturation;
			}
			return _indexListBySaturation;
		}
		
		static public function get indexListByValue():Vector.<int> 
		{
			if (!_indexListByValue) {
				rgbListByValue;
			}
			return _indexListByValue;
		}
		
		public function ColorPalette() 
		{
			
		}
		
		
	}


	
	import flash.display.Sprite;
	/**
	 * ...
	 * @author umhr
	 */
	 class ColorChip extends Sprite 
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
	

	import flash.geom.ColorTransform;
	/**
	 * Converting between RGB and HSV color space
	 * RGBとHSVの相互変換
	 * http://www.technotype.net/tutorial/tutorial.php?fileId=%7BImage%20processing%7D&sectionId=%7B-converting-between-rgb-and-hsv-color-space%7D
	 * ...
	 * @author umhr
	 */
	 class RGBColor
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


	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author umhr
	 */
	 class ColorUtils 
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

