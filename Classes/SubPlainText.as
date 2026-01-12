package
{
	
	import com.canusta.data.Database;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import XMLList;
	import flash.text.*;
	import com.canusta.gui.*;
	import lt.uza.utils.*;
	import caurina.transitions.*;
	
	public class SubPlainText extends MovieClip
	{
		
		private var global				: Global 				= Global.getInstance();
		private var xml					: XMLList;
		private var pagearray			: Array;
		private var page				: SubEmpty;
		private var lastitem			: Object;
		private var lastitemarray		: Array;
		private var h2padding			: Number				= 35;
		private var h3padding			: Number				= 15;
		private var linkbuttonpadding	: Number				= 15;
		private var plainpadding		: Number				= 0;
		private var scroll				: Scroll;
		private var Break				: Number;
		
		public function SubPlainText(pxml:XMLList) 
		{
			xml = pxml;
			pagearray = new Array();
			page = new SubEmpty();
			lastitemarray = new Array();
			lastitemarray.push({obj:null, type:null})
			this.addChild(page);
			init();
		}
		
		private function init()
		{
			
			for ( var i:Number = 0; i < xml.*.length(); i++ )
			{
				if (xml.*[i].name() == "plain")
				{
					var text : TextFieldCFT650px = new TextFieldCFT650px(xml.*[i]);
					page.contentMC.addChild(text);
					if (lastitemarray[lastitemarray.length - 1].obj != null)
					{
						if (lastitemarray[lastitemarray.length - 1].type == "h2")
						{
							if (lastitemarray[lastitemarray.length - 2].obj != null)
							{
								text.y = lastitemarray[lastitemarray.length - 2].obj.y + lastitemarray[lastitemarray.length - 2].obj.height + h2padding + Break;
							}else {
								text.y = 0;
							}
						}else {
							text.y = lastitemarray[lastitemarray.length - 1].obj.y + lastitemarray[lastitemarray.length - 1].obj.height + plainpadding + Break;
						}
					}else {
						text.y = 0;
					}
					
					if (lastitemarray[lastitemarray.length - 1].type == "linkbutton")
					{
						text.y = lastitemarray[lastitemarray.length - 1].obj.y + lastitemarray[lastitemarray.length - 1].obj.height + linkbuttonpadding + Break;
					}
					
					/*if (lastitemarray.length >= 1)
					{
						if (lastitemarray[lastitemarray.length - 1].type != "h2")
						{
							
						}
					}*/
					/*if (lastitem != null)
					{
						text.y = lastitem.y + lastitem.height + plainpadding + Break;
					}
					
					lastitem = text;*/
					
					lastitemarray.push( { obj : text , type : "plain" } );
					text.x = 240;
					
				}
				
				if (xml.*[i].name() == "h2")
				{
					var h2text : TextFieldAutoscape15px_220px = new TextFieldAutoscape15px_220px(xml.*[i]);//////
					page.contentMC.addChild(h2text);
					if (lastitemarray[lastitemarray.length - 1].obj != null)
					{
						h2text.y = lastitemarray[lastitemarray.length - 1].obj.y + lastitemarray[lastitemarray.length - 1].obj.height + h2padding + Break;
					}else {
						h2text.y = 0;
					}
					/*if (lastitem != null)
					{
						h2text.y = lastitem.y + lastitem.height + h2padding + Break;
					}
					lastitem = h2text;*/
					lastitemarray.push( { obj : h2text , type : "h2" } );
				}
				if (xml.*[i].name() == "h3")
				{
					var h3text : TextFieldAutoscape9px_650px = new TextFieldAutoscape9px_650px(xml.*[i]);
					page.contentMC.addChild(h3text);
					if (lastitemarray[lastitemarray.length - 1].obj != null)
					{
						if (lastitemarray[lastitemarray.length - 1].type == "h2")
						{
							if (lastitemarray[lastitemarray.length - 2].obj != null)
							{
								h3text.y = lastitemarray[lastitemarray.length - 2].obj.y + lastitemarray[lastitemarray.length - 2].obj.height + h2padding + Break;
							}else {
								h3text.y = 0;
							}
							
						}else {
							h3text.y = lastitemarray[lastitemarray.length - 1].obj.y + lastitemarray[lastitemarray.length - 1].obj.height + h3padding + Break;
						}
					}else
					{
						h3text.y = 0;
					}
					/*if (lastitem != null)
					{
						h3text.y = lastitem.y + lastitem.height + h3padding + Break;
					}
					lastitem = h3text;*/
					lastitemarray.push( { obj : h3text , type : "h3" } );
					h3text.x = 240;
				}
				
				trace(lastitemarray[lastitemarray.length-1].obj.width)
				
				Break = 0;
				
				if (xml.*[i].name() == "h2break")
				{
					Break = h2padding;
				}
				
				if (xml.*[i].name() == "linkbutton")
				{
					
					var linkbttn : TextFieldBttnCFT650px = new TextFieldBttnCFT650px(xml.*[i].label);
					linkbttn.src = xml.*[i].src;
					page.contentMC.addChild(linkbttn);
					if (lastitemarray[lastitemarray.length - 1].type == "h2")
					{
						linkbttn.y = lastitemarray[lastitemarray.length - 1].obj.y;
					}else {
						linkbttn.y = lastitemarray[lastitemarray.length - 1].obj.y + lastitemarray[lastitemarray.length - 1].obj.height + linkbuttonpadding + Break;
					}
					linkbttn.x = 240;
					linkbttn.bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
					linkbttn.bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
					linkbttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnDown);
					lastitemarray.push( { obj : linkbttn , type : "linkbutton" } );
					
				}
				
			}
			
			scroll = new Scroll(960, 346, global.stageHeight-366, page.contentMC, page.contentMC.y, 0);
			this.addChild(scroll);
			
			trace(page.contentMC.width)
			
		}
		
		private function bttnOver(e:MouseEvent)
		{
			//e.currentTarget.parent.bg.alpha = 0.2;
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0.2, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:180, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-9, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:5, time:1, transition:"easeOutExpo"} );
			
		}
		
		private function bttnOut(e:MouseEvent)
		{
			//e.currentTarget.parent.bg.alpha = 0;
			Tweener.addTween(e.currentTarget.parent.bg, { alpha:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:-14, time:1, transition:"easeOutExpo"} );
			Tweener.addTween(e.currentTarget.parent.arrow, { y:4, time:1, transition:"easeOutExpo"} );
		}
		
		private function bttnDown(e:MouseEvent)
		{
			trace(e.target.parent.src);
		}
		
	}
	
}