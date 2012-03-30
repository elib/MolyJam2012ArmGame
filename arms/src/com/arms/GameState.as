package com.arms 
{
	import com.hud.Hud;
	import org.flixel.*;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;

	import flash.geom.*;
	public class GameState extends FlxState
	{
		public var _player:Player;
		private var _environment:Environment;
		private var _hud: Hud;
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
			
			spawnPlayer();
			
			_hud = new Hud();
			this.add(_hud);
			
			FlxG.follow(_player, 2);
			FlxG.followBounds(_environment.GetObstacles().left, _environment.GetObstacles().top, _environment.GetObstacles().right, _environment.GetObstacles().bottom);
			
		}
		
		private function spawnPlayer():void
		{
			var point:FlxPoint = (_environment.spawnPoints[0] as FlxPoint);
			_player.reset(point.x, point.y);
		}
		
		override public function render():void 
		{
			super.render();
			FlxG.buffer.applyFilter(FlxG.buffer,new Rectangle(0,0,FlxG.width,FlxG.width),new Point(0,0),_coolFilter);
			_hud.render();
		}
		
		 
		override public function postProcess():void 
		{
			super.postProcess();
			
		    //FlxG.buffer.applyFilter(FlxG.buffer,new Rectangle(0,0,FlxG.width,FlxG.width),new Point(0,0),_coolFilter);
			s
	
		}
		
		var lightFuzzyness:Number = 0;
		override public function update():void
		{
			super.update();	
		
			lightFuzzyness += FlxG.elapsed;
			var playerXY:FlxPoint = _player.getScreenXY()
			
			_coolFilter.shader.data.radius.value = [Math.max(_player.babyShakenAmount, 0.1) * 60 + (Math.abs(Math.sin(Math.PI * 2 * lightFuzzyness * Math.random() * 0.5))) * 1.5 ];
			_coolFilter.shader.data.lightPosition.value = [playerXY.x + _player.frameWidth / 2, playerXY.y + _player.frameHeight / 2];
			//debugBar.scale.x = _player.babyShakenAmount;
			
			
			FlxU.collide(_player, _environment.GetObstacles());

		}
	}

}