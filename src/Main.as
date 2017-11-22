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
		public var space:Space = new Space(new Vec2(0,1280)); 
		public function Main():void{}
		
		public function init(){
			var debug:ShapeDebug = new ShapeDebug(1280,760,0x131313);
			var border:Body = new Body(BodyType.STATIC);
			addChild(debug.display);
			border.shapes.add(new Polygon(Polygon.rect(0,0,-1,720)));
			border.shapes.add(new Polygon(Polygon.rect(1280,0,1,720)));
			border.shapes.add(new Polygon(Polygon.rect(0,0,1280,-1)));
			border.shapes.add(new Polygon(Polygon.rect(0,720,1280,1)));
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
			var block:Polygon = new Polygon(Polygon.regular(50,50,20));
			var body:Body = new Body();
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0xDAA520, 1);
			sprite.graphics.drawCircle(0, 0, 50);
			sprite.graphics.endFill();
			addChild(sprite);
			body.shapes.add(block);
			body.position.setxy(stageXLoc,stageYLoc);
			body.space = space;
			body.userData.sprite = sprite;
			addChild(body.userData.sprite);
		}
	} 
}
