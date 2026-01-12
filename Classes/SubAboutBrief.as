package
{
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import com.canusta.data.Database;
	import com.canusta.text.*;
	import com.canusta.gui.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class SubAboutBrief extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var text				: TextFieldCFT830px;
		private var database			: Database;
		private var subplaintext		: SubPlainText;
		private var scroll				: Scroll;
		
		public function SubAboutBrief(pdatabase:Database) 
		{
			
			database = pdatabase;
			/*var empty:SubEmpty = new SubEmpty();
			this.addChild(empty);
			var text : TextFieldCFT830px = new TextFieldCFT830px(database.data.brief);
			empty.contentMC.addChild(text);
			var scroll = new Scroll(960, 346, global.stageHeight-366, empty.contentMC, empty.contentMC.y, 0);
			this.addChild(scroll);*/
			
			subplaintext = new SubPlainText(database.data.brief);
			this.addChild(subplaintext);
			
		}
		
	}
	
}