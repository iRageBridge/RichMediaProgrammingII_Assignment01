package{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nape.space.Space;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.util.Debug;
	import nape.util.ShapeDebug;
	import flash.events.TouchEvent;
	
	public class Main extends Sprite{
		var data:Data = new Data();
		public var space:Space = new Space(new Vec2(0,1280)); 
		public function Main():void{}
		
		public function init(){
			var debug:ShapeDebug = new ShapeDebug(1280,760,0x131313);
			var border:Body = new Body(BodyType.STATIC);
			addChild(debug.display);
			border.shapes.add(new Polygon(Polygon.rect(0,0,-1,500)));
			border.shapes.add(new Polygon(Polygon.rect(1280,0,1,500)));
			border.shapes.add(new Polygon(Polygon.rect(0,0,1280,-1)));
			border.shapes.add(new Polygon(Polygon.rect(0,0,1280,1)));
			border.space = space;
			
			addEventListener(Event.ENTER_FRAME, function(e:Event):void{
				debug.clear();
				space.step(1/24,10,10);
				debug.draw(space);
				debug.flush();
				
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
		
		public function drop(stageXLoc: Number, stageYLoc: Number):void{
			var coin:Euro = new Euro();
			var block:Polygon = new Polygon(Polygon.regular(45,45,20));
			var body:Body = new Body();
			body.shapes.add(block);
			if(stageYLoc < 360){
				addChild(coin);
				body.position.setxy(stageXLoc,stageYLoc);
				body.space = space;
				body.userData.sprite = coin;
				if(body.userData.coin){
					stage.addChild(body.userData.coin);
				}
				
				stage.addEventListener(Event.ENTER_FRAME,hitDetector);
				function hitDetector(e:Event):void{
					if(coin.y >= 360){
						if(contains(coin)){
							body.space = null;
							removeChild(coin);
						}
						
						if(coin.x >=0 && coin.x <= 320){
							trace("One US dollar is worth "+data.gbp+" Britsh Pounds");
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
							
						}
						
						else if (coin.x >= 321 && coin.x <= 640){
							trace("One US Dollar is worth "+data.cad+" Canadian Dollars");
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
						}
						
						else if (coin.x >= 641 && coin.x <=960){
							trace("One US Dollar is worth "+data.eur+" Euros");
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
						}
						
						else if(coin.x >= 961 && coin.x <= 1280){
							trace("One US Dollar is worth "+data.aud+" Audstalian Dolalrs");
							stage.removeEventListener(Event.ENTER_FRAME,hitDetector);
						}
					}
				}
			}
		}
	} 
}
