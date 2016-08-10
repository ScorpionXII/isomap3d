package cu.isomap3d.core
{
	import away3d.core.base.Object3D;
	import away3d.core.math.Number3D;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;

	public class PreviewViewport extends UIViewport
	{
		private var _object:Object3D;

		public function get object():Object3D
		{
			return _object;
		}

		public function set object(value:Object3D):void
		{
			if(_object!=null)
				scene.removeChildByName("preview");
			
			_object = value;
			object.name = "preview";
			scene.addChild(object);
		}

		public function PreviewViewport(viewportContainer:UIComponent)
		{
			super(viewportContainer);
			addEventListener(Event.ADDED_TO_STAGE, modifySettings, false, 0, true);
		}
		
		protected function modifySettings(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, viewportConfig);
			camera.position = new Number3D(50, 55, -50);
			camera.zoom = 15;
		}
		
		override protected function viewportRender(event:Event):void
		{
			if (object!=null)
				scene.getChildByName("preview").rotationY++;
			
			view.render();
		}
	}
}