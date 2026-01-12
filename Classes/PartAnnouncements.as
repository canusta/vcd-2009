package
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.xml.*;
	import flash.text.*;
	import flash.events.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ButtonPartAnnouncements;
	import com.canusta.text.*;
	import com.canusta.data.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class PartAnnouncements extends MovieClip
	{
		
		private var global										: Global = Global.getInstance();
		private var announcementButtonNumber					: Number = 3;
		private var announcementCount							: Number;
		private var currentPart									: Number = 1;
		
		private var univ                    					: VcdTwoThousandAndNine;
		private var owner                    					: SectionPreloader;
		public var _activeButton             					: ButtonPartAnnouncements;
		
		private var database                 					: Database;
		private var timer										: Timer;
		
		public function PartAnnouncements(puniv:VcdTwoThousandAndNine, powner:SectionPreloader)
		{
			
			univ = puniv;
			owner = powner;
			
			this.x = 150;
			this.y = 310;
			
			contentTXT.wordWrap = true;
			contentTXT.autoSize = TextFieldAutoSize.LEFT;
			
			database = new Database("Database/announcements_"+puniv.language+".xml", this, univ);
			database.addEventListener("databaseloaded", build);
			
		}
		
		public function build(event:Event)
		{
			Tweener.addTween(this, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(this, { alpha:1, time:1, transition:"easeOutExpo" } );
			announcementCount = database.data.item.length();
			createButtons();
			buttonizeThemAll();
		}
		
		private function createButtons()
		{
			for (var i:Number = 0; i < announcementButtonNumber; i++ )
			{
				if (database.data.item[i])
				{
					var bttn:ButtonPartAnnouncements = new ButtonPartAnnouncements(i, database, this);
					addChild(bttn);
					if (i == 0)
					{
						_activeButton = bttn;
						this.titleTXT.text = database.data.item[i].title;
						this.dateTXT.text = database.data.item[i].date;
						this.contentTXT.htmlText = database.data.item[i].content;
						if (contentTXT.height >= 180)
						{
							screenBg.height = contentTXT.height + 12;
							skipBTTN.y = screenBg.height;
						}else
						{
							screenBg.height = 191;
							skipBTTN.y = 191;
						}
						
					}
				}
				
			}
		}
		
		private function buttonizeThemAll()
		{
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			langBTTN.bttn.addEventListener(MouseEvent.CLICK, langBttnClicked);
			skipBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			skipBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			skipBTTN.bttn.addEventListener(MouseEvent.CLICK, clicked);
			var timertimer:Timer = new Timer(500, 1);
			timertimer.addEventListener(TimerEvent.TIMER, firetimer);
			timertimer.start();
		}
		
		private function firetimer(e:TimerEvent)
		{
			var timer:Timer = new Timer(100, 5);
			timer.addEventListener(TimerEvent.TIMER, blinkSkipBttn);
			timer.start();
		}
		
		private function blinkSkipBttn(e:TimerEvent)
		{
			Tweener.addTween(skipBTTN.faceMC, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(skipBTTN.faceMC, { alpha:1, time:2, transition:"easeOutExpo" } );
		}
		
		private function rollOver(e:Event)
		{
			Tweener.removeTweens(e.currentTarget.parent.bgMC);
			e.currentTarget.parent.bgMC.alpha = 1;
		}
		
		private function rollOut(e:Event)
		{
			Tweener.addTween(e.currentTarget.parent.bgMC, { alpha:0, time:1, transition:"easeOutExpo" } );
		}
		
		private function clicked(e:Event)
		{
			e.currentTarget.parent.bgMC.alpha = 1;
			if (e.currentTarget == skipBTTN.bttn)
			{
				univ._currentPart =  0;
				removeChild(skipBTTN);
			}
		}
		
		private function langBttnClicked(e:Event)
		{
			global.univ.changeLang();
		}
		
		public function get activeButton ():ButtonPartAnnouncements{
			return _activeButton;
		}
		
		public function set activeButton (__activeButton:ButtonPartAnnouncements){
			_activeButton = __activeButton;
		}
		
		/*private function createButton(id:Number)
		{
			var AnnouncementBttn1:announcementBttn = new announcementBttn();
			addChild(AnnouncementBttn1);
			AnnouncementBttn1.x = 0;
			//Tweener.addTween(AnnouncementBttn1, {y:id*47, time:0.2, transition:"linear"});
			AnnouncementBttn1.y = id*47;
			AnnouncementBttn1.titleTXT.autoSize = TextFieldAutoSize.LEFT;
			AnnouncementBttn1.dateTXT.autoSize = TextFieldAutoSize.LEFT;
			AnnouncementBttn1.titleTXT.text = database.data.item[id].name;
			AnnouncementBttn1.dateTXT.text = database.data.item[id].date;
			AnnouncementBttn1.idTXT.text = database.data.item[id].@id;
			AnnouncementBttn1.arrowMC.x = AnnouncementBttn1.titleTXT.width + margin;
			if (id == 0)// ilk button, selected olmali ve content i yazilmali
			{
				AnnouncementBttn1.bgMC.alpha = 100;
				this.titleTXT.text = database.data.item[id].name;
				this.dateTXT.text = database.data.item[id].date;
				this.contentTXT.htmlText = database.data.item[id].content;
				activeButton = AnnouncementBttn1;
			}
			// Buttonize
			AnnouncementBttn1.bttn.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			AnnouncementBttn1.bttn.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			AnnouncementBttn1.bttn.addEventListener(MouseEvent.CLICK, clicked);
		}
		
		private function rollOver(e:MouseEvent)
		{
			if (activeButton != e.currentTarget.parent)
			{
				Tweener.removeTweens(e.currentTarget.parent.bgMC);
				//Tweener.removeAllTweens();
				e.currentTarget.parent.bgMC.alpha = 0.5;
			}
		}
		
		private function rollOut(e:MouseEvent)
		{
			if (activeButton != e.currentTarget.parent)
			{
				Tweener.addTween(e.currentTarget.parent.bgMC, { alpha:0, time:1, transition:"easeOutExpo" } );
			}
		}
		
		private function clicked(e:MouseEvent)
		{
			if (activeButton != e.currentTarget.parent)
			{
				activeButton.bgMC.alpha = 0;
				e.currentTarget.parent.bgMC.alpha = 50;
				activeButton = e.currentTarget.parent as announcementBttn;
				var tChanger:TextChanger = new TextChanger();
				tChanger.changeText(e.currentTarget.parent.parent.contentTXT, database.data.item[1].content, "fill", 1)
				//tChanger.check(e.currentTarget.parent.parent.contentTXT);
				//e.currentTarget.parent.parent.contentTXT.text = "deneme";
			}
		}*/
	}
}