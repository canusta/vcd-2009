package
{
	import flash.display.MovieClip;
	import flash.text.*;
	
	public class TextFieldBttnCFT650px extends MovieClip
	{
		
		public var content					: String;
		public var src						: String;
		
		public function TextFieldBttnCFT650px(pcontent:String) 
		{
			content = pcontent;
			TXT.wordWrap = true;
			TXT.autoSize = TextFieldAutoSize.LEFT;
			TXT.htmlText = content;
		}
		
	}
	
}