package ua.olexandr.ui.components.forRemove {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import ua.olexandr.ui.Style;
	
	public class Meter extends Component {
		protected var _damp:Number = .8;
		protected var _dial:Sprite;
		protected var _label:Label;
		protected var _labelText:String;
		protected var _maximum:Number = 1.0;
		protected var _maxLabel:Label;
		protected var _minimum:Number = 0.0;
		protected var _minLabel:Label;
		protected var _needle:Sprite;
		protected var _needleMask:Sprite;
		protected var _showValues:Boolean = true;
		protected var _targetRotation:Number = 0;
		protected var _value:Number = 0.0;
		protected var _velocity:Number = 0;
		
		public function Meter(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, text:String = "") {
			_labelText = text;
			super(parent, xpos, ypos);
		}
		
		public override function draw():void {
			var startAngle:Number = -140 * Math.PI / 180;
			var endAngle:Number = -40 * Math.PI / 180;
			
			drawBackground();
			drawDial(startAngle, endAngle);
			drawTicks(startAngle, endAngle);
			drawNeedle();
			
			_minLabel.move(10, _height - _minLabel.height - 4);
			_maxLabel.move(_width - _maxLabel.width - 10, _height - _maxLabel.height - 4);
			_label.move((_width - _label.width) / 2, _height * .5);
			update();
		}
		
		public override function setSize(w:Number, h:Number):void {
			h = w / 2;
			super.setSize(w, h);
		}
		
		public function set maximum(value:Number):void {
			_maximum = value;
			_maxLabel.text = _maximum.toString();
			update();
		}
		
		public function get maximum():Number {
			return _maximum;
		}
		
		public function set minimum(value:Number):void {
			_minimum = value;
			_minLabel.text = _minimum.toString();
			update();
		}
		
		public function get minimum():Number {
			return _minimum;
		}
		
		public function set value(val:Number):void {
			_value = val;
			update();
		}
		
		public function get value():Number {
			return _value;
		}
		
		public function set label(value:String):void {
			_labelText = value;
			_label.text = _labelText;
		}
		
		public function get label():String {
			return _labelText;
		}
		
		public function set showValues(value:Boolean):void {
			_showValues = value;
			_minLabel.visible = _showValues;
			_maxLabel.visible = _showValues;
		}
		
		public function get showValues():Boolean {
			return _showValues;
		}
		
		public function set damp(value:Number):void {
			_damp = value;
		}
		
		public function get damp():Number {
			return _damp;
		}
	
		
		protected override function init():void {
			super.init();
			_width = 200;
			_height = 100;
		}
		
		protected override function addChildren():void {
			_dial = new Sprite();
			addChild(_dial);
			
			_needle = new Sprite();
			_needle.rotation = -50;
			_dial.addChild(_needle);
			
			_needleMask = new Sprite();
			addChild(_needleMask);
			_dial.mask = _needleMask;
			
			_minLabel = new Label(this);
			_minLabel.text = _minimum.toString();
			
			_maxLabel = new Label(this);
			_maxLabel.autoSize = true;
			_maxLabel.text = _maximum.toString();
			
			_label = new Label(this);
			_label.text = _labelText;
		}
		
		protected function drawBackground():void {
			graphics.clear();
			graphics.beginFill(Style.BACKGROUND);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			graphics.beginFill(Style.PANEL);
			graphics.drawRect(1, 1, _width - 2, _height - 2);
			graphics.endFill();
		}
		
		protected function drawDial(startAngle:Number, endAngle:Number):void {
			_dial.x = _width / 2;
			_dial.y = _height * 1.25;
			_dial.graphics.clear();
			_dial.graphics.lineStyle(0, Style.BACKGROUND);
			_dial.graphics.beginFill(Style.BUTTON_FACE);
			var r1:Number = _height * 1.05;
			var r2:Number = _height * 0.96;
			
			_dial.graphics.moveTo(Math.cos(startAngle) * r1, Math.sin(startAngle) * r1);
			for (var i:Number = startAngle; i < endAngle; i += .1) {
				_dial.graphics.lineTo(Math.cos(i) * r1, Math.sin(i) * r1);
			}
			_dial.graphics.lineTo(Math.cos(endAngle) * r1, Math.sin(endAngle) * r1);
			
			_dial.graphics.lineTo(Math.cos(endAngle) * r2, Math.sin(endAngle) * r2);
			for (i = endAngle; i > startAngle; i -= .1) {
				_dial.graphics.lineTo(Math.cos(i) * r2, Math.sin(i) * r2);
			}
			_dial.graphics.lineTo(Math.cos(startAngle) * r2, Math.sin(startAngle) * r2);
			_dial.graphics.lineTo(Math.cos(startAngle) * r1, Math.sin(startAngle) * r1);
		
		}
		
		protected function drawTicks(startAngle:Number, endAngle:Number):void {
			var r1:Number = _height * 1.05;
			var r2:Number = _height * 0.96;
			var r3:Number = _height * 1.13;
			var tick:Number = 0;
			for (var i:int = 0; i < 9; i++) {
				var angle:Number = startAngle + i * (endAngle - startAngle) / 8;
				_dial.graphics.moveTo(Math.cos(angle) * r2, Math.sin(angle) * r2);
				if (tick++ % 2 == 0) {
					_dial.graphics.lineTo(Math.cos(angle) * r3, Math.sin(angle) * r3);
				} else {
					_dial.graphics.lineTo(Math.cos(angle) * r1, Math.sin(angle) * r1);
				}
			}
		}
		
		protected function drawNeedle():void {
			_needle.graphics.clear();
			_needle.graphics.beginFill(0xff0000);
			_needle.graphics.drawRect(-0.5, -_height * 1.10, 1, _height * 1.10);
			_needle.filters = [new DropShadowFilter(4, 0, 0, 1, 3, 3, .2)];
			
			_needleMask.graphics.clear();
			_needleMask.graphics.beginFill(0);
			_needleMask.graphics.drawRect(0, 0, _width, _height);
			_needleMask.graphics.endFill();
		}
		
		protected function update():void {
			_value = Math.max(_value, _minimum);
			_value = Math.min(_value, _maximum);
			_targetRotation = -50 + (_value - _minimum) / (_maximum - _minimum) * 100;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void {
			var dist:Number = _targetRotation - _needle.rotation;
			_velocity += dist * .05;
			_velocity *= _damp;
			if (Math.abs(_velocity) < .1 && Math.abs(dist) < .1) {
				_needle.rotation = _targetRotation;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			} else {
				_needle.rotation += _velocity;
			}
		}
		
	}
}