package ua.olexandr.data {
	
	/**
	 * ...
	 * @author gka
	 */
	public class TSVParser {
		
		/**
		 * 
		 * @param	raw
		 * @return
		 */
		public static function parse(raw:String):Array {
			var lines:Array = raw.split("\n");
			var data:Array = [];
			for each (var line:String in lines) {
				if (line != '')
					data.push(line.split("\t"));
			}
			
			return data;
		}
	
	}

}