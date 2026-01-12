package 
{
	
	import flash.display.*;
	import caurina.transitions.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import com.canusta.gui.*;
	import VcdTwoThousandAndNine;
	import lt.uza.utils.*;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Can Usta
	$(CBI)*/
	
	public class VideoPlayer extends MovieClip
	{
		
		private var global : Global = Global.getInstance();
		private var movie : String;
		private var owner : Object;
		private var aligner : Align;
		private var mRoot : VcdTwoThousandAndNine;
		private var base = mRoot;
		private var basewidth : Number;
		private var baseheight : Number;
		private var basex : Number;
		private var basey : Number;
		private var targetwidth : Number;
		private var targety : Number;
		private var targetx : Number;
		private var targetheight : Number;
		private var video : Video;
		private var ns : NetStream;
		private var nc : NetConnection;
		
		private var canvaswidth : int = 1000;
		private var canvasheight : int = 700;
		
		public function VideoPlayer(pmovie : String, powner : Object) 
		{
			
			mRoot = global.univ;
			movie = pmovie;
			owner = powner;
			Tweener.addTween(bgMC, { alpha:0.9, time:1, transition:"easeOutExpo" } );
			
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, backBttnOver);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, backBttnOut);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, backBttnClicked);
			
			video = new Video(320, 240);
			addChild(video);
			
			nc = new NetConnection();
			nc.connect(null);
			
			ns = new NetStream(nc);
			ns.addEventListener(NetStatusEvent.NET_STATUS, onStatusEvent);
			
			var meta:Object = new Object();
			meta.onMetaData = function(meta:Object)
			{
				trace(meta.duration);
			}
			
			ns.client = meta;
			
			video.attachNetStream(ns);
			targetheight = video.height;
			targetwidth = video.width;
			alignVideo();
			
			
			ns.play(movie);
			
		}
		
		function onStatusEvent(stat:Object):void
		{
			trace(stat.info.code);
		}
		
		private function alignVideo()
		{
			base = mRoot;
			basewidth = mRoot.stage.stageWidth;
			baseheight = mRoot.stage.stageHeight;
			basex = (canvaswidth - basewidth) / 2;
			basey = (canvasheight - baseheight) / 2;
			targetx = basex + ( ( basewidth - targetwidth ) / 2 );
			targety = 0 + ( ( baseheight - targetheight ) / 2 );
			video.x = targetx;
			video.y = targety;
		}
		
		private function backBttnOver(e:MouseEvent):void
		{
			e.currentTarget.parent.alpha = 1;
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:-90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:3, time:1, transition:"easeOutExpo" } );
		}
		
		private function backBttnOut(e:MouseEvent)
		{
			e.currentTarget.parent.alpha = 0.5;
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:15, time:1, transition:"easeOutExpo" } );
		}
		
		private function backBttnClicked(e:MouseEvent)
		{
			close();
		}
		
		public function close()
		{
			Tweener.addTween(this, { alpha:0, time:1, transition:"easeOutExpo", onComplete:unload } );
		}
		
		private function unload(e:Event = null)
		{
			video.attachNetStream(null);
			ns.close();
			ns.removeEventListener(NetStatusEvent.NET_STATUS, onStatusEvent);
			nc.close();
			removeChild(video);
			owner.removeChild(this);
		}
		
	}
	
}