package 
{
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import com.canusta.data.Database;
	import com.canusta.text.*;
	import caurina.transitions.*;
	import flash.utils.Timer;
	
	public class PageAbout extends MovieClip
	{
		
		private var database				: Database;
		private var univ					: VcdTwoThousandAndNine;
		private var currentsubbttn			: Object;
		private var currentsub				: MovieClip;
		
		public function PageAbout(pdatabase:Database, puniv:VcdTwoThousandAndNine) 
		{
			univ						   = puniv;
			database 					   = pdatabase;
			init();
		}
		
		private function init()
		{
			/*univ._currentPage = "about";
			univ._scontent._location = "ROOT > ABOUT";
			contentTXT.htmlText = database.data.content;*/
			buttonize();
			var timer : Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, openBrief);
			timer.start();
		}
		
		private function buttonize()
		{
			buttonizeButton(briefBTTN);
			buttonizeButton(admissionsBTTN);
			buttonizeButton(scholarshipsBTTN);
			buttonizeButton(catalogBTTN);
			buttonizeButton(presskitBTTN);
		}
		
		private function buttonizeButton(target:MovieClip)
		{
			target.bttn.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			target.bttn.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			target.bttn.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		private function mouseOver(e:MouseEvent)
		{
			if (e.currentTarget.parent.Status == 0)
			{
				e.target.parent.alpha = 1;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:90, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:15, time:1, transition:"easeOutExpo" } );
			}
		}
		
		private function mouseOut(e:MouseEvent)
		{
			if (e.currentTarget.parent.Status == 0)
			{
				e.target.parent.alpha = 0.5;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:0, time:1, transition:"easeOutExpo" } );
			}
		}
		
		private function mouseDown(e:MouseEvent)
		{
			if (e.currentTarget.parent.Status == 0)
			{
				if (currentsubbttn)
				{
					currentsubbttn.Status = 0;
					currentsubbttn.alpha = 0.5;
					Tweener.addTween(currentsubbttn.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
					Tweener.addTween(currentsubbttn.arrow, { x:0, time:1, transition:"easeOutExpo" } );
				}
				
				e.currentTarget.parent.alpha = 1;
				e.currentTarget.parent.Status = 1;
				currentsubbttn = e.currentTarget.parent;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:90, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:15, time:1, transition:"easeOutExpo" } );
				
				if (currentsub != null)
				{
					this.removeChild(currentsub);
				}
				
				switch (e.currentTarget.parent)
				{
					case briefBTTN :
						loadBrief();
						break;
					case admissionsBTTN :
						loadAdmissions();
						break;
					case scholarshipsBTTN :
						loadScholarships();
						break;
					case catalogBTTN :
						loadLeaflet();
						break;
					case presskitBTTN :
						loadPresskit();
						break;
				}
			}
			
		}
		
		private function loadBrief()
		{
			var Brief:SubAboutBrief = new SubAboutBrief(database);
			this.addChild(Brief);
			currentsub = Brief;
		}
		
		private function loadAdmissions()
		{
			var Admissions:SubAboutAdmissions = new SubAboutAdmissions(database);
			this.addChild(Admissions);
			currentsub = Admissions;
		}
		
		private function loadScholarships()
		{
			var Admissions:SubAboutScholarships = new SubAboutScholarships(database);
			this.addChild(Admissions);
			currentsub = Admissions;
		}
		
		private function loadLeaflet()
		{
			var Leaflet:SubAboutLeaflet = new SubAboutLeaflet(database);
			this.addChild(Leaflet);
			currentsub = Leaflet;
		}
		
		private function loadPresskit()
		{
			var Presskit:SubAboutPresskit = new SubAboutPresskit(database);
			this.addChild(Presskit);
			currentsub = Presskit;
		}
		
		private function openBrief(e:TimerEvent)
		{
			briefBTTN.alpha = 1;
			briefBTTN.Status = 1;
			currentsubbttn = briefBTTN;
			Tweener.addTween(briefBTTN.arrow, { rotation:90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(briefBTTN.arrow, { x:15, time:1, transition:"easeOutExpo" } );
			loadBrief();
		}
		
	}
	
}