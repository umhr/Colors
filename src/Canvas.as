package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		
		public function Canvas() 
		{
			init();
		}
		private function init():void 
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
		private var _inputTextField:TextField = new TextField();
		private var _resultTextField:TextField = new TextField();
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			
			setTextField(_inputTextField, 0, 0, 400, 150).addEventListener(Event.CHANGE, textField_change);
			setTextField(_resultTextField, 0, 300, 400, 150);
		}
		
		private function setTextField(textField:TextField, x:Number, y:Number, width:Number, height:Number):TextField 
		{
			textField.defaultTextFormat = new TextFormat("_sans", 12);
			textField.wordWrap = true;
			textField.multiline = true;
			textField.type = TextFieldType.INPUT;
			textField.border = true;
			textField.x = x;
			textField.y = y;
			textField.width = width;
			textField.height = height;
			addChild(textField);
			return textField;
		}
		
		private function textField_change(e:Event):void 
		{
			var text:String = "\t" + _inputTextField.text;
			
			var pattern:RegExp = new RegExp("[A-Z]", "g");
			
			text = text.replace(pattern, "_$&");
			
			text = text.replace(/\t_/g, "\t");
			text = text.replace(/\r_/g, "\r");
			text = text.replace(/\n_/g, "\n");
			text = text.toUpperCase();
			
			_resultTextField.text = text.substr(1);
		}
		
	}
	
}