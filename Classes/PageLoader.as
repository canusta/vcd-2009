package
{
	
	import flash.events.EventDispatcher;
	import flash.events.*;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import com.canusta.data.Database;
	import com.canusta.text.*;
	import lt.uza.utils.*;

	public class PageLoader extends EventDispatcher
	{
		
		private var global					 			: Global = Global.getInstance();
		private var univ                     			: VcdTwoThousandAndNine;
		private var target                   			: Array;
		private var sectioncontent			 			: SectionContent;
		private var targetname				 			: String;
		private var targetbttn				 			: Object;
		private var targetsubid				 			: Number;
		public var contactdatabase			 			: Database;
		public var aboutdatabase			 			: Database;
		public var curriculumdatabase		 			: Database;
		public var staffdatabase			 			: Database;
		public var linksdatabase			 			: Database;
		public var publicationsdatabase		 			: Database;
		public var exhibitionandfestivalsdatabase		: Database;
		public var internationaldatabase				: Database;
		public var announcementsdatabase				: Database;
		private var pageabout				 			: PageAbout;
		private var pagecontact				 			: PageContact;
		private var pagecurriculum			 			: PageCurriculum;
		private var pagestaff				 			: PageStaff;
		private var pagelinks				 			: PageLinks;
		private var pagepublications			 		: PagePublications;
		private var pageinternational					: PageInternational;
		private var pageexhibitionandfestivals			: PageExhibitionAndFestivals;
		private var pageannouncements					: PageAnnouncements;
		
		public function PageLoader(puniv:VcdTwoThousandAndNine) 
		{
			univ							 = puniv;
			target 							 = new Array();
		}
		
		public function loadPage(ptarget:Array)
		{
			trace(ptarget)
			target = ptarget;
			targetname = target[0];
			targetbttn = target[1];
			targetsubid = target[3];
			
			if (global.currentpage == targetname)
			{
				if (!targetsubid)
				{
					univ.toContent();
				}else
				{
					///// build subpage
					trace("sub")
				}
			}else
			{
				if (targetname == "about" && aboutdatabase)
				{
					buildAbout();
				}else
				if (targetname == "contact" && contactdatabase)
				{
					buildContact();
				}else
				if (targetname == "curriculum" && curriculumdatabase)
				{
					buildCurriculum();
				}else
				if (targetname == "staff" && staffdatabase)
				{
					buildStaff();
				}else
				if (targetname == "links" && linksdatabase)
				{
					buildLinks();
				}else
				if (targetname == "publications" && publicationsdatabase)
				{
					buildPublications();
				}else
				if (targetname == "international" && internationaldatabase)
				{
					buildInternational();
				}else
				if (targetname == "announcements" && announcementsdatabase)
				{
					buildInternational();
				}else
				if (targetname == "exhibitionandfestivals" && exhibitionandfestivalsdatabase)
				{
					buildExhibitionAndFestivals();
				}else
				{
						univ.toPreloader();
						univ.spreloader.startToPreload();
						var myTimer:Timer = new Timer(1000, 1);
						myTimer.addEventListener("timer", loadPageAction);
						myTimer.start();
				}
				
			}
			
		}
		
		private function loadPageAction(event:TimerEvent):void
		{
			
			switch (targetname)
			{
				case "about":
					aboutdatabase = new Database("Database/about_" + univ.language + ".xml", pageabout, univ);
					aboutdatabase.addEventListener("databaseloaded", buildAboutListener);
					break;
				case "contact":
					contactdatabase = new Database("Database/contact_" + univ.language + ".xml", pageabout, univ)
					contactdatabase.addEventListener("databaseloaded", buildContactListener);
					break;
				case "curriculum":
					curriculumdatabase = new Database("Database/curriculum_" + univ.language + ".xml", pagecurriculum, univ)
					curriculumdatabase.addEventListener("databaseloaded", buildCurriculumListener);
					break;
				case "staff":
					staffdatabase = new Database("Database/staff_" + univ.language + ".xml", pagestaff, univ)
					staffdatabase.addEventListener("databaseloaded", buildStaffListener);
					break;
				case "links":
					linksdatabase = new Database("Database/links_" + univ.language + ".xml", pagelinks, univ)
					linksdatabase.addEventListener("databaseloaded", buildLinksListener);
					break;
				case "publications":
					publicationsdatabase = new Database("Database/publications_" + univ.language + ".xml", pagepublications, univ)
					publicationsdatabase.addEventListener("databaseloaded", buildPublicationsListener);
					break;
				case "announcements":
					announcementsdatabase = new Database("Database/announcements_" + univ.language + ".xml", pageannouncements, univ)
					announcementsdatabase.addEventListener("databaseloaded", buildAnnouncementsListener);
					break;
				case "international":
					internationaldatabase = new Database("Database/international_" + univ.language + ".xml", pageinternational, univ)
					internationaldatabase.addEventListener("databaseloaded", buildInternationalListener);
					break;
				case "exhibitionandfestivals":
					exhibitionandfestivalsdatabase = new Database("Database/exhibitionandfestivals_" + univ.language + ".xml", pageexhibitionandfestivals, univ)
					exhibitionandfestivalsdatabase.addEventListener("databaseloaded", buildExhibitionAndFestivalsListener);
					break;
				default:
					trace("Menu Problem");
			}
			
		}
		
		private function buildAboutListener(e:Event)
		{
			var bablTimer : Timer = new Timer(250, 1);
			bablTimer.addEventListener(TimerEvent.TIMER, buildAbout);
			bablTimer.start();
		}
		
		private function buildContactListener(e:Event)
		{
			var bcolTimer : Timer = new Timer(250, 1);
			bcolTimer.addEventListener(TimerEvent.TIMER, buildContact);
			bcolTimer.start();
		}
		
		private function buildCurriculumListener(e:Event)
		{
			var bculTimer : Timer = new Timer(250, 1);
			bculTimer.addEventListener(TimerEvent.TIMER, buildCurriculum);
			bculTimer.start();
		}
		
		private function buildStaffListener(e:Event)
		{
			var bstlTimer : Timer = new Timer(250, 1);
			bstlTimer.addEventListener(TimerEvent.TIMER, buildStaff);
			bstlTimer.start();
		}
		
		private function buildLinksListener(e:Event)
		{
			var blilTimer : Timer = new Timer(250, 1);
			blilTimer.addEventListener(TimerEvent.TIMER, buildLinks);
			blilTimer.start();
		}
		
		private function buildPublicationsListener(e:Event)
		{
			var bpulTimer : Timer = new Timer(250, 1);
			bpulTimer.addEventListener(TimerEvent.TIMER, buildPublications);
			bpulTimer.start();
		}
		
		private function buildInternationalListener(e:Event)
		{
			var binlTimer : Timer = new Timer(250, 1);
			binlTimer.addEventListener(TimerEvent.TIMER, buildInternational);
			binlTimer.start();
		}
		
		private function buildAnnouncementsListener(e:Event)
		{
			var banlTimer : Timer = new Timer(250, 1);
			banlTimer.addEventListener(TimerEvent.TIMER, buildAnnouncements);
			banlTimer.start();
		}
		
		private function buildExhibitionAndFestivalsListener(e:Event)
		{
			var bexlTimer : Timer = new Timer(250, 1);
			bexlTimer.addEventListener(TimerEvent.TIMER, buildExhibitionAndFestivals);
			bexlTimer.start();
		}
		
		private function buildAbout(e:TimerEvent = null)
		{
			var pageabout:PageAbout = new PageAbout(aboutdatabase, univ);
			if(global.currentpageobj){univ._scontent.removeChild(global.currentpageobj);}
			univ._scontent.addChild(pageabout);
			global.currentpage = "about";
			global.currentpageobj = pageabout;
			univ.toContent();
		}
		
		private function buildContact(e:TimerEvent = null)
		{
			var pagecontact:PageContact = new PageContact(contactdatabase, univ);
			if(global.currentpageobj){univ._scontent.removeChild(global.currentpageobj);}
			univ._scontent.addChild(pagecontact);
			global.currentpage = "contact";
			global.currentpageobj = pagecontact;
			univ.toContent();
		}
		
		private function buildCurriculum(e:TimerEvent = null)
		{
			var pagecurriculum:PageCurriculum = new PageCurriculum(curriculumdatabase, univ, null);
			if (global.currentpageobj){univ._scontent.removeChild(global.currentpageobj); }
			univ._scontent.addChild(pagecurriculum);
			global.currentpage = "curriculum";
			global.currentpageobj = pagecurriculum;
			univ.toContent();
		}
		
		private function buildStaff(e:TimerEvent = null)
		{
			var pagestaff:PageStaff = new PageStaff(staffdatabase, univ);
			if (global.currentpageobj){univ._scontent.removeChild(global.currentpageobj); }
			univ._scontent.addChild(pagestaff);
			global.currentpage = "staff";
			global.currentpageobj = pagestaff;
			univ.toContent();
		}
		
		private function buildLinks(e:TimerEvent = null)
		{
			var pagelinks:PageLinks = new PageLinks(linksdatabase, univ);
			if (global.currentpageobj){univ._scontent.removeChild(global.currentpageobj); }
			univ._scontent.addChild(pagelinks);
			global.currentpage = "links";
			global.currentpageobj = pagelinks;
			univ.toContent();
		}
		
		private function buildPublications(e:TimerEvent = null)
		{
			var pagepublications:PagePublications = new PagePublications(publicationsdatabase, univ);
			if (global.currentpageobj){univ._scontent.removeChild(global.currentpageobj); }
			univ._scontent.addChild(pagepublications);
			global.currentpage = "publications";
			global.currentpageobj = pagepublications;
			univ.toContent();
		}
		
		private function buildInternational(e:TimerEvent = null)
		{
			var pageinternational:PageInternational = new PageInternational(internationaldatabase, univ);
			if (global.currentpageobj){univ._scontent.removeChild(global.currentpageobj); }
			univ._scontent.addChild(pageinternational);
			global.currentpage = "international";
			global.currentpageobj = pageinternational;
			univ.toContent();
		}
		
		private function buildAnnouncements(e:TimerEvent = null)
		{
			var pageannouncements:PageAnnouncements = new PageAnnouncements(announcementsdatabase, univ);
			if (global.currentpageobj){univ._scontent.removeChild(global.currentpageobj); }
			univ._scontent.addChild(pageannouncements);
			global.currentpage = "announcements";
			global.currentpageobj = pageannouncements;
			univ.toContent();
		}
		
		private function buildExhibitionAndFestivals(e:TimerEvent = null)
		{
			var pageexhibitionandfestivals:PageExhibitionAndFestivals = new PageExhibitionAndFestivals(exhibitionandfestivalsdatabase, univ);
			if (global.currentpageobj){univ._scontent.removeChild(global.currentpageobj); }
			univ._scontent.addChild(pageexhibitionandfestivals);
			global.currentpage = "exhibitionandfestivals";
			global.currentpageobj = pageexhibitionandfestivals;
			univ.toContent();
		}
		
	}
	
}