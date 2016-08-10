package cu.isomap3d.components
{
	import flash.events.Event;
	
	public class ControlEvent extends Event
	{
		private var _value:Number;
		
		public function get value():Number
		{
			return _value;
		}
		
		public function ControlEvent(type:String, value:Number)
		{
			super(type);
			_value = value;
		}

	}
}