package com.arms 
{
	import org.flixel.*;
	
	public class Frog extends FlxSprite
	{
		[Embed(source = '../../../../assets/sprites/monster_frog.png')] private var ImgFrog:Class;
		
		private var _path:FlxPath;
		
		public function Frog(point:FlxPoint, path:FlxPath)
		{
			super(point.x, point.y);
			loadGraphic(ImgFrog, true, true, Arms.TILESIZE, Arms.TILESIZE);
			_path = path;
			
			this.followPath(_path, 50, PATH_LOOP_FORWARD);
		}
		
		
		
	}

}