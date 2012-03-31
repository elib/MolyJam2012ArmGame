/*******************************************************************************
 * Copyright (c) 2010 by Thomas Jahn
 * Questions or license requests? Mail me at lithander@gmx.de!
 ******************************************************************************/
package util
{
	import org.flixel.FlxPoint;
	public class TmxObject
	{
		public var group:TmxObjectGroup;
		public var name:String;
		public var type:String;
		public var x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		public var gid:int;
		public var custom:TmxPropertySet;
		public var shared:TmxPropertySet;
		
		public var polyline:Array;
		
		public function TmxObject(source:XML, parent:TmxObjectGroup)
		{
			group = parent;
			name = source.@name;
			type = source.@type;
			x = source.@x; 
			y = source.@y; 
			width = source.@width; 
			height = source.@height;
			
			polyline = new Array();
			
			var childrenpoly:XMLList = source.child("polyline");
			if (childrenpoly.length() > 0)
			{
				var polychild:XML = childrenpoly[0];
				var strpoly:String = polychild.@points;
				var points:Array = strpoly.split(" ");
				for each(var ptstr:String in points)
				{
					var pair:Array = ptstr.split(",");
					polyline.push(new FlxPoint(int(pair[0]) + x, int(pair[1]) + y));
				}
			}
			
			//resolve inheritence
			shared = null;
			gid = -1;
			if(source.@gid.length != 0) //object with tile association?
			{
				gid = source.@gid;
				for each(var tileSet:TmxTileSet in group.map.tileSets)
				{
					shared = tileSet.getPropertiesByGid(gid);
					if(shared)
						break;
				}
			}
			
			//load properties
			var node:XML;
			for each(node in source.properties)
				custom = custom ? custom.extend(node) : new TmxPropertySet(node);
		}
	}
}