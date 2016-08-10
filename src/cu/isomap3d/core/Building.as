package cu.isomap3d.core
{
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Mesh;
	import away3d.core.base.Object3D;
	import away3d.events.MouseEvent3D;
	import away3d.loaders.Loader3D;
	import away3d.loaders.Max3DS;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Building extends ObjectContainer3D
	{
		private var _map:GridMap;
		private var _loader:Loader3D;
		private var _modelUrl:String;
		private var _X:Number;
		private var _Z:Number;
		private var _rotationY:Number;
		
		public function get modelUrl():String
		{
			return _modelUrl;
		}
		
		public function set modelUrl(value:String):void
		{
			_modelUrl = value;
		}
		
		public function Building(modelUrl:String, X:Number, Z:Number, rotationY:Number, map:GridMap)
		{
			super({ownCanvas:true, visible:false});
			_modelUrl = modelUrl;
			_X = X;
			_Z = Z;
			_rotationY = rotationY;
			_map = map;
			_loader = Max3DS.load(modelUrl);
			_loader.addOnSuccess(loadModelComplete);
		}

		private function mouseOverHandler(event:MouseEvent3D):void
		{
			(event.object.parent.parent as Object3D).alpha = .5;
		}
		
		private function mouseOutHandler(event:MouseEvent3D):void
		{
			(event.object.parent.parent as Object3D).alpha = 1;
		}
		
		private function mouseDownHandler(event:MouseEvent3D):void
		{
			_map.current = this;
			var e:Event = new Event("objClick");
			_map.dispatchEvent(e);
		}
		
		private function loadModelComplete(e:Event):void
		{
			x = _X;
			z = _Z;
			rotationY = _rotationY;	
			addOnMouseDown(mouseDownHandler);
			addOnMouseOver(mouseOverHandler);
			addOnMouseOut(mouseOutHandler);
			ownCanvas = true;
			this.addChild(_loader.handle as Object3D);
			this.visible = true;
			_map.current = this;
		}
		
	}
}