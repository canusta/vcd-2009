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
	
	public class PageInternational extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var univ				: VcdTwoThousandAndNine;
		private var text				: TextFieldCFT830px;
		private var database			: Database;
		private var scroll				: Scroll;
		private var subplaintext		: SubPlainText;
		
		public function PageInternational(pdatabase:Database, puniv:VcdTwoThousandAndNine) 
		{
			univ						   = puniv;
			database 					   = pdatabase;
			init();
		}
		
		private function init()
		{
			subplaintext = new SubPlainText(database.data.international);
			this.addChild(subplaintext);
		}
		
	}
	
}