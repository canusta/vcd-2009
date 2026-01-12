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
	
	public class PageAnnouncements extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var univ				: VcdTwoThousandAndNine;
		private var database			: Database;
		private var page				: SubEmpty;
		private var scroll				: Scroll;
		private var anchor				: Number = 0;
		
		public function PageAnnouncements(pdatabase:Database, puniv:VcdTwoThousandAndNine) 
		{
			
			univ						   = puniv;
			database 					   = pdatabase;
			page = new SubEmpty();
			this.addChild(page);
			init();
			
		}
		
		private function init()
		{
			
			
			for ( var i : Number = 0; i < database.data.*.length(); i++ )
			{
				
				var title : TextFieldAutoscape15px = new TextFieldAutoscape15px(database.data.*[i].title);
				page.contentMC.addChild(title);
				title.y = anchor;
				anchor = title.y + title.height;
				
				var date : TextFieldCFT830px = new TextFieldCFT830px(database.data.*[i].date.toString());
				page.contentMC.addChild(date);
				date.y = anchor;
				anchor = date.y + date.height;
				
				var content : TextFieldCFT830px = new TextFieldCFT830px(database.data.*[i].content.toString());
				page.contentMC.addChild(content);
				content.y = anchor;
				anchor = content.y + content.height;
				
				anchor = anchor + 35;
				
			}
			
			scroll = new Scroll(960, 346, global.stageHeight-366, page.contentMC, page.contentMC.y, 0);
			this.addChild(scroll);
			
		}
		
	}
	
}