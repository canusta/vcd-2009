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
	
	public class SubAboutScholarships extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var text				: TextFieldCFT830px;
		private var database			: Database;
		private var subplaintext		: SubPlainText;
		private var scroll				: Scroll;
		
		public function SubAboutScholarships(pdatabase:Database) 
		{
			
			database = pdatabase;
			subplaintext = new SubPlainText(database.data.scholarships);
			this.addChild(subplaintext);
			
		}
		
	}
	
}