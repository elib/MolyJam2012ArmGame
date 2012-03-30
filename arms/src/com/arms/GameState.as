package com.arms 
{
	import org.flixel.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
	public class GameState extends FlxState
	{
		private var _player:Player;
		private var _environment:Environment;
		public var _world:b2World;

		
		public function GameState() 
		{
			super();
		}
		
		 
		private function setupWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(0, 9.8);
			_world = new b2World(gravity, true);
		}
 
		override public function create():void 
		{
			super.create();
			setupWorld();
			
			
			_environment = new Environment();
			this.add(_environment.GetObstacles());
			
			_player = new Player();
			var arm = new PlayerArm();
			this.add(_player);
			this.add(arm);
		}
		
		 
		override public function update():void
		{
			_world.Step(FlxG.elapsed, 10, 10);
			super.update();	
		}
	 
			
	}

}