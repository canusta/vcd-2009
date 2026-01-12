package 
{
	
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.text.*;
	import flash.net.*;
	import flash.utils.*;
	import com.canusta.*;
	import com.canusta.gui.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class VcdTwoThousandAndNine extends MovieClip
	{
		
		
		private var global				: Global = Global.getInstance();
		private var world		        : World;
		private var smenu		        : SectionMenu;
		public var spreloader	        : SectionPreloader;
		private var scontent	        : SectionContent;
		private var pannouncements      : PartAnnouncements;
		private var aligner				: Align;
		private var preloaderblocker	: BttnBlocker ;
		private var menublocker			: BttnBlocker;
		private var contentblocker		: BttnBlocker;
		public var currentPage			: String;
		public var currentPart:int 		= 1;
		public var language:String		= "eng";
		private var timer				: Timer;
		
		
		public function VcdTwoThousandAndNine()
		{
			if (global.language) this.language = global.language;
			this.addEventListener(Event.ADDED_TO_STAGE, run);
			//trace("a ha")
		}
		
		private function run(e:Event)
		{
			global.univ = this;
			global.currentpage = null;
			
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP;
			stage.addEventListener(Event.RESIZE, stageResized);
			
			global.stageHeight = stage.stageHeight;
			
			init();
		}
		
		private function init()
		{
			
			world				= new World(this);
			smenu				= new SectionMenu(this);
			spreloader			= new SectionPreloader();
			scontent			= new SectionContent(this);
			pannouncements 		= new PartAnnouncements(this, spreloader);
			aligner 			= new Align(this);
			preloaderblocker 	= new BttnBlocker();
			menublocker			= new BttnBlocker();
			contentblocker		= new BttnBlocker();
			
			//content section'indaki sayfalari tutmak icin.
			global.currentPage = null;
			
			pannouncements.alpha = 0;
			
			addChild(world);
			world.addChild(smenu);
				menublock();
			world.addChild(spreloader);
				spreloader.addChild(pannouncements);
			world.addChild(scontent);
				contentblock();
			
			aligner.arrange(world, world, "yes", "C", "no");
			
		}
		
		private function menublock()
		{
			smenu.addChild(menublocker);
			menublocker.block();
			Tweener.addTween(smenu, { alpha:0.3, time:0, transition:"easeOutExpo" } );
		}
		
		private function preloaderblock()
		{
			spreloader.addChild(preloaderblocker);
			preloaderblocker.block();
			Tweener.addTween(spreloader, { alpha:0.3, time:0, transition:"easeOutExpo" } );
		}
		
		private function contentblock()
		{
			scontent.addChild(contentblocker);
			contentblocker.block();
			Tweener.addTween(scontent, { alpha:0.3, time:0, transition:"easeOutExpo" } );
		}
		
		private function menuunblock()
		{
			smenu.removeChild(menublocker);
			Tweener.addTween(smenu, { alpha:1, time:1, transition:"easeOutExpo" } );
		}
		
		private function preloaderunblock()
		{
			spreloader.removeChild(preloaderblocker);
			Tweener.addTween(spreloader, { alpha:1, time:1, transition:"easeOutExpo" } );
		}
		
		private function contentunblock()
		{
			scontent.removeChild(contentblocker);
			Tweener.addTween(scontent, { alpha:1, time:1, transition:"easeOutExpo" } );
		}

		private function stageResized(e:Event)
		{
			global.stageHeight = stage.stageHeight;
			stageResize();
		}
		
		private function stageResize()
		{
			switch (currentPart)
			{
			case 0:
			toMenu()
			break;
			case 1:
			toPreloader()
			break;
			case 2:
			toContent()
			break;
			default:
			trace ("Current Part Error")
			}
		}
		
		public function changeLang()
		{
			if (currentPart != 1)
			{
				toPreloader();
				spreloader.startToPreload();
				var langTimer : Timer = new Timer(1000, 1);
				langTimer.addEventListener(TimerEvent.TIMER, loadOtherLanguage);
				langTimer.start();
			}
			else {
				this.dispatchEvent(new Event("LANGUAGE"));
			}
		}
		
		private function loadOtherLanguage(e:TimerEvent)
		{
			this.dispatchEvent(new Event("LANGUAGE"));
		}
		
		public function check()
		{
			trace("checked");
		}
		
		public function toMenu()
		{
			aligner.arrange(world, world, "yes", "L", "yes");
			currentPart = 0;
			menuunblock();
			preloaderblock();
			contentblock();
		}
		
		public function toPreloader()
		{
			aligner.arrange(world, world, "yes", "C", "yes");
			currentPart = 1;
			menublock();
			preloaderunblock();
			contentblock();
		}
		
		public function toContent()
		{
			aligner.arrange(world, world, "yes", "R", "yes");
			currentPart = 2;
			aligner.addEventListener("arranged", startBlinkMenuBttn);
			menublock();
			preloaderblock();
			contentunblock();
		}
		
		private function startBlinkMenuBttn(e:Event)
		{
			aligner.removeEventListener("arranged", startBlinkMenuBttn);
			var timertimer:Timer = new Timer(10, 1);
			timertimer.addEventListener(TimerEvent.TIMER, firetimer);
			timertimer.start();
		}
		
		private function firetimer(e:Event)
		{
			timer = new Timer(100, 5);
			timer.addEventListener(TimerEvent.TIMER, blinkMenuBttn);
			timer.start();
		}
		
		private function blinkMenuBttn(e:Event)
		{
			Tweener.addTween(scontent.menuBTTN, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(scontent.menuBTTN, { alpha:1, time:0.5, transition:"easeOutExpo" } );
		}
		
		public function toUp( str:String):String
		{
			var chars = str.split("");
			var out	: Array = new Array();
			var len : Number = chars.length;
			
			for (var i : Number = 0;  i < len ; i++) 
			{
				var ch : Number		= chars[i].charCodeAt(0);
				var c  : String 	= chars[i];		
				if(ch == 105) out.push('İ');
				else if(ch == 305) out.push('I');
				else if(ch == 287) out.push('Ğ');
				else if(ch == 252) out.push('Ü');
				else if(ch == 351) out.push('Ş');
				else if(ch == 246) out.push('Ö');
				else if(ch == 231) out.push('Ç');
				else if(ch >= 97 && ch <= 122)
					out.push(c.toUpperCase());
				else
					out.push(c);
			}
			return out.join('');			
		}
		
		public function get _currentPage ():String{
			return currentPage;
		}
		
		public function set _currentPage (__currentPage:String){
			currentPage = __currentPage;
		}
		
		public function get _currentPart ():int{
			return currentPart;
		}
		
		public function set _currentPart (__currentPart:int){
			currentPart = __currentPart;
			stageResize();
		}
		
		public function get _language():String{
			return language;
		}
		
		public function get _world():World{
			return world;
		}
		
		public function get _scontent():SectionContent{
			return scontent;
		}
		
	}
}