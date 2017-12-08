package{
	
	//Import statements
	import com.adobe.air.gaming.*;
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.events.Event;

	//Gamepad class
	public class Gamepad extends Sprite{
		public var localYLoc:Number;
		public var localXLoc:Number;
		public var main:Main = new Main();
		private var airGamepad:AIRGamepad;
		private var sprite:Sprite = new Sprite;
		
		public function Gamepad():void{}
		
		//Setting up gamepad handshake properties
		public function init(){
			stage.addChild(main);
			main.init();
			airGamepad = AIRGamepad.getGamepad("Gamepad 1");
			airGamepad.addEventListener(AIRGamepadEvent.CONNECT, gamepadConnected);
			airGamepad.connect(stage,"Flare3d", "http://www.flare3d.com");
		}
		
		//Adds event listeners when gamepad has successfully connnected.
		private function gamepadConnected(e:AIRGamepadEvent):void{
			if(airGamepad){
				trace("Air Gamepad Connected");
				this.airGamepad.addEventListener(TouchEvent.TOUCH_BEGIN, tapHandler);
				this.airGamepad.addEventListener(TouchEvent.TOUCH_END, releaseHandler);
				this.airGamepad.addEventListener(TouchEvent.TOUCH_MOVE, dragHandler);
			}
			
			else{
				trace("Air Gamepad connection failed");
			}
			
			//Adding text fields and sprite to gamepad screen.
			var textField = new TextField();
			var sizeX:Number = airGamepad.width;
			var sizeY:Number = airGamepad.height;
			
			sprite.graphics.clear();
			sprite.graphics.beginFill(0x0066FF);
			sprite.graphics.drawRect(0,350,sizeX,sizeY/2+100);
			sprite.graphics.endFill();
			textField.text = "Tap the white zone, drag coins over correct jar!";
			textField.width = 400;
			textField.height = 30;
			textField.x = (70);
			textField.y = (300);
			sprite.addChild(textField);
			airGamepad.drawSprite(sprite);
		}
		
		//Gets location of tap, and sets the x/y loc of the coin to that location, updating each frame causing a drag function.
		private function dragHandler(evt:TouchEvent):void{
			localXLoc = evt.localX;
			localYLoc = evt.localY;
			main.coin.x = localXLoc;
			main.coin.y = localYLoc;
		}

		//Calling drop function in Main class when tap is registered.
		private function tapHandler(evt:TouchEvent):void{
			main.falling = true;
			localXLoc = evt.localX;
			localYLoc = evt.localY;
			main.drop(localXLoc, localYLoc);
		}
		
		//Calling release function in Main class when tap is released.
		private function releaseHandler(evt:TouchEvent):void{
			localXLoc = evt.localX;
			localYLoc = evt.localY;
			main.release(localXLoc, localYLoc);
		}
	}
}