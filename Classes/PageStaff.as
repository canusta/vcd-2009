package 
{
	
	import com.canusta.data.Database;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.*;
	import com.canusta.gui.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class PageStaff extends MovieClip
	{
		
		private var global					: Global = Global.getInstance();
		private var database				: Database;
		private var univ					: VcdTwoThousandAndNine;
		private var scroll					: Scroll;
		private var staffList				: Array;
		private var columnList				: Array;
		private var staffCategoryList		: Array;
		private var titleSpacing			: Number = 2;
		private var itemSpacing				: Number = 0;
		private var sectionSpacing			: Number = 36;
		
		public function PageStaff(pdatabase:Database, puniv:VcdTwoThousandAndNine) 
		{
			database 						= pdatabase;
			univ 							= puniv;
			staffList						= new Array();
			columnList						= new Array(
														{id:0, x:0, currentHeight:0 },
														{id:1, x:365, currentHeight:0 }
														);
			if (global.language == "eng")
			{
				staffCategoryList				= new Array(
															{id: 0, column: 0, names: "HEAD OF DEPARTMENT" },
															{id: 1, column: 0, names: "FULL TIME" },
															{id: 2, column: 1, names: "ADJUNCTS" },
															{id: 3, column: 0, names: "TEACHING ASSISTANTS" },
															{id: 4, column: 0, names: "ADMINISTRATIVE ASSISTANTS" },
															{id: 5, column: 0, names: "TECHNICAL ASSISTANTS" }
															);
			}else {
				staffCategoryList				= new Array(
															{id: 0, column: 0, names: "BÖLÜM BAŞKANI" },
															{id: 1, column: 0, names: "TAM ZAMANLI" },
															{id: 2, column: 1, names: "YARI ZAMANLI" },
															{id: 3, column: 0, names: "ARAŞTIRMA GÖREVLİLERİ" },
															{id: 4, column: 0, names: "İDARİ ASİSTAN" },
															{id: 5, column: 0, names: "TEKNİK ASİSTANLAR" }
															);
			}
			init();
		}
		
		private function init()
		{
			for ( var i :Number = 0; i < 2; i++ )
			{
				for ( var ii :Number = 0; ii < staffCategoryList.length; ii++ )
				{
					if (staffCategoryList[ii]["column"] == i)
					{
						var head : TextFieldAutoscape15px = new TextFieldAutoscape15px(staffCategoryList[ii]["names"]);
						contentMC.addChild(head);
						head.x = columnList[i]["x"];
						head.y = columnList[i]["currentHeight"];
						columnList[i]["currentHeight"] = head.y + head.height + titleSpacing;
						for ( var iii :Number = 0; iii < database.data.item.length(); iii++ )
						{
							if (database.data.item[iii].type == ii)
							{
								var item : StaffListItem = new StaffListItem(database.data.item[iii].name, database.data.item[iii].@id, this);
								contentMC.addChild(item);
								item.x = columnList[i]["x"];
								item.y = columnList[i]["currentHeight"];
								columnList[i]["currentHeight"] = item.y + item.height + itemSpacing;
							}
						}
					}
					
					if (i == 0 && ii!=1 && ii!=5)
					{
						columnList[i]["currentHeight"] = columnList[i]["currentHeight"] + sectionSpacing;
						trace(ii)
					}
				}
			}
			
			scroll = new Scroll(960, 346, global.stageHeight-366, contentMC, contentMC.y, 0);
			this.addChild(scroll);
			
		}
		
	}

}