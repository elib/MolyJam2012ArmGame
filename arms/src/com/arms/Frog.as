package com.arms 
{
	import org.flixel.*;
	
	public class Frog extends FlxSprite
	{
		[Embed(source = '../../../../assets/sprites/monster_frog.png')] private var ImgFrog:Class;
		public function Frog(point:FlxPoint)
		{
			super(point.x, point.y);
			loadGraphic(ImgFrog, true, true, Arms.TILESIZE, Arms.TILESIZE);
		}
		
	}

}