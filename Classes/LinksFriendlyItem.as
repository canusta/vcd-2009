package
{
	import flash.display.MovieClip;
	import flash.text.*;
	
	public class LinksFriendlyItem extends MovieClip
	{
		
		private var link				: String;
		private var linkname			: String;
		private var detail				: String;
		private var Var					: String;
		
		public function LinksFriendlyItem(plink:String, plinkname:String, pdetail:String) 
		{
			link = plink;
			linkname = plinkname;
			detail = pdetail;
			init();
		}
		
		private function init()
		{
			nameTXT.text = linkname;
			detailTXT.text = detail;
			linkTXT.text = link;
		}
		
		public function get _Var ():String{
			return Var;
		}
		
		public function set _Var (p_Var:String){
			Var = p_Var;
		}
		
	}
	
}