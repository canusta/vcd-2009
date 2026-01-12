package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	import com.canusta.data.*;
	import com.canusta.gui.*;
	import caurina.transitions.*;
	import lt.uza.utils.*;
	
	public class PagePublications extends MovieClip
	{
		
		private var global				: Global = Global.getInstance();
		private var univ				: VcdTwoThousandAndNine;
		private var database			: Database;
		private var scroll				: Scroll;
		private var images				: Array;
		private var captions			: Array;
		private var itemImages			: Array;
		private var imagex				: Number = 0;
		private var contentx			: Number = 235;
		private var currentheight		: Number = 0;
		private var padding				: Number = 25;
		private var textPadding			: Number = 0;
		private var preloaderindex		: Array;
		
		public function PagePublications(pdatabase : Database, puniv : VcdTwoThousandAndNine) 
		{
			
			database = pdatabase;
			univ = puniv;
			images = new Array();
			captions = new Array();
			itemImages = new Array();
			preloaderindex = new Array();
			
			init();
		}
		
		private function init()
		{
			var currentblockitem : Object;
			for (var i:Number = 0; i < database.data.item.length(); i++ )
			{
				
				//// Image Loader
				var imagepreloader : PloaderBar = new PloaderBar();
				contentMC.addChild(imagepreloader);
				imagepreloader.y = currentheight + 1;
				imagepreloader.x = 73;
				preloaderindex.push(imagepreloader);
				
				//// Image
				var imagey : Number = currentheight;
				images[i] = new Array();
				captions[i] = new Array();
				for ( var iiii : Number = 1; iiii < database.data.item[i].images.image.length(); iiii++ )
				{
					images[i].push(database.data.item[i].images.image[iiii]);
					captions[i].push(database.data.item[i].images.image[iiii].@cap);
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
				for (var ii:Number = 0; ii < database.data.item[i].block1.*.length(); ii++)
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
				}
				
				//// Block 2
				var block2content : TextFieldCFT650px = new TextFieldCFT650px(database.data.item[i].block2);
				contentMC.addChild(block2content);
				block2content.x = contentx;
				block2content.y = currentblockitem.y + currentblockitem.height + padding;
				currentblockitem = block2content;
				
				//// Block 3
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
				}
	
				currentheight = currentblockitem.y + currentblockitem.height + padding;
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
			var imageBttn : PublicationImageBttn = new PublicationImageBttn(e.target._id, this, image);
			imageBttn.bttn.addEventListener(MouseEvent.MOUSE_DOWN, bttnClicked);
			contentMC.addChild(imageBttn);
			imageBttn.bttn.height = image.height + 80;
			imageBttn.bttnGraph.y = image.height + 35;
			Tweener.addTween(imageBttn, { alpha:0, time:0, transition:"easeOutExpo" } );
			Tweener.addTween(imageBttn, { alpha:1, time:1, transition:"easeOutExpo" } );
			imageBttn.y = e.target._filey;
			
			scroll.rebuildScroll();
			
		}
		
		private function bttnClicked(e:MouseEvent)
		{
			var imageGallery : ImageGallery = new ImageGallery(images[e.target.parent._id], captions[e.target.parent._id], this);
			this.addChild(imageGallery);
		}
		
	}
	
}