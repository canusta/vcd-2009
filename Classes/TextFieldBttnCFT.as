package 
{
	
	import flash.display.MovieClip;
	import flash.text.*;
	
	public class TextFieldBttnCFT extends MovieClip
	{
		
		private var content					: String;
		
		public function TextFieldBttnCFT(pcontent:String) 
		{
			content = pcontent;
			TXT.wordWrap = true;
			TXT.autoSize = TextFieldAutoSize.LEFT;
			TXT.htmlText = content;
		}
		
	}
	
}