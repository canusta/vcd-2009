package 
{
	
	import fl.transitions.easing.Strong;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import com.canusta.data.Database;
	import com.canusta.text.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class PageCurriculum extends MovieClip
	{
		
		private var global					: Global = Global.getInstance();
		private var database				: Database;
		private var db						: Array; // database'in array e atilmis hali.
		private var univ					: VcdTwoThousandAndNine;
		private var currentsub				: Object; // ilk sub category i burda tutuyoruz. chron, alpha, dep.
		private var currentsubsub			: Object;
		public var curriculumListHeader		: PartCurriculumListHeader = new PartCurriculumListHeader();
		private var targetItem				: Object;
		private var itemListObjects			: Array; // listedeki item moviecliplerini id'lerine gore dizilmis bi sekilde tutuyo. listenin 0'ı scenedeki 0 id li item ı gosteriyo.
		private var currentListArray		: Array; // filtrelerden gecirilmis curriculum. filtre degisikce yenileniyo.
		private var itemListX				: Number = 50;
		private var itemcount				: Number;
		private var lineheight				: Number = 44;
		private var contentMargin			: Number = 7;
		private var scrollratio				: Number;
		private var scrollStartMouseY		: Number;
		private var scrollStartBarY			: Number;
		private var scrollbgheight			: Number;
		private var activecontentspaceheight: Number;
		private var contentheight			: Number;
		private var scrollbarheight			: Number;
		private var s1y1bttn				: Boolean = false;
		private var s1y2bttn				: Boolean = false;
		private var s1y3bttn				: Boolean = false;
		private var s1y4bttn				: Boolean = false;
		private var s1springbttn			: Boolean = false;
		private var s1fallbttn				: Boolean = false;
		private var s1electivebttn			: Boolean = false;
		private var s1corebttn				: Boolean = false;
		private var s2bttnValues			: Array;
		private var s2bttns					: Array;
		private var s3vcd					: Boolean = false;
		private var s3pov					: Boolean = false;
		private var s3ftv					: Boolean = false;
		private var s3other					: Boolean = false;
		private var arrayidcounter			: Number = 0;
		
		public function PageCurriculum(pdatabase:Database, puniv:VcdTwoThousandAndNine, ptargetItem:Object) 
		{
			targetItem = ptargetItem;
			database = pdatabase;
			univ = puniv;
			currentsub = null;
			itemListObjects = new Array();
			currentListArray = new Array();
			s2bttns = new Array();
			s2bttnValues = new Array();
			db = new Array();
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			/*if (targetItem == null)
			{
				init();
			}else
			{
				// there is an item to view
			}*/
		}
		
		private function init(e:Event)
		{
			buildPage();
			convertDatabaseToArray();
			createS2Array();
			chrbttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			chrbttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			chrbttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, subClickedAction);
			alpbttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			alpbttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			alpbttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, subClickedAction);
			depbttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			depbttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			depbttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, subClickedAction);
		}
		
		private function destroy(e:Event)
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopScroll);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doScroll);
		}
		
		private function buildPage()
		{
			addChild(curriculumListHeader);
			for (var i:Number = 0; i < database.data.item.length(); i++ )
			{
				if (database.data.item[i].@listitem == "1")
				{
					var item : PartCurriculumListItem  = new PartCurriculumListItem(arrayidcounter, database.data.item[i], this);
					arrayidcounter++;
					itemListObjects.push(item);
					this.curriculumListHeader.canvasMC.contentMC.addChild(item);
				}
			}
			itemcount = itemListObjects.length;
			curriculumListHeader.scrollMC.bgMC.height = global.stageHeight - 366;
			rebuildScroll();
			scrollize();
		}
		
		private function convertDatabaseToArray()
		{
			for (var i:Number = 0; i < database.data.item.length(); i++)
			{
				if (database.data.item[i].@listitem == "1")
				{
					db.push({
						obj						: itemListObjects[i],
						id						: database.data.item[i].@id, 
						visible					: 1,
						department				: database.data.item[i].department,
						code					: database.data.item[i].code,
						name					: database.data.item[i].name,
						year					: database.data.item[i].year,
						period					: database.data.item[i].period,
						type					: database.data.item[i].type
					});
				}
			}
		}
		
		private function subRollOverAction(e:Event)
		{
			if (e.currentTarget.parent.Status == 0)
			{
				e.currentTarget.parent.alpha = 1;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:90, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:15, time:1, transition:"easeOutExpo" } );
			}
		}
		
		private function subRollOutAction(e:Event)
		{
			if (e.currentTarget.parent.Status == 0)
			{
				e.currentTarget.parent.alpha = 0.5;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:0, time:1, transition:"easeOutExpo" } );
			}
		}
		
		private function subClickedAction(e:Event)
		{
			
			if (currentsub)
			{
				currentsub.Status = 0;
				currentsub.alpha = 0.5;
				Tweener.addTween(currentsub.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(currentsub.arrow, { x:0, time:1, transition:"easeOutExpo" } );
			}
			
			e.currentTarget.parent.alpha = 1;
			e.currentTarget.parent.Status = 1;
			currentsub = e.currentTarget.parent;
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:15, time:1, transition:"easeOutExpo" } );
			
			switch (e.currentTarget.parent)
			{
				case chrbttn :
					charList();
					break;
				case alpbttn :
					alpList();
					break;
				case depbttn :
					depList();
					break;
			}
			
			resetContentMCY();
			rebuildScroll();
			
		}
		
		
		/*private function sortOnYear(a:Object, b:Object):Number {
			
			trace(a.name, a.department, a.code, a.year );
			trace(b.name, b.department, b.code, b.year );
			trace("")
			
			if(a.year > b.year) {
				return 1;
			} else if(a.year < b.year) {
				return -1;
			} else  {
				//a.year == b.year
				return 0;
			}
		}*/

		
		private function charList()
		{
			// sorting
			
			//db.sort(sortOnYear);
			db.sortOn(['year', 'code'])
			
			for (var i:Number = 0; i < db.length; i++ )
			{
				db[i].obj.relocate(i, 1);
			}
			
			// submenu reset
			s1y1bttn = false;
			s1y2bttn = false;
			s1y3bttn = false;
			s1y4bttn = false;
			s1springbttn = false;
			s1fallbttn = false;
			s1corebttn = false;
			s1electivebttn = false;
			s1.y1bttn.Status = 0;
			s1.y1bttn.alpha = 0.5;
			s1.y1bttn.arrow.rotation = 0;
			s1.y1bttn.arrow.x = 0;
			s1.y2bttn.Status = 0;
			s1.y2bttn.alpha = 0.5;
			s1.y2bttn.arrow.rotation = 0;
			s1.y2bttn.arrow.x = 0;
			s1.y3bttn.Status = 0;
			s1.y3bttn.alpha = 0.5;
			s1.y3bttn.arrow.rotation = 0;
			s1.y3bttn.arrow.x = 0;
			s1.y4bttn.Status = 0;
			s1.y4bttn.alpha = 0.5;
			s1.y4bttn.arrow.rotation = 0;
			s1.y4bttn.arrow.x = 0;
			s1.springbttn.Status = 0;
			s1.springbttn.alpha = 0.5;
			s1.springbttn.arrow.rotation = 0;
			s1.springbttn.arrow.x = 0;
			s1.fallbttn.Status = 0;
			s1.fallbttn.alpha = 0.5;
			s1.fallbttn.arrow.rotation = 0;
			s1.fallbttn.arrow.x = 0;
			s1.corebttn.Status = 0;
			s1.corebttn.alpha = 0.5;
			s1.corebttn.arrow.rotation = 0;
			s1.corebttn.arrow.x = 0;
			s1.electivebttn.Status = 0;
			s1.electivebttn.alpha = 0.5;
			s1.electivebttn.arrow.rotation = 0;
			s1.electivebttn.arrow.x = 0;
			
			// buttonize
			s1.Status = 1;
			s2.Status = 0;
			s3.Status = 0;
			Tweener.addTween(s1, { alpha:1, time:0.5, transition:"easeInExpo" } );
			Tweener.addTween(s2, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s3, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s1, { y:191, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s2, { y:75, time:1, transition:"easeInExpo" } );
			Tweener.addTween(s3, { y:75, time:1, transition:"easeInExpo" } );
			charListSub();
			itemcount = itemListObjects.length;
			rebuildScroll();
			resetContentMCY();
		}
		
		private function alpList()
		{
			// sorting
			db.sortOn('name');
			for (var i:Number = 0; i < db.length; i++ )
			{
				db[i].obj.relocate(i, 1);
			}
			
			// reset menu
			alpSubbutonReset();
			
			// subbuttonize
			alpSubbuttonize();
			
			// buttonize
			s1.Status = 0;
			s2.Status = 1;
			s3.Status = 0;
			Tweener.addTween(s1, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s2, { alpha:1, time:0.5, transition:"easeInExpo" } );
			Tweener.addTween(s3, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s1, { y:75, time:1, transition:"easeInExpo" } );
			Tweener.addTween(s2, { y:191, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s3, { y:75, time:1, transition:"easeInExpo" } );
			itemcount = itemListObjects.length;
			rebuildScroll();
			resetContentMCY();
		}
		
		private function depList()
		{
			// sorting
			db.sortOn('department');
			for (var i:Number = 0; i < db.length; i++ )
			{
				db[i].obj.relocate(i, 1);
			}
			// submenu reset
			s3vcd = false;
			s3pov = false;
			s3ftv = false;
			s3other = false;
			s3.vcdBTTN.Status = 0;
			s3.vcdBTTN.alpha = 0.5;
			s3.vcdBTTN.arrow.rotation = 0;
			s3.vcdBTTN.arrow.x = 0;
			s3.povBTTN.Status = 0;
			s3.povBTTN.alpha = 0.5;
			s3.povBTTN.arrow.rotation = 0;
			s3.povBTTN.arrow.x = 0;
			s3.ftvBTTN.Status = 0;
			s3.ftvBTTN.alpha = 0.5;
			s3.ftvBTTN.arrow.rotation = 0;
			s3.ftvBTTN.arrow.x = 0;
			s3.otherBTTN.Status = 0;
			s3.otherBTTN.alpha = 0.5;
			s3.otherBTTN.arrow.rotation = 0;
			s3.otherBTTN.arrow.x = 0;
			
			// buttonize
			s1.Status = 0;
			s2.Status = 0;
			s3.Status = 1;
			Tweener.addTween(s1, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s2, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(s3, { alpha:1, time:0.5, transition:"easeInExpo" } );
			Tweener.addTween(s1, { y:75, time:1, transition:"easeInExpo" } );
			Tweener.addTween(s2, { y:75, time:1, transition:"easeInExpo" } );
			Tweener.addTween(s3, { y:191, time:1, transition:"easeOutExpo" } );
			depListSub();
			itemcount = itemListObjects.length;
			rebuildScroll();
			resetContentMCY();
		}
		
		private function charListSub()
		{
			// buttonize
			s1.y1bttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.y2bttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.y3bttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.y4bttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.springbttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.fallbttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.electivebttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.corebttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s1.y1bttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.y2bttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.y3bttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.y4bttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.springbttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.fallbttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.electivebttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.corebttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s1.y1bttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
			s1.y2bttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
			s1.y3bttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
			s1.y4bttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
			s1.springbttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
			s1.fallbttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
			s1.electivebttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
			s1.corebttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, yearBttnClickAction);
		}
		
		private function depListSub()
		{
			// buttonize
			s3.vcdBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s3.vcdBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s3.vcdBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, deptBttnClickAction);
			s3.povBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s3.povBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s3.povBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, deptBttnClickAction);
			s3.ftvBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s3.ftvBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s3.ftvBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, deptBttnClickAction);
			s3.otherBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
			s3.otherBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
			s3.otherBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, deptBttnClickAction);
		}
		
		private function deptBttnClickAction(e:Event)
		{
			if (e.currentTarget.parent.Status == 0)
			{
				e.currentTarget.parent.Status = 1;
			}else
			{
				e.currentTarget.parent.Status = 0;
				e.currentTarget.parent.alpha = 0.5;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:0, time:1, transition:"easeOutExpo" } );
			}
			
			switch(e.currentTarget.parent)
			{
				case s3.vcdBTTN :
					if (s3vcd == true)
					{
						s3vcd = false;
					}else
					{
						s3vcd = true;
					}
					break;
				case s3.povBTTN :
					if (s3pov == true)
					{
						s3pov = false;
					}else
					{
						s3pov = true;
					}
					break;
				case s3.ftvBTTN :
					if (s3ftv == true)
					{
						s3ftv = false;
					}else
					{
						s3ftv = true;
					}
					break;
				case s3.otherBTTN :
					if (s3other == true)
					{
						s3other = false;
					}else
					{
						s3other = true;
					}
					break;
			}
			updateList();
		}
		
		private function yearBttnClickAction(e:Event)//////////////////
		{
			if (e.currentTarget.parent.Status == 0)
			{
				e.currentTarget.parent.Status = 1;
			}else
			{
				e.currentTarget.parent.Status = 0;
				e.currentTarget.parent.alpha = 0.5;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:0, time:1, transition:"easeOutExpo" } );
			}
			switch(e.currentTarget.parent)
			{
				case s1.y1bttn :
					if (s1y1bttn == true)
					{
						s1y1bttn = false;
					}else
					{
						s1y1bttn = true;
					}
					break;
				case s1.y2bttn :
					if (s1y2bttn == true)
					{
						s1y2bttn = false;
					}else
					{
						s1y2bttn = true;
					}
					break;
				case s1.y3bttn :
					if (s1y3bttn == true)
					{
						s1y3bttn = false;
					}else
					{
						s1y3bttn = true;
					}
					break;
				case s1.y4bttn :
					if (s1y4bttn == true)
					{
						s1y4bttn = false;
					}else
					{
						s1y4bttn = true;
					}
					break;
				case s1.springbttn :
					if (s1springbttn == true)
					{
						s1springbttn = false;
					}else
					{
						s1springbttn = true;
					}
					break;
				case s1.fallbttn :
					if (s1fallbttn == true)
					{
						s1fallbttn = false;
					}else
					{
						s1fallbttn = true;
					}
					break;
				case s1.electivebttn :
					if (s1electivebttn == true)
					{
						s1electivebttn = false;
					}else
					{
						s1electivebttn = true;
					}
					break;
				case s1.corebttn :
					if (s1corebttn == true)
					{
						s1corebttn = false;
					}else
					{
						s1corebttn = true;
					}
					break;
			}
			updateList();
		}
		
		private function updateList()
		{
			if (currentsub == chrbttn)
			{
				s1filtering();
			}
			if (currentsub == depbttn)
			{
				s3filtering();
			}
			
			var e:Number = 0;
			for (var iii:Number = 0; iii < db.length; iii++ )
			{
				if (db[iii].visible == 1)
				{
					db[iii].obj.relocate(e, 1);
					e++;
				}else
				{
					db[iii].obj.relocate(100, 0);
				}
			}
			
			itemcount = e;
			
			rebuildScroll();
			resetContentMCY()
			
		}
		
		private function s1filtering()
		{
			for (var ii:Number = 0; ii <  db.length; ii++ )
			{
				db[ii].visible = 0;
			}
			for (var i:Number = 0; i <  db.length; i++ )
			{
				if (s1y1bttn==true)
				{
					if (db[i].year == 1)
					{
						db[i].visible = 1;
					}
				}
				if (s1y2bttn==true)
				{
					if (db[i].year == 2)
					{
						db[i].visible = 1;
					}
				}
				if (s1y3bttn==true)
				{
					if (db[i].year == 3)
					{
						db[i].visible = 1;
					}
				}
				if (s1y4bttn==true)
				{
					if (db[i].year == 4)
					{
						db[i].visible = 1;
					}
				}
				if (s1y1bttn == false && s1y2bttn == false && s1y3bttn == false && s1y4bttn == false)
				{
					db[i].visible = 1;
				}
				if (s1springbttn==true && s1fallbttn==false)
				{
					if (db[i].period == 1)
					{
						db[i].visible = 0;
					}
				}
				if (s1fallbttn==true && s1springbttn==false)
				{
					if (db[i].period == 2)
					{
						db[i].visible = 0;
					}
				}
				if (s1electivebttn == true && s1corebttn == false)
				{
					if (db[i].type == 0)
					{
						db[i].visible = 0;
					}
				}
				if (s1corebttn == true && s1electivebttn == false)
				{
					if (db[i].type == 1)
					{
						db[i].visible = 0;
					}
				}
			}
		}
		
		private function s3filtering()
		{
			for (var ii:Number = 0; ii <  db.length; ii++ )
			{
				db[ii].visible = 0;
			}
			for (var i:Number = 0; i <  db.length; i++ )
			{
				if (s3vcd==true)
				{
					if (db[i].department == 0)
					{
						db[i].visible = 1;
					}
				}
				if (s3pov==true)
				{
					if (db[i].department == 1)
					{
						db[i].visible = 1;
					}
				}
				if (s3ftv==true)
				{
					if (db[i].department == 2)
					{
						db[i].visible = 1;
					}
				}
				if (s3other==true)
				{
					if (db[i].department == 3 || db[i].department == 4 || db[i].department == 5 || db[i].department == 6)
					{
						db[i].visible = 1;
					}
				}
				if (s3vcd == false && s3pov == false && s3ftv == false && s3other == false)
				{
					db[i].visible = 1;
				}
			}
		}
		
		private function scrollize()
		{
			curriculumListHeader.scrollMC.bttn.addEventListener(MouseEvent.MOUSE_DOWN, startScroll);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
		}
		
		private function startScroll(e:MouseEvent)
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, doScroll);
			scrollStartMouseY = mouseY;
			scrollStartBarY = curriculumListHeader.scrollMC.barMC.y;
		}
		
		private function stopScroll(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doScroll);
		}
		
		private function doScroll(e:MouseEvent)
		{
			var targetY = scrollStartBarY + (mouseY - scrollStartMouseY);
			if (targetY<=0)
			{
				targetY = 0;
			}
			if (targetY >= scrollbgheight - scrollbarheight)
			{
				targetY = scrollbgheight - scrollbarheight;
			}
			curriculumListHeader.scrollMC.barMC.y = targetY;
			var scrollActualAreaHeight:Number = scrollbgheight - scrollbarheight;
			var scrollActualPosition:Number = scrollActualAreaHeight - targetY ;
			var scrollPercent:Number = (scrollActualPosition * 100) / scrollActualAreaHeight;
			var contentActualAreaHeight:Number = scrollbgheight;
			var contentPercent:Number = ( contentheight - contentActualAreaHeight ) / 100;
			var targety:Number = 0 - ( (100 - scrollPercent) * contentPercent );
			Tweener.addTween(curriculumListHeader.canvasMC.contentMC, { y:targety, time:1, transition:"easeOutExpo" } );
		}
		
		private function rebuildScroll()
		{
			// scrollbgheight ile contentin gozuken yuksekligi esit
			contentheight = ( lineheight * (itemcount+1) ) + contentMargin;
			activecontentspaceheight = curriculumListHeader.scrollMC.bgMC.height;
			scrollbgheight = curriculumListHeader.scrollMC.bgMC.height;
			curriculumListHeader.scrollMC.bttn.height = scrollbgheight + 40;
			scrollratio = activecontentspaceheight / contentheight;
			if (scrollratio >= 1)
			{
				scrollratio = 1;
				Tweener.addTween(curriculumListHeader.scrollMC, { alpha:0, time:1, transition:"easeOutExpo" } );
			}else
			{
				Tweener.addTween(curriculumListHeader.scrollMC, { alpha:1, time:1, transition:"easeOutExpo" } );
			}
			
			scrollbarheight = scrollbgheight * scrollratio;
			Tweener.addTween(curriculumListHeader.scrollMC.barMC, { height:scrollbarheight, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(curriculumListHeader.scrollMC.barMC, { y:0, time:1, transition:"easeOutExpo" } );
		}
		
		private function resetContentMCY()
		{
			Tweener.removeTweens(curriculumListHeader.canvasMC.contentMC);
			Tweener.addTween(curriculumListHeader.canvasMC.contentMC, { y:0, time:1, transition:"easeOutExpo" } );
		}
		
		private function createS2Array()
		{
			s2bttnValues.push("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "num");
			for (var i:Number = 0; i < s2bttnValues.length; i++)
			{
				s2bttns.push( {
					Bttn		: s2[s2bttnValues[i]+"bttn"],
					Status		: false,
					Value		: s2bttnValues[i]
				} );
			}
		}
		
		private function alpSubbuttonize()
		{
			for (var i:Number = 0; i < s2bttns.length; i++)
			{
				//s2bttns[i].Bttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
				s2bttns[i].Bttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, subRollOverAction);
				s2bttns[i].Bttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, subRollOutAction);
				s2bttns[i].Bttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, alphabeticalBttnClickAction);
			}
		}
		
		private function alphabeticalBttnClickAction(e:MouseEvent)
		{
			if (e.currentTarget.parent.Status == 0)
			{
				e.currentTarget.parent.Status = 1;
			}else
			{
				e.currentTarget.parent.Status = 0;
				e.currentTarget.parent.alpha = 0.5;
				Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(e.currentTarget.parent.arrow, { x:0, time:1, transition:"easeOutExpo" } );
			}
			for (var i:Number = 0; i < s2bttns.length; i++)
			{
				if (s2bttns[i].Bttn == e.currentTarget.parent)
				{
					if (s2bttns[i].Status == true)
					{
						s2bttns[i].Status = false;
					}else
					{
						s2bttns[i].Status = true;
					}
				}
			}
			
			for (var iiii:Number = 0; iiii <  db.length; iiii++ )
			{
				db[iiii].visible = 0;
			}
			
			for (var ii:Number = 0; ii <  db.length; ii++ )
			{
				for (var iii:Number = 0; iii <  s2bttns.length; iii++ )
				{
					if (s2bttns[iii].Status == true)
					{
						if (db[ii].name.substr(0,1) == s2bttns[iii].Value || db[ii].name.substr(0,1) == s2bttns[iii].Value.toUpperCase())
						{
							db[ii].visible = 1;
						}
						// bunlar sayilar, num, #
						if (s2bttns[iii].Value == "num")
						{
							if (db[ii].name.substr(0,1) == "0" || db[ii].name.substr(0,1) == "1" || db[ii].name.substr(0,1) == "2" || db[ii].name.substr(0,1) == "3" || db[ii].name.substr(0,1) == "4" || db[ii].name.substr(0,1) == "5" || db[ii].name.substr(0,1) == "6" || db[ii].name.substr(0,1) == "7" || db[ii].name.substr(0,1) == "8" || db[ii].name.substr(0,1) == "9")
							{
								db[ii].visible = 1;
							}
						}
					}
				}
			}
			
			// butun button lar false ise hepsi true ymus gibi davranmasi icin
			var vi:Number = 0;
			for (var v:Number = 0; v <  s2bttns.length; v++ )
			{
				if (s2bttns[v].Status == false)
				{
					vi++;
				}
			}
			if (vi == s2bttns.length)
			{
				for (var vii:Number = 0; vii <  db.length; vii++ )
				{
					db[vii].visible = 1;
				}
			}
			
			updateList();
			
		}
		
		private function alpSubbutonReset()
		{
			for (var i:Number = 0; i < s2bttns.length; i++)
			{
				s2bttns[i].Status = false;
				s2bttns[i].Bttn.Status = false;
				s2bttns[i].Bttn.arrow.x = 0;
				s2bttns[i].Bttn.arrow.rotation = 0;
				s2bttns[i].Bttn.alpha = 0.5;
				//////////////////////////////////////////////////////////////////
			}
			
			for ( var ii:Number = 0; ii < db.length; ii++)
			{
				db[ii].visible = 0;
			}
			
		}
		
	}
	
}