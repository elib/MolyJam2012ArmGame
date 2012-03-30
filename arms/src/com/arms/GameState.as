package com.arms 
{
	import org.flixel.*;
	public class GameState extends FlxState
	{
		private var _player:Player;
		private var _environment:Environment;
		
		private var _debugBar:FlxSprite;

		
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
			
			
			_debugBar = new FlxSprite(0, FlxG.height - 10);
			_debugBar.createGraphic(FlxG.width, 10, 0xffff0000);
			_debugBar.scale.x = 0.0;
			this.add(_debugBar);
			
		}
		
		override public function update():void
		{
			super.update();	
			
			_debugBar.scale.x = _player.babyShakenAmount; //int(_player.babyShakenAmount * FlxG.width);

		}
	}

}