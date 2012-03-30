package com.arms 
{

	import org.flixel.*;
	public class StaticObstacle extends FlxSprite
	{
		
		public function StaticObstacle(X:Number, Y:Number, WID:Number, HEI:Number) 
		{
			super(X, Y);
			makeGraphic(WID, HEI, 0xff333333);
			
			immovable = true;
			
		}
		
	}

}