package com.arms 
{
	import org.flixel.*;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;

	import flash.geom.*;
	public class GameState extends FlxState
	{
		private var _player:Player;
		private var _environment:Environment;
		
		private var _debugBar:FlxSprite;
		[Embed(source = "/../../data/fade.pbj", mimeType = "application/octet-stream")] private var FilterCode:Class;


		private var _coolShader:Shader = new Shader(new FilterCode());
		private var _coolFilter:ShaderFilter;

		public function GameState() 
		{
			super();
			_coolFilter = new ShaderFilter(_coolShader);
			
			_coolFilter.shader.data.lightPosition.value = [100, 150];
			_coolFilter.shader.data.radius.value = [50];
			
			
			this.filters = [_coolFilter];


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
			
			FlxG.follow(_player, 2);
			FlxG.followBounds(_environment.GetObstacles().left, _environment.GetObstacles().top, _environment.GetObstacles().right, _environment.GetObstacles().bottom);
			
		}
		
		 
		override public function postProcess():void 
		{
			super.postProcess();
			
		     FlxG.buffer.applyFilter(FlxG.buffer,new Rectangle(0,0,FlxG.width,FlxG.width),new Point(0,0),_coolFilter);
			
	
		}
		
		override public function update():void
		{
			super.update();	
			_coolFilter.shader.data.radius.value = [Math.max(1, _player.babyShakenAmount * 60)];

			_debugBar.scale.x = _player.babyShakenAmount; //int(_player.babyShakenAmount * FlxG.width);
			
			
			FlxU.collide(_player, _environment.GetObstacles());

		}
	}

}