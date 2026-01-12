package 
{
	import flash.display.*;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import lt.uza.utils.*;
	
	public class SectionContent extends MovieClip
	{
		
		private var global										: Global = Global.getInstance();
		private var univ					: VcdTwoThousandAndNine;
		
		public function SectionContent(puniv:VcdTwoThousandAndNine)
		{
			univ					 = puniv;
			init();
		}
		
		private function init()
		{
			this.x = 2000;
			buttonize();
		}
		
		private function buttonize()
		{
			menuBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			menuBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			menuBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
			menuBTTN.visualMC.alpha = 0.5;
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, langBttnOver);
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, langBttnOut);
			langBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, langBttnDown);
			langBTTN.alpha = 0.5;
		}
		
		private function langBttnOver(e:MouseEvent)
		{
			Tweener.addTween(langBTTN, { alpha:1, time:0, transition:"easeOutExpo" } );
		}
		
		private function langBttnOut(e:MouseEvent)
		{
			Tweener.addTween(langBTTN, { alpha:0.5, time:1, transition:"easeOutExpo" } );
		}
		
		private function langBttnDown(e:MouseEvent)
		{
			global.univ.changeLang();
		}
		
		private function rollOver(e:MouseEvent)
		{
			menuBTTN.visualMC.alpha = 1;
			Tweener.addTween(menuBTTN.visualMC, { alpha:1, time:1, transition:"easeOutExpo" } );
		}
		
		private function rollOut(e:MouseEvent)
		{
			Tweener.addTween(menuBTTN.visualMC, { alpha:0.5, time:1, transition:"easeOutExpo" } );
		}
		
		private function clicked(e:MouseEvent)
		{
			univ.toMenu();
			Tweener.addTween(menuBTTN.visualMC, { alpha:0.5, time:1, transition:"easeOutExpo" } );
		}
		
	}
}