package com.arms 
{
	import org.flixel.*;
	import util.*;
	
	public class Environment extends FlxGroup
	{
		[Embed(source = "../../../../assets/map/world1.tmx", mimeType = "application/octet-stream")] public static var World1Map:Class;
		[Embed(source = '../../../../assets/map/tiles.png')] private var ImgTiles:Class;
		
		protected var _map:FlxTilemap;
		protected var _foremap:FlxTilemap;
		protected var _bgmap:FlxTilemap;
		public var spawnPoints:Array;

		
		public function Environment():void
		{
			super();
			
			LoadMapAndObjects();
		}
		
		public function GetObstacles():FlxObject
		{
			return _map;
		}
		
		//follow the coolest object you can find
		public function follow():void
		{
			_map.follow();
		}
		
		protected function LoadMapAndObjects():void
		{
			var x:XML = XML(new World1Map);
			var tmx_map:TmxMap = new TmxMap(x);

			//Basic level structure
			_map = new FlxTilemap();
			//_map.startingIndex = 0;
			//_map.collideIndex = 2;
			
			_bgmap = new FlxTilemap();
			_foremap = new FlxTilemap();
			//_bgmap.startingIndex = 0;
			
			//generate a CSV from the layer 'map' with all the tiles from the TileSet 'tiles'
			var mapCsv:String = tmx_map.getLayer('Collision').toCsv(tmx_map.getTileSet('foreground_colliding'));
			_map.loadMap(mapCsv, ImgTiles, Arms.TILESIZE, Arms.TILESIZE, FlxTilemap.OFF, 0, 2, 2);
			
			mapCsv = tmx_map.getLayer('Foreground').toCsv(tmx_map.getTileSet('foreground_colliding'));
			_foremap.loadMap(mapCsv, ImgTiles, Arms.TILESIZE, Arms.TILESIZE, FlxTilemap.OFF, 0);
			
			mapCsv = tmx_map.getLayer('Background').toCsv(tmx_map.getTileSet('foreground_colliding'));
			_bgmap.loadMap(mapCsv, ImgTiles, Arms.TILESIZE, Arms.TILESIZE, FlxTilemap.OFF, 0);
			_bgmap.scrollFactor.x = _bgmap.scrollFactor.y = 0.2;
			
			this.add(_bgmap);
			this.add(_foremap);
			this.add(_map);
			
			spawnPoints = new Array();
			
			var group:TmxObjectGroup = tmx_map.getObjectGroup('Metadata');
			for each(var object:TmxObject in group.objects)
				spawnObject(object)
		}
		
		protected function spawnObject(obj:TmxObject):void
		{
			//snap to grid
			obj.x = obj.x - (obj.x % Arms.TILESIZE);
			obj.y = obj.y - (obj.y % Arms.TILESIZE);
			obj.width = obj.width - (obj.width % Arms.TILESIZE);
			obj.height = obj.height - (obj.height % Arms.TILESIZE);
			
			//Add game objects based on the 'type' property
			switch(obj.type)
			{
				case "spawn":
				{
					spawnPoints.push(new FlxPoint(obj.x, obj.y));
					return;
				}
			}
		}
		
		public function mapWidth():int
		{
			return _map.widthInTiles;
		}
		
		public function mapHeight():int
		{
			return _map.heightInTiles;
		}
		
	}

}