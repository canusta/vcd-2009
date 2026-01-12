/**
* @author Can Usta (http://www.canusta.com)
*/

package com.canusta.gui 
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Can Usta
	*/
	public class BttnBlocker extends MovieClip
	{
		
		private var bttnblockerMC          : BttnBlockerMC;
		public var status					: String = null;
		
		public function BttnBlocker() 
		{
			init();
		}
		
		private function init()
		{
			//block();
		}
		
		public function block()
		{
			if (status == null || status == "unblocked")
			{
				trace("blocking")
				bttnblockerMC = new BttnBlockerMC();
				bttnblockerMC.alpha = 0;
				this.addChild(bttnblockerMC);
				status = "blocked";
			}
		}
		
		public function unblock()
		{
			if (status == null || status == "blocked")
			{
				trace("unblocking")
				if (bttnblockerMC)
				{
					this.removeChild(bttnblockerMC);
					status = "unblocked";
				}
			}
		}
		
	}
	
}