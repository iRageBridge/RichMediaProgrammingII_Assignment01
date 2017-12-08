package{
	
	//import statements
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import nape.space.Space;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.util.Debug;
	import nape.util.ShapeDebug;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	//Main Class
	public class Main extends Sprite{
		
		//Global variables
		public var falling:Boolean = false;
		public var present:Boolean = false;
		public var coin:Euro;
		public var mainText = new TextField();
		
		private var myTimer:Timer = new Timer(3000,1);
		private var currencies = new Array("Of any Currency", "British Pounds", "Canadian Dollars", "Australian Dollars", "Euro");
		private var randomSelection:int = Math.random()*4;
		private var gbp: Number = 0;
		private var cad: Number = 0;
		private var eur: Number = 0;
		private var aud: Number = 0;
		private var target:int = 2 + Math.floor( Math.random() * 11 );
		private var gbpField = new TextField();
		private var cadField = new TextField();
		private var eurField = new TextField();
		private var audField = new TextField();		
		private var block:Polygon;
		private var body:Body;
		private var data:Data = new Data();
		private var space:Space = new Space(new Vec2(0,1280)); 
		public function Main():void{}
		
		public function init(){
			
			//Timer which runs on game completion for 2 seconds, then restarts game.
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			function timerComplete(e:TimerEvent){
				randomSelection = Math.random()*4;
				mainText.text = "Make up "+target+" "+ currencies[randomSelection] + "!";
			}
			
			mainText.text = "Make up "+target+" "+currencies[randomSelection] + "!";
			addEventListener(Event.ENTER_FRAME, tick);

			//Checking every frame if the target has been achieved for each currency
			function tick(e:Event):void{
				if((gbp+cad+eur+aud) >= target && randomSelection == 0){ 
					eurField.text = gbpField.text = audField.text = cadField.text = "";
					target = 2 + Math.floor( Math.random() * 11 );
					mainText.text = "Well Done!";
					gbp=cad=eur=aud=0;
					myTimer.start();
				}
				
				if((gbp) >= target && randomSelection == 1){ 
					eurField.text = gbpField.text = audField.text = cadField.text = "";
					target = 2 + Math.floor( Math.random() * 11 );
					mainText.text = "Well Done!";
					gbp=cad=eur=aud=0;
					myTimer.start();
				}
				
				if((cad) >= target && randomSelection == 2){ 
					eurField.text = gbpField.text = audField.text = cadField.text = "";
					target = 2 + Math.floor( Math.random() * 11 );
					mainText.text = "Well Done!";
					gbp=cad=eur=aud=0;
					myTimer.start();
				}
				
				if((aud) >= target && randomSelection == 3){ 
					eurField.text = gbpField.text = audField.text = cadField.text = "";
					target = 2 + Math.floor( Math.random() * 11 );
					mainText.text = "Well Done!";
					gbp=cad=eur=aud=0;
					myTimer.start();
				}
				
				if((eur) >= target && randomSelection == 4){ 
					eurField.text = gbpField.text = audField.text = cadField.text = "";
					target = 2 + Math.floor( Math.random() * 11 );
					mainText.text = "Well Done!";
					gbp=cad=eur=aud=0;
					myTimer.start();
				}
			}
			
			//Setting textfield properties
			mainText.x=212;
			mainText.y=124;
			mainText.width=800;
			mainText.height=100;
			
			stage.addChild(mainText);
			
			gbpField.x = 114;
			gbpField.y = 607;
			gbpField.width = 194;
			gbpField.height = 67;
			
			stage.addChild(gbpField);
			
			cadField.x = 452;
			cadField.y = 607;
			cadField.width = 194;
			cadField.height = 67;
			
			stage.addChild(cadField);
			
			eurField.x = 752;
			eurField.y = 607;
			eurField.width = 194;
			eurField.height = 67;
			
			stage.addChild(eurField);
			
			audField.x = 1052;
			audField.y = 607;
			audField.width = 194;
			audField.height = 67;
			
			stage.addChild(audField);
			
			//Setting up nape body object
			var border:Body = new Body(BodyType.STATIC);
			border.shapes.add(new Polygon(Polygon.rect(10,350,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(310,350,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(630,350,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(950,350,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(1270,350,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(0,0,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(1280,0,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(0,0,1280,1)));
			border.shapes.add(new Polygon(Polygon.rect(0,0,1280,1)));
			border.space = space;
			
			//Adding nape physics
			addEventListener(Event.ENTER_FRAME, function(e:Event):void{
				space.step(1/24,10,10);
				
				var bodyList = space.bodies;
				for (var i:int = 0; i < bodyList.length; i++) {
					var body:Body=bodyList.at(i);
					if(body.userData.sprite!=null){
						body.userData.sprite.x=body.position.x
						body.userData.sprite.y=body.position.y
						body.userData.sprite.rotation=(body.rotation*180/Math.PI)%360;
					}
				}﻿
			});
		}
		
		//Causes coin to spawn on tap. called from GamePad class.
		public function drop(stageXLoc: Number, stageYLoc: Number):void{
			stage.addEventListener(Event.ENTER_FRAME,counter);
			function counter(e:Event):void{
				if(contains(coin)){
					present = true;
				}
				else{
					present = false;
				}
			}
			if(stageYLoc < 360 && present  == false){
				coin = new Euro();
				block = new Polygon(Polygon.regular(45,45,20));
				body = new Body();
				addChild(coin);
				coin.x = stageXLoc;
				coin.y = stageYLoc;
			}
		}
		
		//Causes coin to drop on tap release, called from GamePad class.
		public function release(stageXLoc:Number, stageYLoc:Number):void{
			if(stageYLoc < 360){
				body.shapes.add(block);
				body.position.setxy(stageXLoc,stageYLoc);
				body.space = space;
				body.userData.sprite = coin;
					
				if(body.userData.coin){
					if(present == false){
						stage.addChild(body.userData.coin);
					}
				}
				
				//Checks if coin has passed a certain point, then checks if it is in the zone of the jars for score increment
				stage.addEventListener(Event.ENTER_FRAME,hitDetector);
				function hitDetector(e:Event):void{
					falling = true;
					if(coin.y >= 360){
						falling = false;
						if(contains(coin)){
							body.space = null;
							removeChild(coin);
						}
							
						if(coin.x >=0 && coin.x <= 320){ 
							gbp += data.gbp;
							gbpField.text = String("$" + int(gbp*100)/100);
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
							
						}
							
						else if (coin.x >= 321 && coin.x <= 640){
							cad += data.cad;
							cadField.text = String("$" + int(cad*100)/100);
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
						}
							
						else if (coin.x >= 641 && coin.x <=960){
							eur += data.eur;
							eurField.text = String("$" + int(eur*100)/100);
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
						}
							
						else if(coin.x >= 961 && coin.x <= 1280){
							aud += data.aud;
							audField.text = String("$" + int(aud*100)/100);
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
						}
					}
				}
			}
		}
	}
}