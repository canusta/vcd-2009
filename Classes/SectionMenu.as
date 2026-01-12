package 
{
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.navigateToURL;
    import flash.net.URLRequest;
	import com.canusta.data.Database;
	import com.canusta.data.Utils;
	import lt.uza.utils.*;
	
	public class SectionMenu extends MovieClip
	{
		
		private var global						: Global = Global.getInstance();
		private var buttonDatabase				: Array;
		private var buttoncount					: int;
		private var univ						: VcdTwoThousandAndNine;
		private var pageabout					: PageAbout;
		private var pagecurriculum				: PageCurriculum;
		private var pageloader					: PageLoader;
		private var clickedbttn					: Array;
		public var loadeddata					: Array; // loaded databases, global.loadeddata, "about_eng"
		
		public function SectionMenu(puniv:VcdTwoThousandAndNine):void
		{
			univ				 = puniv;
			pageloader			 = new PageLoader(univ);
									 // Databases will be added
			buttonDatabase		 = [ new Array("about", aboutBTTN, "internalpage"),
									 new Array("curriculum", curriculumBTTN, "internalpage"),
									 new Array("staff", staffBTTN, "internalpage"),
									 new Array("exhibitionandfestivals", exhibitionandfestivalsBTTN, "internalpage"),
									 new Array("publications", publicationBTTN, "internalpage"),
									 new Array("international", internationalBTTN, "internalpage"),
									 new Array("contact", contactBTTN, "internalpage"),
									 new Array("links", linksBTTN, "internalpage"),
									 new Array("bulletin", bulletinBTTN, "link", "_blank", "http://vcd.bilgi.edu.tr/bullet-in"),
									 new Array("presskit", presskitBTTN, "link", "_blank", "Files/Presskit.zip"),
									 new Array("announcements", announcementsBTTN, "internalpage"),
									 new Array("pov", povBTTN, "link", "_blank", "http://pov.bilgi.edu.tr"),
									 new Array("ftv", ftvBTTN, "link", "_blank", "http://ftv.bilgi.edu.tr"),
									 new Array("vcdexhibit", vcdexhibitBTTN, "link", "_blank", "http://www.vcdexhibit.com"),
									 new Array("vcdmfa", vcdmfaBTTN, "link", "_blank", "http://www.vcdmfa.net"),
									 new Array("pse", pseBTTN, "link", "_blank", "http://pse.bilgi.edu.tr"),
									 new Array("blowup", blowupBTTN, "link", "_blank", "http://www.designautopsy.com/blowup"),];
			buttoncount			 = buttonDatabase.length;
			clickedbttn			 = new Array();
			
			init();
		}
		
		private function init():void
		{
			this.x = 0;
			buttonize();
		}
		
		private function buttonize():void
		{
			for (var i:Number = 0; i < buttoncount; i++ )
			{
				buttonizeButton(i);
			}
		}
		
		private function buttonizeButton(id:Number):void
		{
			buttonDatabase[id][1].bttn.addEventListener(MouseEvent.MOUSE_OVER, rollOverAction);
			buttonDatabase[id][1].bttn.addEventListener(MouseEvent.MOUSE_OUT, rollOutAction);
			buttonDatabase[id][1].bttn.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, langBttnOver);
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, langBttnOut);
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, langBttnClicked);
		}
		
		private function langBttnOver(e:MouseEvent)
		{
			e.target.parent.gotoAndStop("over")
		}
		
		private function langBttnOut(e:MouseEvent)
		{
			e.target.parent.gotoAndStop("out")
		}
		
		private function langBttnClicked(e:MouseEvent)
		{
			global.univ.changeLang();
		}
		
		private function rollOverAction(e:MouseEvent):void
		{
			e.currentTarget.parent.gotoAndStop("over");
		}
		
		private function rollOutAction(e:MouseEvent):void
		{
			e.currentTarget.parent.gotoAndStop("out");
		}
		
		private function clicked(e:MouseEvent):void
		{
			clickedbttn = Utils.MDArraySearch(buttonDatabase, e.currentTarget.parent);
			
			if (clickedbttn[2] == "internalpage")
			{
				clickedbttn.push(null);
				pageloader.loadPage(clickedbttn);
			}
			
			if (clickedbttn[2] == "link")
			{
				openLink(clickedbttn[4]);
			}
			
		}
		
		private function openLink(target:String)
		{
			var url:String = target;
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request, '_blank');
		}
		
	}
}