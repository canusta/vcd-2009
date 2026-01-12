package com.canusta.data 
{
	
	public class Utils 
	{
		
		private static var array					: Array;
		private static var object					: Object;
		private static var result					: Array = new Array();
		private static var firstArray				: Number;
		private static var secondArray				: Number;
		
		public function Utils() 
		{
		}
		
		public static function MDArraySearch(parray:Array, pobject:Object)
		{
			//searchs an array for the object and returns the found Array
			result = null;
			array = parray;
			object = pobject;
			for (var i:Number = 0; i < array.length; i++)
			{
				if (array[i].indexOf(object) != -1)
				{
					result = array[i];
				}
			}
			
			return(result)
			
		}
		
		public static function MDArraySearchIN(parray:Array, pobject:Object)
		{
			//searchs an array for the object and returns the index number
			result = null;
			array = parray;
			object = pobject;
			for (var i:Number = 0; i < array.length; i++)
			{
				if (array[i].indexOf(object) != -1)
				{
					result[0] = i;
					result[1] = array[i].indexOf(object);
				}
			}
			
			return(result)
			
		}
		
		public static function tryit()
		{
			trace("it's OK.")
		}
		
	}
	
}