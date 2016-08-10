package cu.isomap3d.core
{
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.core.math.Number3D;
	import away3d.core.render.Renderer;
	import away3d.primitives.Trident;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;

	public class MainViewport extends UIViewport
	{
		private var _initialCameraPos:Number3D;
		private var _trident:Trident;
		
		public function get initialCameraPos():Number3D
		{
			return _initialCameraPos;
		}

		public function set initialCameraPos(value:Number3D):void
		{
			_initialCameraPos = value;
		}

		public function get trident():Trident
		{
			return _trident;
		}
		
		public function set trident(value:Trident):void
		{
			_trident = value;
		}
		
		public function MainViewport(viewportContainer:UIComponent)
		{
			super(viewportContainer);
			
			addEventListener(Event.ADDED_TO_STAGE, putTrident);
		}
		
		protected function putTrident(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, putTrident);
			
			trident = new Trident(10, true);
			trident.name = "trident";
			trident.y = 1;
			scene.addChild(trident);
			
			_initialCameraPos = new Number3D(300, 300, -300);
		}
		
		public function moveF():void
		{
			camera.pitch(-45);
			camera.moveForward(5);
			camera.pitch(45);
		}
		
		public function moveB():void
		{
			camera.pitch(-45);
			camera.moveBackward(5);
			camera.pitch(45);
		}
		public function moveL():void
		{
			camera.pitch(-45);
			camera.moveLeft(5);
			camera.pitch(45);
		}
		public function moveR():void
		{
			camera.pitch(-45);
			camera.moveRight(5);
			camera.pitch(45);
		}
		
		public function goTopView():void
		{
			camera.position = new Number3D(0, 500, 0);
			camera.lookAt(new Number3D(0, 0, 0));
			camera.rotationY += 135;
			initialCameraPos = new Number3D(0, 500, 0);
		}
		
		public function go3DView():void
		{
			camera.position = new Number3D(300, 300, -300);
			camera.lookAt(new Number3D(0, 0, 0));
			initialCameraPos = new Number3D(300, 300, -300);	
		}
	}
}