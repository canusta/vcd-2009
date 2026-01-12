package 
{
	import com.canusta.data.Database;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
    import flash.net.URLRequest;
	import flash.text.*;
	import com.canusta.gui.*;
	import lt.uza.utils.*;
	import caurina.transitions.*;
	
	public class PageLinks extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var database			: Database;
		private var univ				: VcdTwoThousandAndNine;
		private var scroll				: Scroll;
		private var officialcount		: Number = 0;
		private var alumnicount			: Number = 0;
		private var studentscount		: Number = 0;
		private var officialLineHeight	: Number = 45;
		//private var friendlyLineHeight	: Number = 56;
		private var itemPadding			: Number = 20;
		private var friendlycount		: Number = 0;
		private var officialx			: Number = 0;
		private var alumnix				: Number = 300;
		private var studentx			: Number = 600;
		
		public function PageLinks(pdatabase:Database, puniv:VcdTwoThousandAndNine) 
		{
			database = pdatabase;
			univ = puniv;
			init();
			scroll = new Scroll(960, 346, global.stageHeight-366, contentMC, contentMC.y, 50);
			this.addChild(scroll);
		}
		
	
		
		private function init()
		{
			for ( var i:Number = 0; i < database.data.item.length(); i++ )
			{
				if (database.data.item[i].category == 0)
				{
					var item :LinksOfficialItem = new LinksOfficialItem(database.data.item[i].link, database.data.item[i].name);
					contentMC.addChild(item);
					item.x = officialx;
					item.y = ( officialcount * officialLineHeight ) + itemPadding;
					item.alpha = 0.5;
					item._Var = database.data.item[i].link;
					item.bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
					item.bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
					item.bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnClicked);
					officialcount++;
				}
				if (database.data.item[i].category == 1)
				{
					var fitem :LinksOfficialItem = new LinksOfficialItem(database.data.item[i].link, database.data.item[i].name);
					contentMC.addChild(fitem);
					fitem.x = alumnix;
					fitem.y = ( alumnicount * officialLineHeight ) + itemPadding;
					fitem.alpha = 0.5;
					fitem._Var = database.data.item[i].link;
					fitem.bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
					fitem.bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
					fitem.bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnClicked);
					alumnicount++;
				}
				if (database.data.item[i].category == 2)
				{
					var ffitem :LinksOfficialItem = new LinksOfficialItem(database.data.item[i].link, database.data.item[i].name);
					contentMC.addChild(ffitem);
					ffitem.x = studentx;
					ffitem.y = ( studentscount * officialLineHeight ) + itemPadding;
					ffitem.alpha = 0.5;
					ffitem._Var = database.data.item[i].link;
					ffitem.bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
					ffitem.bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
					ffitem.bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnClicked);
					studentscount++;
				}
			}
		}
		
		private function bttnOver(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:-90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:12, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent, { alpha:1, time:0, transition:"easeOutExpo" } );
		}
		
		private function bttnOut(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent, { alpha:0.5, time:1, transition:"easeOutExpo" } );
		}
		
		private function bttnClicked(e:MouseEvent)
		{
			openLink(e.currentTarget.parent._Var);
		}
		
		private function openLink(target:String)
		{
			var url:String = target;
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request, '_blank');
		}
		
	}
	
}