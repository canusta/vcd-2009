package  
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.text.*;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import com.canusta.data.*;
	import com.canusta.gui.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class CurriculumPage extends MovieClip
	{
		
		private var global			: Global = Global.getInstance();
		private var id				: Number;
		private var owner			: Object;
		private var database		: Database;
		private var departments		: Array;
		private var scroll			: Scroll;
		private var lastObject		: Object;
		private var timer			: Timer;
		private var syllabusY		: Number;
		private var openSyllabusBTTN : TextFieldBttnCFT650px;
		
		public function CurriculumPage(pid:Number, powner:Object) 
		{
			
			id = pid;
			owner = powner;
			departments = new Array();
			departments.push("VCD", "POV", "FTV", "FYE", "HTR", "SAT", "TK");
			bgMC.alpha = 0;
			backBTTN.alpha = 0;
			coursenameTXT.alpha = 0;
			global.univ.toPreloader();
			global.univ.spreloader.startToPreload();
			var myTimer:Timer = new Timer(1000, 1);
			myTimer.addEventListener("timer", loadContent);
			myTimer.start();
			
		}
		
		private function loadContent(e:TimerEvent)
		{
			database = new Database("Database/curriculum_" + global.language + ".xml", this, null);
			database.addEventListener("databaseloaded", init);
		}
		
		private function init(e:Event)
		{
			
			global.univ.toContent();
			var current:String;
			trace(database.data.item.(@id == id).department[0].toString())
			//trace(database.data.item.(@id == id).name.toUpperCase())
			if (global.language == "eng")
			{
				current = departments[database.data.item.(@id == id).department[0].toString()] + database.data.item.(@id == id).code[0].toString() + " " + database.data.item.(@id == id).name[0].toString().toUpperCase();
			}else {
				current = departments[database.data.item.(@id == id).department[0].toString()] + database.data.item.(@id == id).code[0].toString() + " " + database.data.item.(@id == id).name[0].toString();
				current = global.univ.toUp(current);
			}
			coursenameTXT.text = current;
			createContent();
			Tweener.addTween(bgMC, { alpha:1, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(backBTTN, { alpha:0.5, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(coursenameTXT, { alpha:1, time:1, transition:"easeOutExpo" } );
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, backBttnOver);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, backBttnOut);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, backBttnClicked);
			scroll = new Scroll(960, 346, global.stageHeight-366, contentMC, contentMC.y, 48);
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
		
		private function createContent()
		{
			
			//// Course Description
			var courseDescriptionTitle: TextFieldAutoscape220px;
			if (global.language == "eng")
			{
				courseDescriptionTitle = new TextFieldAutoscape220px("COURSE DESCRIPTION");
			}else {
				courseDescriptionTitle = new TextFieldAutoscape220px("DERS AÇIKLAMASI");
			}
			
			var courseDescriptionContent: TextFieldCFT650px = new TextFieldCFT650px(database.data.item.(@id == id).description.toString());
			contentMC.addChild(courseDescriptionTitle);
			contentMC.addChild(courseDescriptionContent);
			courseDescriptionTitle.x = 0;
			courseDescriptionTitle.y = 0;
			courseDescriptionContent.x = 240;
			courseDescriptionContent.y = 0;
			lastObject = courseDescriptionContent;
			
			//// Instructor(s)
			var instructorsTitle: TextFieldAutoscape220px;
			if ( database.data.item.(@id == id).instructors.instructor[0] )
			{
				if (global.language == "eng")
				{
					instructorsTitle = new TextFieldAutoscape220px("INSTRUCTOR(S)");
				}else {
					instructorsTitle = new TextFieldAutoscape220px("EĞİTMEN(LER)");
				}
				var instructorsContent: Array = new Array();
				for ( var i:Number = 0; i < database.data.item.(@id == id).instructors.instructor.length(); i++ )
				{
					instructorsContent[i] = new Array();
					instructorsContent[i]["name"] = database.data.item.(@id == id).instructors.instructor[i];
					instructorsContent[i]["id"] = database.data.item.(@id == id).instructors.instructor[i].@id;
					instructorsContent[i]["obj"] = new TextFieldBttnCFT650px(database.data.item.(@id == id).instructors.instructor[i].toString());
					instructorsContent[i]["obj"].Var = database.data.item.(@id == id).instructors.instructor[i].@id;
				}
				contentMC.addChild(instructorsTitle);
				for ( var ii:Number = 0; ii < instructorsContent.length; ii++)
				{
					contentMC.addChild(instructorsContent[ii]["obj"]);
					instructorsContent[ii]["obj"].x = 240;
					instructorsContent[ii]["obj"].y = (lastObject.height + 35 ) + ( ii * 18 );
					instructorsContent[ii]["obj"].bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
					instructorsContent[ii]["obj"].bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
					instructorsContent[ii]["obj"].bttn.addEventListener(MouseEvent.MOUSE_DOWN, openStaffPage);
				}
				lastObject = instructorsContent[instructorsContent.length-1]["obj"];
				instructorsTitle.x = 0;
				instructorsTitle.y = instructorsContent[0]["obj"].y ;
			}
			
			//// Assistant(s)
			var assistantsTitle: TextFieldAutoscape220px;
			if ( database.data.item.(@id == id).assistants.assistant[0] )
			{
				if (global.language == "eng")
				{
					assistantsTitle = new TextFieldAutoscape220px("ASSISTANT(S)");
				}else
				{
					assistantsTitle = new TextFieldAutoscape220px("ASİSTAN(LAR)");
				}
				var assistantsContent: Array = new Array();
				for ( var iii:Number = 0; iii < database.data.item.(@id == id).assistants.assistant.length(); iii++ )
				{
					assistantsContent[iii] = new Array();
					assistantsContent[iii]["name"] = database.data.item.(@id == id).assistants.assistant[iii];
					assistantsContent[iii]["id"] = database.data.item.(@id == id).assistants.assistant[iii].@id;
					assistantsContent[iii]["obj"] = new TextFieldBttnCFT650px(database.data.item.(@id == id).assistants.assistant[iii].toString());;
					assistantsContent[iii]["obj"].Var = database.data.item.(@id == id).assistants.assistant[iii].@id;
				}
				contentMC.addChild(assistantsTitle);
				for ( var iiii:Number = 0; iiii < assistantsContent.length; iiii++)
				{
					contentMC.addChild(assistantsContent[iiii]["obj"]);
					assistantsContent[iiii]["obj"].x = 240;
					assistantsContent[iiii]["obj"].y = (lastObject.y + lastObject.height + 35 ) + ( iiii * 18 );
					assistantsContent[iiii]["obj"].bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
					assistantsContent[iiii]["obj"].bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
					assistantsContent[iiii]["obj"].bttn.addEventListener(MouseEvent.MOUSE_DOWN, openStaffPage);
				}
				assistantsTitle.x = 0;
				assistantsTitle.y = assistantsContent[0]["obj"].y;
				lastObject = assistantsContent[0]["obj"];
			}
			
			//// Contact Person
			var contactPersonTitle: TextFieldAutoscape220px;
			var contactPeopleIndex : Array = new Array();
			contactPeopleIndex[0] = new Array();
			if ( database.data.item.(@id == id).contactpeople.contactperson[0] )
			{
				if (global.language == "eng")
				{
					contactPersonTitle = new TextFieldAutoscape220px("CONTACT PERSON");
				}else
				{
					contactPersonTitle = new TextFieldAutoscape220px("KONTAKT");
				}
				contactPeopleIndex[0]["obj"] = new TextFieldBttnCFT650px(database.data.item.(@id == id).contactpeople.contactperson[0].toString());
				contactPeopleIndex[0]["obj"].Var = database.data.item.(@id == id).contactpeople.contactperson[0].@id;
				contentMC.addChild(contactPersonTitle);
				contentMC.addChild(contactPeopleIndex[0]["obj"]);
				contactPeopleIndex[0]["obj"].bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
				contactPeopleIndex[0]["obj"].bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
				contactPeopleIndex[0]["obj"].bttn.addEventListener(MouseEvent.MOUSE_DOWN, openStaffPage);
				contactPeopleIndex[0]["obj"].x = 240;
				contactPeopleIndex[0]["obj"].y = lastObject.y + lastObject.height + 35 ;
				contactPersonTitle.x = 0;
				contactPersonTitle.y = contactPeopleIndex[0]["obj"].y;
				lastObject = contactPeopleIndex[0]["obj"];
			}
			
			//// Lecture Hour(s)
			var lectureHoursTitle: TextFieldAutoscape220px;
			if ( database.data.item.(@id == id).lecturehours.lecturehour[0] )
			{
				if (global.language == "eng")
				{
					lectureHoursTitle = new TextFieldAutoscape220px("LECTURE HOUR(S)");
				}else {
					lectureHoursTitle = new TextFieldAutoscape220px("DERS SAAT(LER)İ");
				}
				var lectureHoursContent: Array = new Array();
				for ( var v:Number = 0; v < database.data.item.(@id == id).lecturehours.lecturehour.length(); v++ )
				{
					lectureHoursContent[v] = new Array();
					lectureHoursContent[v]["name"] = database.data.item.(@id == id).lecturehours.lecturehour[v];
					lectureHoursContent[v]["obj"] = new TextFieldCFT650px(database.data.item.(@id == id).lecturehours.lecturehour[v].toString());
				}
				contentMC.addChild(lectureHoursTitle);
				for ( var vi:Number = 0; vi < lectureHoursContent.length; vi++)
				{
					contentMC.addChild(lectureHoursContent[vi]["obj"]);
					lectureHoursContent[vi]["obj"].x = 240;
					lectureHoursContent[vi]["obj"].y = (lastObject.y + lastObject.height + 35 ) + ( vi * 18 );
				}
				lectureHoursTitle.x = 0;
				lectureHoursTitle.y = lectureHoursContent[0]["obj"].y;
				lastObject = lectureHoursContent[lectureHoursContent.length-1]["obj"];
			}
			
			//// Syllabus
			var SyllabusTitle: TextFieldAutoscape220px;
			syllabusY = lastObject.y + lastObject.height + 35;
			if (global.language == "eng")
				{
					SyllabusTitle = new TextFieldAutoscape220px("SYLLABUS");
				}else {
					SyllabusTitle = new TextFieldAutoscape220px("DERS PROGRAMI");
				}
				contentMC.addChild(SyllabusTitle);
				SyllabusTitle.x = 0;
				SyllabusTitle.y = syllabusY;
				openSyllabusBTTN = new TextFieldBttnCFT650px("");
				openSyllabusBTTN.TXT.text = "deneme";
				openSyllabusBTTN.x = 240;
				openSyllabusBTTN.y = syllabusY;
				contentMC.addChild(openSyllabusBTTN);
				openSyllabusBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
				openSyllabusBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
				openSyllabusBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, createSyllabus);
		}
		
		private function createSyllabus(e:Event = null)
		{
			contentMC.removeChild(openSyllabusBTTN);
			if ( database.data.item.(@id == id).syllabus.weeks.week[0] )
			{
				var SyllabusContent: Array = new Array();
				for ( var vii:Number = 0; vii < database.data.item.(@id == id).syllabus.weeks.week.length(); vii++ )
				{
					SyllabusContent[vii] = new Array();
					SyllabusContent[vii]["name"] = database.data.item.(@id == id).syllabus.weeks.week[vii];
					SyllabusContent[vii]["obj"] = new TextFieldCFT505px(database.data.item.(@id == id).syllabus.weeks.week[vii].description.toString());
					var weeknumber:Number = vii + 1;
					if (global.language == "eng")
					{
						SyllabusContent[vii]["weekname"] = new TextFieldAutoscape220px("WEEK " + weeknumber);
					}else {
						SyllabusContent[vii]["weekname"] = new TextFieldAutoscape220px("HAFTA " + weeknumber);
					}
				}
				
				var previousweek:Number = 1;;
				for ( var viii:Number = 0; viii < SyllabusContent.length; viii++)
				{
					contentMC.addChild(SyllabusContent[viii]["obj"]);
					contentMC.addChild(SyllabusContent[viii]["weekname"]);
					SyllabusContent[viii]["obj"].x = 385;
					SyllabusContent[viii]["obj"].y = syllabusY;
					SyllabusContent[viii]["weekname"].x = 240;
					SyllabusContent[viii]["weekname"].y = syllabusY;
					previousweek = viii - 1;
					if (previousweek >= 0)
					{
						SyllabusContent[viii]["obj"].y = SyllabusContent[previousweek]["obj"].y + SyllabusContent[previousweek]["obj"].height + 14;
						SyllabusContent[viii]["weekname"].y = SyllabusContent[previousweek]["obj"].y + SyllabusContent[previousweek]["obj"].height + 14;
					}
				}
			}
			trace("---");
			scroll.rebuildScroll();
			
		}
		
		private function openStaffPage(e:MouseEvent)
		{
			var page : StaffPage  = new StaffPage(e.currentTarget.parent.Var, owner);
			owner.addChild(page);
			trace("openStaffPage")
		}
		
		private function bttnOver(e:MouseEvent)
		{
			//e.currentTarget.parent.bg.alpha = 0.2;
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0.2, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:180, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-9, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:5, time:1, transition:"easeOutExpo"} );
			
		}
		
		private function bttnOut(e:MouseEvent)
		{
			//e.currentTarget.parent.bg.alpha = 0;
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-14, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:4, time:1, transition:"easeOutExpo"} );
		}
		
	}
	
}