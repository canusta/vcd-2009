package
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import caurina.transitions.*;
	import flash.utils.Timer;
	
	public class EafImageBttn extends MovieClip
	{
		
		private var id				: Number;
		private var page			: Object; // owner
		private var image			: Object;
		private var glowcount		: Number					= 10;
		
		public function EafImageBttn(pid:Number, ppage:Object, pimage:Object) 
		{
			trace("EafImageBttn")
			id = pid;
			image = pimage;
			init();
		}
		
		private function init()
		{
			Tweener.addTween(bttnGraph, { alpha:0.5, time:0, transition:"easeOutExpo" } );
			bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
			bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
			videoBttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, videoBttnOver);
			videoBttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, videoBttnOut);
		}
		
		private function bttnOver(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bttnGraph.arrow, { rotation:90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.bttnGraph.arrow, { x:103, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.target.parent.bttnGraph, { alpha:1, time:1, transition:"easeOutExpo" } );
			glow(image);
		}
		
		private function bttnOut(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bttnGraph.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.bttnGraph.arrow, { x:90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.target.parent.bttnGraph, { alpha:0.5, time:1, transition:"easeOutExpo" } );
			removeGlow(image);
		}
		
		private function videoBttnOver(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:200, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.target.parent, { alpha:1, time:1, transition:"easeOutExpo" } );
		}
		
		private function videoBttnOut(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:187, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.target.parent, { alpha:0.5, time:1, transition:"easeOutExpo" } );
		}
		
		public function get _id():Number{
			return id;
		}
		
		private function glow(target)
		{
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xBDB8A5;
			glow.alpha = 0.5;
			glow.blurX = 25;
			glow.blurY = 25;
			glow.quality = BitmapFilterQuality.MEDIUM;
			target.filters = [glow];
		}
		
		private function removeGlow(target)
		{
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xBDB8A5;
			glow.alpha = 0.5;
			glow.blurX = 10;
			glow.blurY = 10;
			glow.quality = BitmapFilterQuality.MEDIUM;
			target.filters = [glow];
			glowcount = 10;
			var timer : Timer = new Timer(10, 10);
			timer.addEventListener(TimerEvent.TIMER, fadeOut);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, hideglow);
			timer.start();
		}
		
		private function fadeOut(e:TimerEvent)
		{
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xBDB8A5;
			glow.alpha = 0.5;
			glow.blurX = glowcount;
			glow.blurY = glowcount;
			glow.quality = BitmapFilterQuality.MEDIUM;
			image.filters = [glow];
			glowcount = glowcount-1;
		}
		
		private function hideglow(e:TimerEvent)
		{
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xBDB8A5;
			glow.alpha = 0;
			glow.blurX = 0;
			glow.blurY = 0;
			glow.quality = BitmapFilterQuality.MEDIUM;
			image.filters = [glow];
		}
		
	}
	
}