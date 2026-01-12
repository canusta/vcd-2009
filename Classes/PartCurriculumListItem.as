package 
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class PartCurriculumListItem extends MovieClip
	{
		
		private var global					: Global = Global.getInstance();
		private var database				: XML;
		private var owner					: Object;
		private var id						: Number;
		private var department				: String;
		private var code					: String;
		private var name_					: String;
		private var instructors				: Array;
		private var credit					: String;
		private var order_					: Number;
		private var departmentname			: String;
		private var status_					: Number;
		private var marginx					: Number = 50;
		private var marginy					: Number = 3;
		private var lineheight				: Number = 44;
		private var arrayid					: Number;
		
		public function PartCurriculumListItem(parrayid:Number, pdatabase:XML, powner:Object) 
		{
			instructors = new Array();
			arrayid = parrayid;
			database = pdatabase;
			owner = powner;
			id = database.@id;
			department = database.department;
			code = database.code;
			name_ = database.name;
			for ( var i:Number = 0; i < database.instructors.instructor.length(); i++)
			{
				instructors.push(database.instructors.instructor[i]);
			}
			
			credit = database.credit;
			switch (department)
			{
				case "0" :
					departmentname="VCD";
					break;
				case "1" :
					departmentname="POV";
					break;
				case "2" :
					departmentname="FTV";
					break;
				case "3" :
					departmentname="FYE";
					break;
				case "4" :
					departmentname="HTR";
					break;
				case "5" :
					departmentname="SAT";
					break;
				case "6" :
					departmentname="TK";
					break;
			}
			
			init();
		}
	
		private function init()
		{
			this.alpha = 0;
			this.x = marginx;
			this.y = marginy + ( arrayid * lineheight );
			this.idTXT.text = departmentname + code;
			if (global.language == "eng")
			{
				this.nameTXT.text = name_.toUpperCase();
			}else {
				this.nameTXT.text = global.univ.toUp(name_);
			}
			
			for ( var i:Number = 0; i < instructors.length; i++)
			{
				var tempTXT:String = this.detailTXT.text;
				var instr : String = global.univ.toUp(instructors[i]);
				this.detailTXT.text = tempTXT + instr + "; ";
				tempTXT = this.detailTXT.text;
			}
			this.detailTXT.text = tempTXT + credit;
			Tweener.addTween(this, { alpha:1, time:1, delay:id * 0.1, transition:"easeOutExpo" } );
			buttonize();
		}
		
		public function relocate(porder:Number, pstatus_:Number)
		{
			status_ = pstatus_;
			order_ = porder;
			if (status_ == 0)
			{
				Tweener.addTween(this, { alpha:0, time:1, transition:"easeOutExpo" } );
			}else
			{
				Tweener.addTween(this, { alpha:1, time:1, transition:"easeOutExpo" } );
			}
			var targety:Number = marginy + ( order_ * lineheight );
			Tweener.addTween(this, { y:targety, time:1, transition:"easeOutExpo" } );
		}
		
		private function buttonize()
		{
			bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
			bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
			bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnClicked);
		}
		
		private function bttnOver(e:MouseEvent)
		{
			//Tweener.resumeTweens(bgMC);
			//bgMC.alpha = 0.1;
			Tweener.addTween(bgMC, { alpha:0.1, time:0, transition:"easeOutExpo" } );
		}
		
		private function bttnOut(e:MouseEvent)
		{
			//bgMC.alpha = 0;
			Tweener.addTween(bgMC, { alpha:0, time:1, transition:"easeOutExpo" } );
		}
		
		private function bttnClicked(e:MouseEvent)
		{
			var page : CurriculumPage  = new CurriculumPage(database.@id, owner);////////////////
			owner.addChild(page);
		}
		
	}
	
}