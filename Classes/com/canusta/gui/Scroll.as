package com.canusta.gui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Math;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	/**
	* ...
	* @author Can Usta
	*/
	public class Scroll extends MovieClip
	{
		
		private var global					: Global = Global.getInstance();
		private var xi						: Number;
		private var yi						: Number;
		private var content					: Object;
		private var contentfirsty			: Number;
		private var contentMargin			: Number; //48
		private var scrollratio				: Number;
		private var scrollStartMouseY		: Number;
		private var scrollStartBarY			: Number;
		private var scrollbgheight			: Number;
		private var alterscrollbgheight		: Number;
		private var activecontentspaceheight: Number;
		private var contentheight			: Number;
		private var scrollbarheight			: Number;
		
		public function Scroll(pxi:Number, pyi:Number, pbgheight:Number, pcontent:Object, pcontentfirsty:Number, pcontentMargin:Number) 
		{
			
			xi = pxi;
			yi = pyi;
			scrollbgheight = pbgheight;
			alterscrollbgheight = pbgheight;
			content = pcontent;
			contentMargin = pcontentMargin;
			contentfirsty = pcontentfirsty;
			this.x = xi;
			this.y = yi;
			this.bgMC.height = scrollbgheight;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
		private function destroy(e:Event)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doScroll);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopScroll);
			//stage.removeEventListener(Event.RESIZE, rebuildScroll);
		}
		
		private function init(e:Event)
		{
			bttn.addEventListener(MouseEvent.MOUSE_DOWN, startScroll);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
			//stage.addEventListener(Event.RESIZE, rebuildScroll);
			rebuildScroll();
		}
		
		private function startScroll(e:MouseEvent)
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, doScroll);
			scrollStartMouseY = mouseY;
			scrollStartBarY = barMC.y;
		}
		
		private function stopScroll(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doScroll);
		}
		
		private function doScroll(e:MouseEvent = null)
		{
			
			var targetY = scrollStartBarY + (mouseY - scrollStartMouseY);
			if (targetY<=0)
			{
				targetY = 0;
			}
			if (targetY >= scrollbgheight - scrollbarheight)
			{
				targetY = scrollbgheight - scrollbarheight;
			}
			barMC.y = targetY;
			var scrollActualAreaHeight:Number = scrollbgheight - scrollbarheight;
			var scrollActualPosition:Number = scrollActualAreaHeight - targetY ;
			var scrollPercent:Number = (scrollActualPosition * 100) / scrollActualAreaHeight;
			var contentActualAreaHeight:Number = scrollbgheight;
			var contentPercent:Number = ( contentheight - contentActualAreaHeight ) / 100;
			var targety:Number = ( 0 - ( (100 - scrollPercent) * contentPercent ) ) + contentfirsty;
			Tweener.addTween(content, { y:Math.round(targety), time:1, transition:"easeOutExpo" } );
		}
		
		public function rebuildScroll(e:Event = null)
		{
			
			//resizing the bgMC
			scrollbgheight = global.stageHeight - 366;
			alterscrollbgheight = global.stageHeight - 366;
			Tweener.addTween(bgMC, { height:Math.round(alterscrollbgheight), time:1, transition:"easeOutExpo" } );
			
			// scrollbgheight ile contentin gozuken yuksekligi esit
			contentheight = content.height + contentMargin;
			activecontentspaceheight = bgMC.height;
			scrollbgheight = bgMC.height;
			bttn.height = scrollbgheight + 40;
			scrollratio = activecontentspaceheight / contentheight;
			if (scrollratio >= 1)
			{
				scrollratio = 1;
				Tweener.addTween(this, { alpha:0, time:1, transition:"easeOutExpo" } );
			}else
			{
				Tweener.addTween(this, { alpha:1, time:1, transition:"easeOutExpo" } );
			}
			scrollbarheight = scrollbgheight * scrollratio;
			Tweener.addTween(barMC, { height:scrollbarheight, time:1, transition:"easeOutExpo" } );
			var differenceOfYofContent : int = contentfirsty - content.y;
			var barMCy : int = ( bgMC.height * differenceOfYofContent ) / content.height;
			Tweener.addTween(barMC, { y:barMCy, time:1, transition:"easeOutExpo" } );
		}
		
	}
	
}