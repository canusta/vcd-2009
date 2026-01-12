package 
{
	import flash.display.*;
	import flash.net.*;
	import flash.text.*;
	import flash.events.*;
	import lt.uza.utils.*;
	
	public class Vcd extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		
		public function Vcd() 
		{
			global.language = "eng";

			if (this.loaderInfo.parameters["lang"]) global.language = this.loaderInfo.parameters["lang"];

			loadMainContent();
		}

		private function loadMainContent ()
		{
			removeAllChildren();

			var bgLoader:Loader = new Loader();
			var bgURL:URLRequest = new URLRequest("vcd2009_" + global.language + ".swf");
			bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, run);
			bgLoader.load(bgURL);
		}

		private function removeAllChildren ()
		{
			var i:int = this.numChildren;
			while (i--) this.removeChildAt(i);
		}

		private function run(e:Event)
		{
			e.target.loader.content.addEventListener("LANGUAGE", switchLanguage);
			this.addChild(e.target.loader);
		}

		private function switchLanguage (e:Event)
		{
			global.language = (global.language == "eng") ? "tr" : "eng";
			loadMainContent();
			resetGlobals();
		}
		
		private function resetGlobals()
		{
			global.currentPage = null;
			global.currentpageobj = null;
		}
		
	}
	
}