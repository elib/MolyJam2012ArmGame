package com.arms 
{
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
		private var _player:Player;
		private var _environment:Environment;
		
		public function GameState() 
		{
			super();
		}
		
		override public function create():void 
		{
			super.create();
			
			
			_environment = new Environment();
			this.add(_environment.GetObstacles());
			
			_player = new Player();
			this.add(_player);
		}
		
		
		
	}

}