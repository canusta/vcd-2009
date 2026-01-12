package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.*;
	import com.canusta.text.*;
	import com.canusta.data.Database;
	import caurina.transitions.*;
	
	public class ButtonPartAnnouncements extends MovieClip
	{
		private var id							: Number;
		private var database					: Database;
		private var owner						: PartAnnouncements;
		private var margin:Number 				= 10;
		
		public function ButtonPartAnnouncements(pid:Number, pdatabase:Database, powner:PartAnnouncements) 
		{
			id = pid;
			database = pdatabase;
			owner = powner;
			init();
		}
		
		private function init()
		{
			this.x = 0;
			this.y = id*47;
			this.titleTXT.autoSize = TextFieldAutoSize.LEFT;
			this.dateTXT.autoSize = TextFieldAutoSize.LEFT;
			this.titleTXT.text = database.data.item[id].brief;
			this.dateTXT.text = database.data.item[id].date;
			this.idTXT.text = database.data.item[id].@id;
			this.arrowMC.x = this.titleTXT.width + margin;
			if (id == 0)// ilk button, selected olmali ve content i yazilmali
			{
				this.bgMC.alpha = 100;
			}
			// Buttonize
			bttn.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			bttn.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			bttn.addEventListener(MouseEvent.CLICK, clicked);
		}
		
		private function rollOver(e:MouseEvent)
		{
			if (owner.activeButton != e.currentTarget.parent)
			{
				Tweener.removeTweens(e.currentTarget.parent.bgMC);
				e.currentTarget.parent.bgMC.alpha = 1;
			}
		}
		
		private function rollOut(e:MouseEvent)
		{
			if (owner.activeButton != e.currentTarget.parent)
			{
				Tweener.addTween(e.currentTarget.parent.bgMC, { alpha:0, time:1, transition:"easeOutExpo" } );
			}
		}
		
		private function clicked(e:MouseEvent)
		{
			if (owner.activeButton != e.currentTarget.parent)
			{
				Tweener.addTween(owner.activeButton.bgMC, { alpha:0, time:1, transition:"easeOutExpo" } );
				e.currentTarget.parent.bgMC.alpha = 50;
				owner.activeButton = e.currentTarget.parent;
				//TextChanger.changeText(e.currentTarget.parent.parent.titleTXT, database.data.item[id].title, "fill", 1, 0);
				//TextChanger.changeText(e.currentTarget.parent.parent.dateTXT, database.data.item[id].date, "fill", 1, 1);
				e.currentTarget.parent.parent.titleTXT.text = database.data.item[id].title;
				e.currentTarget.parent.parent.dateTXT.text = database.data.item[id].date;
				e.currentTarget.parent.parent.contentTXT.htmlText = database.data.item[id].content;
				if (e.currentTarget.parent.parent.contentTXT.height >= 180)
				{
					e.currentTarget.parent.parent.screenBg.height = e.currentTarget.parent.parent.contentTXT.height + 12;
					e.currentTarget.parent.parent.skipBTTN.y = e.currentTarget.parent.parent.screenBg.height;
				}else
				{
					e.currentTarget.parent.parent.screenBg.height = 191;
					e.currentTarget.parent.parent.skipBTTN.y = 191;
				}
			}
		}
		
	}
	
}