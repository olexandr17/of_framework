package ua.olexandr._ {
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	
	public class StringUtils {
		
		/**
		 * Converts the given string into a boolean.
		 * @param $string The string value to convert
		 * @return Boolean
		 */
		public static function stringToBoolean(str:String):Boolean {
			return (str.toLowerCase() == "true" || str.toLowerCase() == "1");
		}
		
		/**
		 * Counts the number of words in the given string.
		 *
		 * @param $string The string value to count the number of words in
		 *
		 * @return int
		 */
		public static function countWords($string:String):int {
			if ($string == null) {
				return 0;
			}
			
			return $string.match(/\b\w+\b/g).length;
		}
		
		/**
		 * Uses Regular Expressions to escape backslashes in the provided string.
		 * Without using this method, a backslash will be removed from the string
		 * because it is used to escape other characters.
		 *
		 * @param $string The string to escape slashes in
		 *
		 * <pre>
		 * 		trace(StringUtils.escapeBackslashes("this is \ the way to do it")); // traces "this is \ the way to do it"
		 * </pre>
		 *
		 * @return String
		 */
		public static function escapeBackslashes($string:String):String {
			return $string.replace(/\\/g, "\\\\");
		}
		
		/**
		 * Uses Regular Expressions to trim beginning and trailing white space.
		 *
		 * @param $string The string to trim white space in
		 *
		 * @return String
		 */
		public static function trimWhitespace($string:String):String {
			if ($string == null) {
				return "";
			}
			
			return $string.replace(/^\s+|\s+$/g, "");
		}
		
		/**
		 * Unescapes html entities.
		 *
		 * <pre>
		 * 		trace(htmlUnescape("ham &amp; eggs")); // traces ham & eggs
		 * </pre>
		 *
		 * @param $str The string to unescape
		 *
		 * @return String
		 */
		public static function htmlUnescape($str:String):String {
			return new XMLDocument($str).firstChild.nodeValue;
		}
		
		/**
		 * Escapes html entities.
		 *
		 * <pre>
		 * 		trace(htmlEscape("ham & eggs")); // traces ham &amp; eggs
		 * </pre>
		 *
		 * @param $str The string to escape
		 *
		 * @return String
		 */
		public static function htmlEscape($str:String):String {
			return XML(new XMLNode(XMLNodeType.TEXT_NODE, $str)).toXMLString();
		}
		
		/**
		 * Converts all XML tags to lowercase
		 *
		 * <pre>
		 * 		var x:XML = xmlTagsToLowerCase(new XML("<A C='D'><B>test</B></A>"));
		 * 		trace(x); // Output: <a c="D"><b>test</b></a>
		 * </pre>
		 *
		 * @param $xml The XML to convert
		 *
		 * @return XML
		 */
		public static function xmlTagsToLowerCase($xml:XML):XML {
			// convert the root tag to lowercase
			$xml.setName($xml.name().toString().toLowerCase());
			
			for each (var attribute:XML in $xml.@*) {
				attribute.setName(attribute.name().toString().toLowerCase());
			}
			
			// convert all descendant tags to lowercase
			for each (var child:XML in $xml..*) {
				// if the node is an element...
				if (child.nodeKind() == "element") {
					// ...change its name to lowercase.
					child.setName(child.name().toString().toLowerCase());
					
					// if the node has any attributes, change their names to lowercase.
					for each (attribute in child.@*) {
						attribute.setName(attribute.name().toString().toLowerCase());
					}
				}
			}
			
			return $xml;
		}
	
	}
}