package
{
	
	import flash.display.MovieClip;
	import flash.text.*;
	
	public class TextFieldAutoscape15px_220px extends MovieClip
	{
		
		private var content					: String;
		
		public function TextFieldAutoscape15px_220px(pcontent:String) 
		{
			content = pcontent;
			TXT.wordWrap = true;
			TXT.autoSize = TextFieldAutoSize.LEFT;
			TXT.htmlText = content;
		}
		
	}
	
}