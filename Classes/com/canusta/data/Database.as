/**
* @author Can Usta (http://www.canusta.com)
*/

package com.canusta.data
{
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.*;
	import flash.events.*;
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import lt.uza.utils.*;
	
	public class Database extends EventDispatcher
	{
		
		private var global						: Global = Global.getInstance();
		private var owner:Object;
		private var univ:VcdTwoThousandAndNine;
		private var spreloader:Object;
		private var imageLoader:Loader;
		public var xml:XML;
		public var outSource:String;
		public var xmlList:XMLList;
		private var xmlLoader:URLLoader = new URLLoader();
		private var loadedPer:Number;
		
		public function Database(xmlLink:String, Owner:Object, puniv:VcdTwoThousandAndNine)
		{
			if (puniv == null)
			{
				univ = global.univ;
			}else
			{
				univ = puniv;
			}
			
			owner = Owner;
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(ProgressEvent.PROGRESS, loadingProgress);
			xmlLoader.load(new URLRequest(xmlLink));
			univ.spreloader.startToPreload();
		}
		
		private function xmlLoaded(e:Event)
		{
			/*var myTimer:Timer = new Timer(1000, 1); // 1 second
			myTimer.addEventListener(TimerEvent.TIMER, runOnce);
			myTimer.start();

			function runOnce(event:TimerEvent):void {
				
			}*/
			xml = new XML(xmlLoader.data);
			dispatchEvent(new Event("databaseloaded"));
			//trace("xml loaded")
			//dispatchEvent({type:"databaseloaded", target:this});
			//trace(xml.item.(@id == "20"))
			//xml = XML(e.target.data);
			//xmlList = xml.children();
			//trace(xml.db.announcements.item.(@name == "Hello VCD").@date)
			//trace(xml.db.announcements.item.(@name == "Hello VCD"))
			/*for each(var item in xml.db.announcements.item)
			{
				trace("__", item.@name)
			}*/
		}
		
		public function get data():XML{
			return xml;
		}
		
		private function loadingProgress(event:ProgressEvent):void {
			univ.spreloader.update(event.bytesLoaded, event.bytesTotal);
            //trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
			//loadedPer = (event.bytesLoaded * 100 ) / event.bytesTotal;
			//owner.owner.updateProgress(loadedPer)
			//trace(root.deneme)
			}
	}
}

/*package com.canusta.data
{
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.*;
	import flash.events.*;
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Database extends EventDispatcher
	{
		
		public var owner:Object;
		private var imageLoader:Loader;
		public var xml:XML;
		public var outSource:String;
		public var xmlList:XMLList;
		private var xmlLoader:URLLoader = new URLLoader();
		private var loadedPer:Number;
		
		public function Database(xmlLink:String, Owner:Object)
		{
			owner = Owner;
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(ProgressEvent.PROGRESS, loadingProgress);
			xmlLoader.load(new URLRequest(xmlLink));
		}
		
		private function xmlLoaded(e:Event)
		{
			xml = new XML(xmlLoader.data);
			dispatchEvent(new Event("databaseloaded"));
		}
		
		public function get data():XML{
			return xml;
		}
		
		private function loadingProgress(event:ProgressEvent):void {

			}
	}
}*/