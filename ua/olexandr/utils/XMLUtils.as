﻿package ua.olexandr.utils {
	import ua.olexandr.debug.Logger;
	
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class XMLUtils {
		
		/**
		 * 
		 * @param	data
		 * @return
		 */
		public static function parse(data:String):XML {
			var _data:XML;
			
			try {
				_data = new XML(data);
			} catch (e:Error) {
				Logger.error(e.message);
				return null;
			}
			
			return _data;
		}		
		
		/**
		 * 
		 * @param	$list
		 * @param	$oldIndex
		 * @param	$newIndex
		 */
		public static function swapIndex($list:XMLList, $oldIndex:int, $newIndex:int):void {
			var parent:XML = $list.parent();
			var nodeM:XML = $list[$oldIndex];
			var nodeB:XML = $list[$newIndex + ($oldIndex < $newIndex)];
			removeNode($list, nodeM.childIndex());
			parent.insertChildBefore(nodeB, nodeM);
		}
		
		/**
		 * 
		 * @param	$list
		 * @param	$index
		 */
		public static function removeNode($list:XMLList, $index:int):void {
			var node:XML = $list[$index];
			delete node.parent().elements()[node.childIndex()]
		}
		
		/**
		 * 
		 * @param	$list
		 * @param	$attribute
		 * @return
		 */
		public static function parseList($list:XMLList, $attribute:String = null):Array {
			var _arr:Array = [];
			var _len:int = $list.length();
			for (var i:int = 0; i < _len; i++) {
				if ($attribute) {
					if ($list[i].hasOwnProperty($attribute))
						_arr.push($list[i][$attribute]);
				} else {
					if ($list[i].text())
						_arr.push($list[i].text());
				}
			}
			return _arr;
		}
		
		/**
		 * 
		 * @param	data
		 * @return
		 */
		public static function removeNamespace(data:XML):XML {
			var _reg1:RegExp = /\s*xmlns[^\'\"]*=[\'\"][^\'\"]*[\'\"]/gi;
			var _reg2:RegExp = /<[\/]{0,1}(\w+:).*?>/i;
			
			var _str:String = data.toString().replace(_reg1, '');
			
			while (_reg2.test(_str))
				_str = _str.replace(_reg2.exec(_str)[1], '');
			
			return XML(_str);
		}
		
		/**
		 * 
		 * @param	$data
		 * @return
		 */
		private static function removeFromAttributes($data:XML):String {
			var ret:String = '';
			$data.@*.(ret += localName() + '=\"' + toXMLString() + '\" ');
			return ret;
		}
		
		/**
		 * 
		 * @param	$list
		 * @param	$attribute 	Имя аттрибута без заглавного "@"
		 * @param	$options	Константа Array.
		 * @return
		 */
		public static function sortByAttribute($list:XMLList, $attribute:String, $options:* = 0):XMLList {
			var _arr:Array = [];
			
			for each (var item:XML in $list) {
				_arr.push( { data: item, order: item.attribute($attribute) } );
			}
			_arr.sortOn('order', $options);
			
			var _list:XMLList = new XMLList();
			var _len:int = _arr.length;
			
			for (var i:int = 0; i < _len; i++)
				_list[i] = _arr[i].data;
			
			return _list.copy();
		}
		
		/**
		 * 
		 * @param	data
		 * @param	count
		 * @return
		 */
		public static function getSiblingByIndex(data:XML, count:int):XML {
			var out:XML;
			
			try {
				out = data.parent().children()[data.childIndex() + count];
			} catch (e:Error) {
				return null;
			}
			
			return out;
		}
	
	}
}

