package 
{
	import flash.display.*;
	import flash.text.*;
	import com.canusta.*;
	import com.canusta.text.*;
	import lt.uza.utils.*;
	
	public class SectionPreloader extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var bloaded            : Number;
		private var btotal             : Number;
		private var percent            : String;
		private var percentnum         : Number;
		
		public function SectionPreloader()
		{
			init();
		}
		
		private function init()
		{
			this.x = 1000;
		}
		
		public function startToPreload()
		{
			if (global.language == "eng")
			{
				processNameTxt.text = "LOADING";
			}else {
				processNameTxt.text = "YÜKLENİYOR";
			}
			percentTXT.htmlText = "00";
		}
		
		public function update(pbloaded:Number, pbtotal:Number)
		{
			bloaded = pbloaded;
			btotal = pbtotal;
			percentnum = (bloaded * 100) / btotal;
			if (percentnum >= 99)
			{
				percent = "OK";
				if (global.language == "eng")
				{
					processNameTxt.text = "LOADED";
				}else {
					processNameTxt.text = "YÜKLENDİ";
				}
				
			}else
			{
				percent = String(Math.round(percentnum));
			}
			if (Math.round(percentnum) <= 9) {
				percent = "0" + percent;
			}
			percentTXT.htmlText = percent;
		}
		
	}
}