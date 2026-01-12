package
{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.net.navigateToURL;
    import flash.net.URLRequest;
	import com.canusta.data.*;
	import com.canusta.gui.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;

	public class StaffPage extends MovieClip
	{
		
		private var global			: Global = Global.getInstance();
		private var id				: Number;
		private var owner			: Object;
		private var database		: Database;
		private var staffTypes		: Array;
		private var blockPadding	: Number = 32;
		private var othersStarting	: Number;
		private var othersCount		: Number;
		private var currentHeight	: Number;
		private var scroll			: Scroll;
		private var timer			: Timer;
		
		public function StaffPage(pid:Number, powner:Object) 
		{
			id = pid;
			owner = powner;
			if (global.language == "eng")
			{
				staffTypes = new Array("Head of Department", "Full Time", "Adjunct", "Teaching Assistant", "Administrative Assistant", "Technical Assistant");
			}else {
				staffTypes = new Array("BÖLÜM BAŞKANI", "TAM ZAMANLI", "YARI ZAMANLI", "ARAŞTIRMA GÖREVLİLERİ", "İDARİ ASİSTAN", "TEKNİK ASİSTANLAR");
			}
			bgMC.alpha = 0;
			backBTTN.alpha = 0;
			staffnameTXT.alpha = 0;
			global.univ.toPreloader();
			global.univ.spreloader.startToPreload();
			var myTimer:Timer = new Timer(1000, 1);
			myTimer.addEventListener("timer", loadContent);
			myTimer.start();
		}
		
		private function loadContent(e:TimerEvent)
		{
			database = new Database("Database/staff_" + global.language + ".xml", this, null);
			database.addEventListener("databaseloaded", init);
		}
		
		private function init(e:Event)
		{
			global.univ.toContent();
			var current:String;
			var upstr : String = global.univ.toUp(database.data.item[id].name);
			current = upstr;
			staffnameTXT.text = current;
			stafftypeTXT.text = staffTypes[database.data.item[id].type].toUpperCase();
			createContent();
			Tweener.addTween(bgMC, { alpha:1, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(backBTTN, { alpha:0.5, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(staffnameTXT, { alpha:1, time:1, transition:"easeOutExpo" } );
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, backBttnOver);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, backBttnOut);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, backBttnClicked);
			scroll = new Scroll(960, 346, global.stageHeight-366, contentMC, contentMC.y, 54);
			addChild(scroll);
			startBlinkBackBTTN();
		}
		
		private function startBlinkBackBTTN()
		{
			var timertimer:Timer = new Timer(500, 1);
			timertimer.addEventListener(TimerEvent.TIMER, firetimer);
			timertimer.start();
		}
		
		private function firetimer(e:Event)
		{
			timer = new Timer(100, 5);
			timer.addEventListener(TimerEvent.TIMER, blinkBackBttn);
			timer.start();
		}
		
		private function blinkBackBttn(e:Event)
		{
			Tweener.addTween(backBTTN, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(backBTTN, { alpha:0.5, time:0.5, transition:"easeOutExpo" } );
		}
		
		private function createContent()
		{
			//// Information
			var staffInformationTitle: TextFieldAutoscape220px;
			if (global.language == "eng")
			{
				staffInformationTitle = new TextFieldAutoscape220px("INFORMATION");
			}else {
				staffInformationTitle = new TextFieldAutoscape220px("BİLGİ");
			}
			var staffInformationEmail: TextFieldBttnCFT650px = new TextFieldBttnCFT650px(database.data.item[id].email);
			var staffInformationInformation: TextFieldCFT650px = new TextFieldCFT650px(database.data.item[id].information);
			contentMC.addChild(staffInformationTitle);
			contentMC.addChild(staffInformationEmail);
			contentMC.addChild(staffInformationInformation);
			staffInformationTitle.x = 0;
			staffInformationTitle.y = 4;
			staffInformationEmail.x = 240;
			staffInformationEmail.y = 4;
			staffInformationEmail.Var = database.data.item[id].email;
			if (database.data.item[id].website!="")
			{
				var staffInformationWebsite: TextFieldBttnCFT650px = new TextFieldBttnCFT650px(database.data.item[id].website);
				contentMC.addChild(staffInformationWebsite);
				staffInformationWebsite.x = 240;
				staffInformationWebsite.y = 22;
				staffInformationWebsite.Var = database.data.item[id].website;
				staffInformationWebsite.bttn.addEventListener(MouseEvent.MOUSE_OVER, linkBttnOver);
				staffInformationWebsite.bttn.addEventListener(MouseEvent.MOUSE_OUT, linkBttnOut);
				staffInformationWebsite.bttn.addEventListener(MouseEvent.MOUSE_DOWN, linkBttnClicked);
				staffInformationInformation.y = 40;
			}else
			{
				staffInformationInformation.y = 22;
			}
			staffInformationInformation.x = 240;
			staffInformationEmail.bttn.addEventListener(MouseEvent.MOUSE_OVER, linkBttnOver);
			staffInformationEmail.bttn.addEventListener(MouseEvent.MOUSE_OUT, linkBttnOut);
			staffInformationEmail.bttn.addEventListener(MouseEvent.MOUSE_DOWN, emailBttnClicked);
			currentHeight = staffInformationInformation.y + staffInformationInformation.height;
			
			//// Courses
			var staffCourseTitle: TextFieldAutoscape220px;
			if (database.data.item[id].courses.course[0])
			{
				if (global.language == "eng")
				{
					staffCourseTitle = new TextFieldAutoscape220px("COURSES");
				}else {
					staffCourseTitle = new TextFieldAutoscape220px("DERSLER");
				}
				contentMC.addChild(staffCourseTitle);
				staffInformationTitle.x = 0;
				staffCourseTitle.y = staffInformationInformation.y + staffInformationInformation.height + blockPadding;
				for (var i:Number = 0; i < database.data.item[id].courses.course.length(); i++)
				{
					var course: TextFieldBttnCFT650px = new TextFieldBttnCFT650px(database.data.item[id].courses.course[i]);
					contentMC.addChild(course);
					course.x = 240;
					course.y = staffCourseTitle.y + (i * 18);
					course.Var = database.data.item[id].courses.course[i].@id;
					trace(database.data.item[id].courses.course[i].@id);
					trace(id);
					trace(database.data.item[id].courses.course[i]);
					trace();
					course.bttn.addEventListener(MouseEvent.MOUSE_OVER, courseBttnOver);
					course.bttn.addEventListener(MouseEvent.MOUSE_OUT, courseBttnOut);
					course.bttn.addEventListener(MouseEvent.MOUSE_DOWN, courseBttnClicked);
					currentHeight = course.y + course.height;
				}
			}
			
			//// Others
			if (database.data.item[id].courses)
			{
				othersStarting = 7;
			}else {
				othersStarting = 6;
			}
			
			othersCount = database.data.item[id].*.length();
			var previousContent: Object;
			
			for (var ii:Number = othersStarting; ii < othersCount; ii++ )
			{	
				
				var upstr : String;
				if (global.language == "eng") {
					upstr = database.data.item[id].*[ii].@label.toString().toUpperCase();
				}else {
					upstr = global.univ.toUp(database.data.item[id].*[ii].@label);
				}
				var othersTitle: TextFieldAutoscape220px = new TextFieldAutoscape220px(upstr);
				contentMC.addChild(othersTitle);
				othersTitle.x = 0;
				othersTitle.y = currentHeight + blockPadding;
				currentHeight = othersTitle.y + othersTitle.height;
				var othersContent: TextFieldCFT650px = new TextFieldCFT650px(database.data.item[id].*[ii]);
				contentMC.addChild(othersContent);
				othersContent.x = 240;
				othersContent.y = othersTitle.y;
				previousContent = othersContent;
				currentHeight = othersContent.y + othersContent.height;
			}
		}
		
		private function courseBttnOver(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0.2, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:180, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-9, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:5, time:1, transition:"easeOutExpo" } );
		}
		
		private function courseBttnOut(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-14, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:4, time:1, transition:"easeOutExpo"} );
		}
		
		private function courseBttnClicked(e:MouseEvent)
		{
			var coursePage: CurriculumPage = new CurriculumPage(e.currentTarget.parent.Var, this);
			this.addChild(coursePage);
		}
		
		private function linkBttnOver(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0.2, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:-90, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-12, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:7, time:1, transition:"easeOutExpo"} );
		}
		
		private function linkBttnOut(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-14, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:4, time:1, transition:"easeOutExpo"} );
		}
		
		private function linkBttnClicked(e:MouseEvent)
		{
			openLink(e.currentTarget.parent.Var);
		}
		
		private function emailBttnClicked(e:MouseEvent)
		{
			sendEmail(e.currentTarget.parent.Var);
		}
		
		private function openLink(target:String)
		{
			var url:String = target;
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request, '_blank');
		}
		
		private function sendEmail(target:String)
		{
			var url:String = "mailto:"+target;
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request, '_blank');
		}
		
		private function backBttnOver(e:MouseEvent)
		{
			e.currentTarget.parent.alpha = 1;
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:-90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:3, time:1, transition:"easeOutExpo" } );
		}
		
		private function backBttnOut(e:MouseEvent)
		{
			e.currentTarget.parent.alpha = 0.5;
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:15, time:1, transition:"easeOutExpo" } );
		}
		
		private function backBttnClicked(e:MouseEvent)
		{
			close();
		}
		
		public function close()
		{
			Tweener.addTween(this, { alpha:0, time:1, transition:"easeOutExpo", onComplete:unload } );
		}
		
		private function unload()
		{
			owner.removeChild(this);
		}
		
	}
	
}