package 
{
	import flash.display.MovieClip;
	import flash.text.*;

	public class TextFieldCFT650px extends MovieClip
	{
		
		private var content					: String;
		
		public function TextFieldCFT650px(pcontent:String) 
		{
			content = pcontent;
			TXT.wordWrap = true;
			TXT.autoSize = TextFieldAutoSize.LEFT;
			TXT.htmlText = content;
		}
		
	}
	
}