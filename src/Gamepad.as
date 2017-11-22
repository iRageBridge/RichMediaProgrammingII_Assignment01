package{
	import com.adobe.air.gaming.*;
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.text.TextField;

	public class Gamepad extends Sprite{
		public var main:Main = new Main();
		protected var airGamepad:AIRGamepad;
		protected var sprite:Sprite = new Sprite;
		
		public function Gamepad():void{}
		
		public function init(){
			stage.addChild(main);
			main.init();
			airGamepad = AIRGamepad.getGamepad("Gamepad 1");
			airGamepad.addEventListener(AIRGamepadEvent.CONNECT, gamepadConnected);
			airGamepad.connect(stage,"Flare3d", "http://www.flare3d.com");

			if(airGamepad){
				this.airGamepad.addEventListener(TouchEvent.TOUCH_BEGIN, tapHandler);
			}
		}

		private function gamepadConnected(e:AIRGamepadEvent):void{
			trace("Connected");
			var textField = new TextField();
			var sizeX:Number = airGamepad.width;
			var sizeY:Number = airGamepad.height;
			
			sprite.graphics.clear();
			sprite.graphics.beginFill(0x0);
			sprite.graphics.drawRect(0,350,sizeX,sizeY/2+100);
			sprite.graphics.endFill();
			textField.text = "Tap the white zone";
			textField.width = 200;
			textField.height = 30;
			textField.x = (10);
			textField.y = (300);
			sprite.addChild(textField);
			airGamepad.drawSprite(sprite);
		}

		private function tapHandler(evt:TouchEvent):void{
			main.drop(evt.localX, evt.localY);
		}
	}
}