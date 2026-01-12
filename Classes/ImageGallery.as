package
{
	
	import com.canusta.data.*;
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import caurina.transitions.*
	import com.canusta.gui.*;
	import lt.uza.utils.*;
	
	public class ImageGallery extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var images				: Array;
		private var captions			: Array;
		private var owner				: Object;
		private var loadingCounter		: Number = 0;
		private var aligner				: Align;
		private var currentImage		: Object;
		private var direction			: String;
		
		public function ImageGallery(pimages:Array, pcaptions:Array, powner:Object) 
		{
			images = pimages;
			captions = pcaptions;
			owner = powner;
			aligner = new Align(global.univ);
			init();
		}
		
		private function init()
		{
			Tweener.addTween(backBTTN, { alpha:0.5, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(this, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(this, { alpha:1, time:1, transition:"easeOutExpo" } );
			disable(bttnL);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OVER, backBttnOver);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_OUT, backBttnOut);
			backBTTN.bttn.addEventListener(MouseEvent.MOUSE_DOWN, backBttnClicked);
			Tweener.addTween(bttnR, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(bttnL, { alpha:0, time:0, transition:"easeOutExpo" } );
			enable(bttnR);
			disable(bttnL)
			stageRebuild();
			startToLoad();
		}
		
		private function disable(target:MovieClip)
		{
			target.bttn.removeEventListener(MouseEvent.MOUSE_OVER, bttnOver);
			target.bttn.removeEventListener(MouseEvent.MOUSE_OUT, bttnOut);
			target.bttn.removeEventListener(MouseEvent.MOUSE_DOWN, bttnDown);
			Tweener.addTween(target, { alpha:0, time:1, transition:"easeOutExpo" } );
		}
		
		private function enable(target:MovieClip)
		{
			Tweener.addTween(target, { alpha:0.3, time:1, transition:"easeOutExpo" } );
			target.bttn.addEventListener(MouseEvent.MOUSE_OVER, bttnOver);
			target.bttn.addEventListener(MouseEvent.MOUSE_OUT, bttnOut);
			target.bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnDown);
		}
		
		private function bttnOver(e:MouseEvent)
		{
			Tweener.addTween(e.target.parent, { alpha:1, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.target.parent.arrow, { x:20, time:1, transition:"easeOutExpo" } );
			
		}
		
		private function bttnOut(e:MouseEvent)
		{
			Tweener.addTween(e.target.parent, { alpha:0.5, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.target.parent.arrow, { x:6, time:1, transition:"easeOutExpo" } );
		}
		
		private function bttnDown(e:MouseEvent)
		{
			
			var imageCount:Number = images.length;
			
			if (e.target.parent == bttnR)
			{
				loadingCounter++;
				direction = "R";
				enable(bttnL);
			}
			if (e.target.parent == bttnL)
			{
				loadingCounter--;
				direction = "L";
				enable(bttnR);
			}
			
			trace(loadingCounter)
			
			if (loadingCounter == imageCount-1)
			{
				disable(bttnR)
			}
			if (loadingCounter == 0)
			{
				disable(bttnL)
			}
			
			loadPresent();
			
		}
		
		private function startToLoad()
		{
			loadPresent();
		}
		
		private function loadPresent(e:Event = null)
		{
			var fileloader : FileLoader = new FileLoader(images[loadingCounter], loadingCounter, 0, 0);
			fileloader.addEventListener("fileloaded", imageLoaded);
			if (direction == "R")
			{
				if (currentImage)
					{
						Tweener.addTween(currentImage, { alpha:0, time:1, transition:"easeOutExpo" } );
						Tweener.addTween(currentImage, { x:currentImage.x-50, time:1, transition:"easeOutExpo" } );
					}
			}else
			{
				if (currentImage)
				{
					Tweener.addTween(currentImage, { alpha:0, time:1, transition:"easeOutExpo" } );
					Tweener.addTween(currentImage, { x:currentImage.x+50, time:1, transition:"easeOutExpo" } );
				}
			}
		}
		
		private function imageLoaded(e:Event = null):void
		{
			var image:Object = this.addChild(e.target.loader);
			aligner.arrange(image, owner, "no", "C", "no");
			aligner.arrange(image, global.univ, "yes", "M", "no");
			var imagex:Number = image.x;
			if (direction == "R")
			{
				Tweener.addTween(image, { alpha:0, time:0, transition:"easeOutExpo" } );
				Tweener.addTween(image, { alpha:1, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(image, { x:imagex+50, time:0, transition:"easeOutExpo" } );
				Tweener.addTween(image, { x:imagex, time:1, transition:"easeOutExpo" } );
				
			}else
			{
				Tweener.addTween(image, { alpha:0, time:0, transition:"easeOutExpo" } );
				Tweener.addTween(image, { alpha:1, time:1, transition:"easeOutExpo" } );
				Tweener.addTween(image, { x:imagex-50, time:0, transition:"easeOutExpo" } );
				Tweener.addTween(image, { x:imagex, time:1, transition:"easeOutExpo" } );
			}
			currentImage = image;
			
			var textx : int = imagex;
			var texty : int = image.height + image.y + 10;
			
			Tweener.addTween(capTXT, { x:textx, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(capTXT, { y:texty, time:1, transition:"easeOutExpo" } );
			
			capTXT.text = captions[loadingCounter];
		}
		
		private function backBttnOver(e:MouseEvent):void
		{
			e.currentTarget.parent.alpha = 1;
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:-90, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:3, time:1, transition:"easeOutExpo" } );
		}
		
		private function backBttnOut(e:MouseEvent)
		{
			e.currentTarget.parent.alpha = 0.5;
			Tweener.addTween(e.currentTarget.parent.arrow, { rotation:0, time:1, transition:"easeOutExpo" } );
			Tweener.addTween(e.currentTarget.parent.arrow, { x:15, time:1, transition:"easeOutExpo" } );
		}
		
		private function backBttnClicked(e:MouseEvent)
		{
			close();
		}
		
		public function close()
		{
			Tweener.addTween(this, { alpha:0, time:1, transition:"easeOutExpo", onComplete:unload } );
		}
		
		private function unload()
		{
			owner.removeChild(this);
		}
		
		private function stageRebuild()
		{
			aligner.arrange(bttnL, global.univ, "yes", "M", "no");
			aligner.arrange(bttnR, global.univ, "yes", "M", "no");
			aligner.arrange(ploader, global.univ, "yes", "M", "no");
		}
		
	}
	
}