/**
* @author Can Usta (http://www.canusta.com)
*/

package com.canusta.gui{
	import flash.display.*;
	import flash.events.*;
	import VcdTwoThousandAndNine;
	import caurina.transitions.*;

	public class Align extends EventDispatcher
	{
		private var mRoot                 : VcdTwoThousandAndNine;
		private var basewidth             : int;
		private var baseheight			  : int;
		private var targetwidth           : int;
		private var targetheight		  : int;
		private var targetx               : int;
		private var targety				  : int;
		private var basex                 : int;
		private var basey				  : int;

		private var canvaswidth : int = 1000;
		private var canvasheight : int = 700;

		public function Align(pRoot:VcdTwoThousandAndNine) {
			mRoot = pRoot;
		}
		
		public function arrange(target:Object, base:Object, baseroot:String, type:String, action:String) {
			targetwidth = target.width;
			targetheight = target.height;
			if (baseroot == "yes") {
				base = mRoot;
				basewidth = mRoot.stage.stageWidth;
				baseheight = mRoot.stage.stageHeight;
				basex = (canvaswidth - basewidth) / 2;
				basey = (canvasheight - baseheight) / 2;
			} else {
				basewidth = base.width;
				baseheight = base.height;
				basex = base.x;
				basey = base.y;
			}
			switch (type) {
				case "C" :
					targetx = basex + ( ( basewidth - targetwidth ) / 2 );
					break;
				case "L" :
					targetx = basex ;
					break;
				case "R" :
					targetx = basex + ( basewidth - targetwidth );
					break;
				case "M" :
					targety = 0 + ( ( baseheight - targetheight ) / 2 ); // 0 yerine basey de olabilir
					break;
				default :
			}
			if (type == "C" || type == "L" || type == "R")
			{
				if (action == "no") {
					target.x = targetx;
				} else {
					Tweener.addTween(target, { x:targetx, time:1, onComplete:completed, transition:"easeOutExpo" } );
				}
			}else
			{
				target.y = targety;
				Tweener.addTween(target, { y:targety, time:1, onComplete:completed, transition:"easeOutExpo" } );
			}
			
		}
		
		private function completed()
		{
			dispatchEvent(new Event("arranged"));
		}
		
	}
}