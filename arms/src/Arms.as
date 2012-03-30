package  
{
	import org.flixel.*;
	import com.arms.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
 
	public class Arms extends FlxGame
	{
		public static const TILESIZE:int = 16;
		
		public function Arms()
		{
			super(320,240,GameState,2);
		}
	}
}