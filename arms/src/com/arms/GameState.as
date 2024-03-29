package com.arms 
{
	import com.hud.Hud;
	import flash.display.PixelSnapping;
	import org.flixel.*;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;

	import flash.geom.*;
	public class GameState extends FlxState
	{
		public var _player:Player;
		private var _frogs:FlxGroup;
		private var _powerups:FlxGroup;
		
		private var _environment:Environment;
		private var _hud: Hud;
		private var _debugBar:FlxSprite;
		
		//effects
		[Embed(source = "/../../data/fade.pbj", mimeType = "application/octet-stream")] private var FilterCode:Class;
		private var _coolShader:Shader = new Shader(new FilterCode());
		private var _coolFilter:ShaderFilter;

		public function GameState() 
		{
			super();
			
			_coolFilter = new ShaderFilter(_coolShader);	
			_coolFilter.shader.data.lightPosition.value = [100, 150];
			_coolFilter.shader.data.radius.value = [50];
		}
		
		override public function create():void 
		{
			super.create();
			
			_environment = new Environment();
			this.add(_environment);
			
			_player = new Player();
			this.add(_player);
			
			spawnPlayer();
			
			_hud = new Hud();
			this.add(_hud);
			
			_frogs = new FlxGroup();
			this.add(_frogs);
			for (var i:int = 0; i < _environment.frogPoints.length; i++)
			{
				var frog:Frog = new Frog(_environment.frogPoints[i], _environment.frogPaths[i]);
				_frogs.add(frog);
			}
			
			_powerups = new FlxGroup();
			this.add(_powerups);
			for each(var powerpoint:FlxPoint in _environment.powerupPoints)
			{
				_powerups.add(new Powerup(powerpoint));
			}
			
			
			//setup camera rules
			FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN);
			_environment.follow();
			
		}
		
		private function spawnPlayer():void
		{
			var point:FlxPoint = (_environment.spawnPoints[0] as FlxPoint);
			_player.reset(point.x, point.y);
		}
		
		 
		override public function draw():void 
		{
			super.draw();

		    FlxG.camera.buffer.applyFilter(FlxG.camera.buffer,new Rectangle(0,0,512, 512),new Point(0,0),_coolFilter);
			_hud.draw();

		}
		
		private var lightFuzzyness:Number = 0;
		override public function update():void
		{
			super.update();	
			
			FlxG.collide(_player, _environment.GetObstacles(), PlayerHit);
			
			//filtering goodness!
			lightFuzzyness += FlxG.elapsed;
			var playerXY:FlxPoint = _player.getScreenXY()
			
			_coolFilter.shader.data.radius.value = [Math.max(_player.babyShakenAmount, 0.1) * 60 + (Math.abs(Math.sin(Math.PI * 2 * lightFuzzyness * Math.random() * 0.5))) * 1.5 ];
			_coolFilter.shader.data.lightPosition.value = [playerXY.x + _player.frameWidth / 2, playerXY.y + _player.frameHeight / 2];
			//debugBar.scale.x = _player.babyShakenAmount;
		}
		
		private function PlayerHit(obj1:FlxObject, obj2:FlxObject):void
		{
			FlxG.log("" + obj1 + " hit " + obj2);
		}
	}

}