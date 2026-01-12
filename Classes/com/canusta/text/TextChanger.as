/**
* @author Can Usta (http://www.canusta.com)
*/

package com.canusta.text
{
	
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class TextChanger
	{
		
		private static var type					: String;
		private static var textF				: TextField;
		private static var content				: String;
		private static var currentContent		: String;
		private static var currentLetter		: int;
		private static var speed				: int;
		private static var id					: Number;
		
		public function TextChanger()
		{
			trace("TextChanger is a static class and should not be instantiated.");
		}
		
		public static function changeText(itextF:TextField, icontent:String, itype:String, ispeed:int, iid:Number)
		{
			currentLetter 		= 0;
			currentContent 		= itextF.text;
			textF 				= itextF;
			content 			= icontent;
			type 				= itype;
			speed 				= ispeed;
			id 					= iid;
			if (type == "fill")
			{
				fillChange();
			}
		}
		
		private static function fillChange()
		{
			var tCTimer:Timer = new Timer(speed, content.length+1);
			tCTimer.addEventListener(TimerEvent.TIMER, changeALetter);
			tCTimer.start();
		}
		
		private static function changeALetter(event:TimerEvent):void
		{
			textF.htmlText = content.substring(0, currentLetter) + currentContent.substring(currentLetter, content.length+1);
			currentLetter++;
		}
	}
}

/*package com.canusta.text
{
	
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class TextChanger
	{
		
		private var type:String;
		private var textF:TextField;
		private var content:String;
		private var currentContent:String;
		private var currentLetter:int;
		private var speed:int;
		
		public function TextChanger()
		{
			trace("CLSS on stage | TextChanger");
			
		}
		
		public function changeText(itextF:TextField, icontent:String, itype:String, ispeed:int)
		{
			currentLetter = 0;
			currentContent = itextF.text;
			textF = itextF;
			content = icontent;
			type = itype;
			speed = ispeed;
			if (type == "fill")
			{
				fillChange();
			}
		}
		
		private function fillChange()
		{
			var tCTimer:Timer = new Timer(speed, content.length+1);
			tCTimer.addEventListener(TimerEvent.TIMER, changeALetter);
			tCTimer.start();
		}
		
		private function changeALetter(event:TimerEvent):void
		{
			textF.htmlText = content.substring(0, currentLetter) + currentContent.substring(currentLetter, content.length+1);
			currentLetter++;
		}
	}
}*/