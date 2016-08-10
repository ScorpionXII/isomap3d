package cu.isomap3d.core
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.clip.FrustumClipping;
	import away3d.core.clip.RectangleClipping;
	import away3d.core.geom.Plane3D;
	import away3d.core.math.MatrixAway3D;
	import away3d.core.math.Number3D;
	import away3d.core.render.IRenderer;
	import away3d.core.render.Renderer;
	import away3d.primitives.Cube;
	
	import flash.events.Event;
	import flash.text.engine.RenderingMode;
	
	import mx.core.UIComponent;

	public class UIViewport extends UIComponent
	{
		private var _viewportContainer:UIComponent;
		
		private var _view:View3D;
		
		private var _scene:Scene3D;
		
		private var _camera:Camera3D;
		
		private var _cameraContainer:ObjectContainer3D;

		public function get cameraContainer():ObjectContainer3D
		{
			return _cameraContainer;
		}
		
		public function set cameraContainer(value:ObjectContainer3D):void
		{
			_cameraContainer = value;
		}
		
		public function get camera():Camera3D
		{
			return _camera;
		}
		
		public function set camera(value:Camera3D):void
		{
			_camera = value;
		}
		
		public function get scene():Scene3D
		{
			return _scene;
		}
		
		public function set scene(value:Scene3D):void
		{
			_scene = value;
		}
		
		public function get view():View3D
		{
			return _view;
		}
		
		public function set view(value:View3D):void
		{
			_view = value;
		}
		
		public function get viewportContainer():UIComponent
		{
			return _viewportContainer;
		}
		
		public function set viewportContainer(value:UIComponent):void
		{
			_viewportContainer = value;
		}

		public function UIViewport(viewportContainer:UIComponent):void
		{
			super();
			this.viewportContainer = viewportContainer;
			addEventListener(Event.ADDED_TO_STAGE, viewportConfig, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, viewportReleaseHandlers, false, 0, true);
		}
		
		protected function viewportConfig(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, viewportConfig);
			
			// crear la escena
			scene = new Scene3D();
			
			// cofigurar contenedor de camara
			cameraContainer = new ObjectContainer3D("cameraContainer");
			scene.addChild(cameraContainer);
			cameraContainer.mouseEnabled = false;
			
			// setear parametros de camara
			camera = new Camera3D({zoom:50});
			camera.position = new Number3D(300, 300, -300);
			
			//scene.addChild(camera);
			cameraContainer.addChild(camera);
			camera.lookAt(new Number3D(0, 0, 0));
			
			view = new View3D();
			view.camera = camera;
			view.scene = scene;
			
			//calculate view position and bounds INCLUDING CLIPPING
			viewPositionAndBounds();
				
			this.addChild(view);
			
			addEventListener(Event.ENTER_FRAME, viewportRender);
		}
		
		public function viewPositionAndBounds():void
		{
			view.x = Math.round(viewportContainer.width/2);
			view.y = Math.round(viewportContainer.height/2);
			
			var bottomBound:Number;
			var rightBound:Number;
			
			(viewportContainer.width%2 == 0) ? rightBound = view.x - 2 : rightBound = view.x - 2;
			(viewportContainer.height%2 == 0) ? bottomBound = view.y - 2 : bottomBound = view.y - 3;
			
			view.clipping = new RectangleClipping({minX:-view.x, minY:-view.y, maxX:rightBound, maxY:bottomBound});
		}
		
		protected function viewportRender(event:Event):void
		{
			view.render();
		}
		
		public function viewportReleaseHandlers(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, viewportReleaseHandlers);
			removeEventListener(Event.ENTER_FRAME, viewportRender);
		}
		
	}
}