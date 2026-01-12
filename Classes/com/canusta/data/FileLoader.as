package com.canusta.data 
{
	
	import flash.events.EventDispatcher;
	import com.canusta.data.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.display.*;
	
	public class FileLoader extends EventDispatcher
	{
		
		private var filesrc				: String;
		private var fileextensions		: Array;
		private var filetypes			: Array;
		private var targetFileExtension	: String;
		public var loader				: Loader;
		private var request				: URLRequest;
		private var id					: Number;
		private var filex				: Number;
		private var filey				: Number;
		
		public function FileLoader(pfilesrc:String, pid:Number, pfilex:Number, pfiley:Number)
		{
			filesrc = pfilesrc;
			id = pid;
			filex = pfilex;
			filey = pfiley;
			//fileextensions = new Array(
			//							new Array("jpeg", "jpg", "png", "gif")
			//						)
			//filetypes = new Array ("image");
			loader = new Loader();
			request = new URLRequest(filesrc);
			init();
		}
		
		private function init()
		{
			//getFileType();
			loadImage();
		}
		
		private function getFileType()
		{
			//filesrc.search("deneme")
			//Utils.MDArraySearchIN(fileextensions, targetFileExtension);
		}
		
		private function loadImage()
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(request);
		}
		
		private function onComplete(e:Event = null)
		{
			dispatchEvent(new Event("fileloaded"));
		}
		
		public function get _filex():Number{
			return filex;
		}
		
		public function get _filey():Number{
			return filey;
		}
		
		public function get _id():Number{
			return id;
		}
		
	}
	
}