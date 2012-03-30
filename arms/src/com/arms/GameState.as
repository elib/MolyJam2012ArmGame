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
		
		 
		private function setupWorld():void
		{
		}
 
		override public function create():void 
		{
			super.create();
			setupWorld();
			
			
			_environment = new Environment();
			this.add(_environment.GetObstacles());
			
			_player = new Player();
			var arm:PlayerArm = new PlayerArm();
			this.add(_player);
			this.add(arm);
		}
		
		 
		
		override public function draw():void 
		{
			
			super.draw();
		}
		override public function update():void
		{
			super.update();	
		}
	 
			
	}

}