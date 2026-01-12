package
{
	import flash.display.MovieClip;
	import flash.text.*;
	
	public class TextFieldAutoscape220px extends MovieClip
	{
		
		private var content					: String;
		
		public function TextFieldAutoscape220px(pcontent:String) 
		{
			content = pcontent;
			TXT.wordWrap = true;
			TXT.autoSize = TextFieldAutoSize.LEFT;
			TXT.htmlText = content;
		}
		
	}
	
}