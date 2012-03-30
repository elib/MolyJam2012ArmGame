package com.arms 
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		
		public function Player() 
		{
			super();
			
			makeGraphic(Arms.TILESIZE, Arms.TILESIZE, 0xffffffff);
			x = 100;
			y = 100;
			this.origin.y = 0;
			this.origin.x = 4;
			//acceleration.y = 500;
		}

		override public function update():void 
		{
			super.update();
			angle++;
			
			
			
		}
		
		
	}

}