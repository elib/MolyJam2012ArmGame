package com.arms 
{
	import org.flixel.*;
	
	public class Powerup extends FlxSprite
	{
		[Embed(source = '../../../../assets/sprites/powerup_bottle.png')] private var ImgBottle:Class;
		
		private var _path:FlxPath;
		
		public function Powerup(point:FlxPoint)
		{
			super(point.x, point.y);
			loadGraphic(ImgBottle, true, true, Arms.TILESIZE, Arms.TILESIZE);
			_path = path;
		}
	}
}