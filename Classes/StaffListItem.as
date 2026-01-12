package
{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.events.MouseEvent;
	import caurina.transitions.*;
	
	public class StaffListItem extends MovieClip
	{
		
		private var content				: String;
		private var id					: Number;
		private var owner				: Object;
		
		public function StaffListItem(pcontent:String, pid:Number, powner:Object) 
		{
			content = pcontent;
			id = pid;
			owner = powner;
			TXT.text = content;
			init();
		}
		
		private function init()
		{
			bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
			bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
			bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnClicked);
		}
		
		private function bttnOver(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0.2, time:0, transition:"easeOutExpo" } );
		}
		
		private function bttnOut(e:MouseEvent)
		{
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0, time:1, transition:"easeOutExpo" } );
		}
		
		private function bttnClicked(e:MouseEvent)
		{
			var page : StaffPage  = new StaffPage(id, owner);
			owner.addChild(page);
		}
		
	}
	
}