package cu.isomap3d.core
{
	import away3d.events.MouseEvent3D;
	import away3d.materials.BitmapFileMaterial;
	import away3d.primitives.Plane;
	
	import flash.events.Event;

	public class Surface extends Plane
	{	
		private var _textureUrl:String;
		private var _map:GridMap;
		
		public function get textureUrl():String
		{
			return _textureUrl;
		}
		
		public function set textureUrl(value:String):void
		{
			_textureUrl = value;
		}
		
		public function get map():GridMap
		{
			return _map;
		}
		
		public function set map(value:GridMap):void
		{
			_map = value;
		}
		
		public function Surface(textureUrl:String, X:Number, Z:Number, rotationY:Number, map:GridMap)
		{
			super({x:X, z:Z, rotationY:rotationY, width:10, height:10, segmentsW:1, segmentsH:1, material:new BitmapFileMaterial(textureUrl), ownCanvas:true});
			addOnMouseOver(mouseOverHandler);
			addOnMouseOut(mouseOutHandler);
			addOnMouseDown(mouseDownHandler);
			_map = map;
			_textureUrl = textureUrl;
			_map.current = this;
		}

		private function mouseOverHandler(event:MouseEvent3D):void
		{
			alpha = .5;
		}
		
		private function mouseOutHandler(event:MouseEvent3D):void
		{
			alpha = 1;
		}
		
		private function mouseDownHandler(event:MouseEvent3D):void
		{
			_map.current = this;
			var e:Event = new Event("objClick");
			_map.dispatchEvent(e);
		}
	}
}