package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	import com.canusta.data.*;
	import com.canusta.gui.*;
	import caurina.transitions.*;
	import flash.ui.Mouse;
	import lt.uza.utils.*;
	
	public class PageExhibitionAndFestivals extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var univ				: VcdTwoThousandAndNine;
		private var database			: Database;
		private var scroll				: Scroll;
		private var images				: Array;
		private var itemImages			: Array;
		private var imagex				: Number = 0;
		private var contentx			: Number = 235;
		private var currentheight		: Number = 0;
		private var padding				: Number = 25;
		private var textPadding			: Number = 0;
		private var previousHeight		: Number = 0;
		private var preloaderindex		: Array;
		
		public function PageExhibitionAndFestivals(pdatabase : Database, puniv : VcdTwoThousandAndNine) 
		{
			
			database = pdatabase;
			trace(database.data)
			univ = puniv;
			images = new Array();
			itemImages = new Array();
			preloaderindex = new Array();
			
			init();
			
		}
		
		private function init()
		{
			
			var currentblockitem : Object;
			
			for (var i:Number = 0; i < database.data.item.length(); i++ )
			{
				
				var o : int;
				var p : int = database.data.item.length() - 1;
				
				if (i >= 1)
				{
					o = i - 1;
				}else {
					o = i;
				}
				
				if (currentheight >= 1 && database.data.item[o].makingof.video != "")
				{
					currentheight = currentheight + 15;
				}
				
				//// Image Loader
				var imagepreloader : PloaderBar = new PloaderBar();
				contentMC.addChild(imagepreloader);
				imagepreloader.y = currentheight + 1;
				imagepreloader.x = 73;
				preloaderindex.push(imagepreloader);
				
				//// Image
				var imagey : Number = currentheight;
				images[i] = new Array();
				for ( var iiii : Number = 1; iiii < database.data.item[i].images.image.length(); iiii++ )
				{
					images[i].push(database.data.item[i].images.image[iiii]);
				}
				var fileloader : FileLoader = new FileLoader(database.data.item[i].images.image[0], i, imagex, imagey);
				fileloader.addEventListener("fileloaded", showImage);
				
				//// Title
				var bookTitle : TextFieldAutoscape15px = new TextFieldAutoscape15px(database.data.item[i].name);
				currentblockitem = bookTitle;
				contentMC.addChild(bookTitle);
				bookTitle.x = contentx;
				bookTitle.y = currentheight;
				
				//// Block 1
				/*for (var ii:Number = 0; ii < database.data.item[i].block1.*.length(); ii++)
				{
					var block1item : TextFieldAutoscape9pxNowidth = new TextFieldAutoscape9pxNowidth(database.data.item[i].block1.*[ii].@content);
					var block1content : TextFieldCFT650px = new TextFieldCFT650px(database.data.item[i].block1.*[ii]);
					contentMC.addChild(block1item);
					contentMC.addChild(block1content);
					block1item.x = contentx;
					block1item.y = currentblockitem.y + currentblockitem.height + textPadding;
					if (currentblockitem == bookTitle)
					{
						block1item.y = block1item.y + 25;
					}
					currentblockitem = block1item;
					block1content.x = contentx;
					block1content.y = currentblockitem.y + currentblockitem.height + textPadding;
					currentblockitem = block1content;
				}*/
				
				//// Description
				var block2content : TextFieldCFT650px = new TextFieldCFT650px(database.data.item[i].description);
				contentMC.addChild(block2content);
				block2content.x = contentx;
				block2content.y = currentblockitem.y + currentblockitem.height + padding;
				currentblockitem = block2content;
				
				/*//// Block 3
				for (var iii:Number = 0; iii < database.data.item[i].block3.*.length(); iii++)
				{
					var block3item : TextFieldAutoscape9pxNowidth = new TextFieldAutoscape9pxNowidth(database.data.item[i].block3.*[iii].@content);
					var block3content : TextFieldCFT650px = new TextFieldCFT650px(database.data.item[i].block3.*[iii]);
					contentMC.addChild(block3item);
					contentMC.addChild(block3content);
					block3item.x = contentx;
					block3item.y = currentblockitem.y + currentblockitem.height + textPadding;
					if (currentblockitem == block2content)
					{
						block3item.y = block3item.y + padding;
					}
					currentblockitem = block3item;
					block3content.x = contentx;
					block3content.y = currentblockitem.y + currentblockitem.height + textPadding;
					currentblockitem = block3content;
				}*/
				
				previousHeight = database.data.item[i].images.image[0].@height;
				currentheight = previousHeight + currentheight;
				currentheight = currentheight + 83;
				previousHeight = currentheight;
			}
			
			scroll = new Scroll(960, 346, global.stageHeight-366, contentMC, contentMC.y, 0);
			addChild(scroll);
		}
		
		private function showImage(e:Event)
		{
			
			//// Remove preloader
			contentMC.removeChild(preloaderindex[e.target._id]);
			
			//// Image
			var image:Object = contentMC.addChild(e.target.loader);
			Tweener.addTween(image, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(image, { alpha:1, time:1, transition:"easeOutExpo" } );
			image.y = e.target._filey;
			
			//// Button
			var imageBttn : EafImageBttn = new EafImageBttn(e.target._id, this, image);
			imageBttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnClicked);
			contentMC.addChild(imageBttn);
			imageBttn.bttn.height = image.height + 50;
			imageBttn.bttnGraph.y = image.height + 35;
			Tweener.addTween(imageBttn, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(imageBttn, { alpha:1, time:1, transition:"easeOutExpo" } );
			imageBttn.y = e.target._filey;
			if (database.data.item[e.target._id].makingof.video != "")
			{
				imageBttn.videoBttn.y = image.height + 48;
				Tweener.addTween(imageBttn.videoBttn, { alpha:0.5, time:1, transition:"easeOutExpo" } );
				imageBttn.videoBttn.videosrc = database.data.item[e.target._id].makingof.video;
				imageBttn.videoBttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, openVideo);
			}else {
				Tweener.addTween(imageBttn.videoBttn, { alpha:0, time:1, transition:"easeOutExpo" } );
			}
			
			scroll.rebuildScroll();
			
		}
		
		private function openVideo(e:MouseEvent)
		{
			trace("++++")
			trace(e.target.parent.videosrc)
			var videoPlayer : VideoPlayer = new VideoPlayer("Movies/"+e.target.parent.videosrc, this);
			addChild(videoPlayer);
		}
		
		private function bttnClicked(e:MouseEvent)
		{
			var imageGallery : ImageGallery = new ImageGallery(images[e.target.parent._id], images[e.target.parent._id],this);
			this.addChild(imageGallery);
		}
		
	}
	
}