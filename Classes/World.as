package 
{
	
	import flash.display.*;
	import com.canusta.*;
	import com.canusta.gui.Align;
	
	public class World extends MovieClip
	{
		private var canvas                    : VcdTwoThousandAndNine;
		private var aligner                   : Align;
		
		public function World(pCanvas:VcdTwoThousandAndNine)
		{
			aligner 	= new Align(pCanvas);
			init();
		}
		
		private function init()
		{
			
		}
	}
}