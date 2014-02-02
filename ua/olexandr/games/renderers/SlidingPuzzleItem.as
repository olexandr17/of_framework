﻿package ua.olexandr.games.renderers {
	import caurina.transitions.properties.FilterShortcuts;
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class SlidingPuzzleItem extends Sprite{
		
		private var _bitmap:Bitmap;
		
		private var _idHome:int;
		private var _idCurrent:int;
		
		/**
		 * 
		 * @param	$bitmap
		 * @param	$idHome
		 */
		public function SlidingPuzzleItem($bitmap:Bitmap, $idHome:int) {
			
			FilterShortcuts.init();
			
			_bitmap = $bitmap;
			addChild(_bitmap);
			
			_idHome = $idHome;
			
		}
		
		/**
		 * 
		 */
		public function over():void {
			if (parent) {
				parent.addChild(this);
				Tweener.removeTweens(_bitmap);
				Tweener.addTween(_bitmap, { _Glow_alpha:.75,
											_Glow_blurX:10,
											_Glow_blurY:10,
											_Glow_color:0xFFFFFF,
											_Glow_quality:2,
											time:.3 } );
			}
		}
		
		/**
		 * 
		 */
		public function out():void {
			if (parent) {
				Tweener.removeTweens(_bitmap);
				Tweener.addTween(_bitmap, { _Glow_alpha:0,
											_Glow_blurX:0,
											_Glow_blurY:0,
											_Glow_color:0xFFFFFF,
											_Glow_quality:2,
											time:.3 } );
			}
		}
		
		/**
		 * 
		 * @return
		 */
		public function inHome():Boolean {
			return _idHome == _idCurrent;
		}
		
		/**
		 * 
		 */
		public function get idHome():int { return _idHome; }
		
		/**
		 * 
		 */
		public function set idCurrent(value:int):void { _idCurrent = value; }
		/**
		 * 
		 */
		public function get idCurrent():int { return _idCurrent; }
		
	}

}