package com.arms 
{

	import org.flixel.*;
	
	public class Environment
	{

		private var _obsGroup:FlxGroup;
		
		public function Environment() 
		{
			_obsGroup = new FlxGroup();
			
			var obs:StaticObstacle = new StaticObstacle(0, FlxG.height - 50, FlxG.width, 50);
			_obsGroup.add(obs);
		}
		
		public function GetObstacles():FlxGroup
		{
			return _obsGroup;
		}
		
	}

}