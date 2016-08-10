package cu.isomap3d.core
{
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Object3D;
	import away3d.events.MouseEvent3D;
	import away3d.loaders.Loader3D;
	import away3d.loaders.Max3DS;
	import away3d.materials.BitmapFileMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cube;
	import away3d.primitives.GridPlane;
	import away3d.primitives.Plane;
	import away3d.primitives.WirePlane;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	public class GridMap extends ObjectContainer3D
	{
		private var _building:Building;
		private var _surface:Surface;
		private var _creationState:String = "Surfaces";
		private var _cursor:Plane;
		private var _basePlane:Plane;
		private var _current:Object3D;
		private var _X:Number = 0;
		private var _Z:Number = 0;
		private var _texture:String = "";
		private var _model:String = "";
		private var _loader:Loader3D;
		private var _surfacesArray:ArrayCollection = new ArrayCollection();
		private var _buildingsArray:ArrayCollection = new ArrayCollection();

		public function get creationState():String
		{
			return _creationState;
		}

		public function set creationState(value:String):void
		{
			_creationState = value;
		}

		public function get model():String
		{
			return _model;
		}

		public function set model(value:String):void
		{
			_model = value;
		}

		public function get texture():String
		{
			return _texture;
		}

		public function set texture(value:String):void
		{
			_texture = value;
		}

		public function get Z():Number
		{
			return _Z;
		}

		public function set Z(value:Number):void
		{
			_Z = value;
		}

		public function get X():Number
		{
			return _X;
		}

		public function set X(value:Number):void
		{
			_X = value;
		}

		public function get current():Object3D
		{
			return _current;
		}

		public function set current(value:Object3D):void
		{
			_current = value;
		}

		public function get basePlane():Plane
		{
			return _basePlane;
		}

		public function set basePlane(value:Plane):void
		{
			_basePlane = value;
		}

		public function get cursor():Plane
		{
			return _cursor;
		}

		public function set cursor(value:Plane):void
		{
			_cursor = value;
		}
		
		public function get surfacesArray():ArrayCollection
		{
			return _surfacesArray;
		}
		
		public function set surfacesArray(value:ArrayCollection):void
		{
			_surfacesArray = value;
		}
		
		public function get buildingsArray():ArrayCollection
		{
			return _buildingsArray;
		}
		
		public function set buildingsArray(value:ArrayCollection):void
		{
			_buildingsArray = value;
		}

		public function GridMap():void
		{	
			basePlane = new Plane({width:250, height:250, segmentsH:4, segmentsW:4, y:-.1, material:new ColorMaterial(0xffffff), ownCanvas:true, pushback:true, alpha:.05});
			basePlane.addOnMouseMove(coordsTrans);
			basePlane.addOnMouseDown(basePlaneMouseDown);
			this.addChild(basePlane);
			
			//cursor = new Plane({width:10, height:10, material: new ColorMaterial(0xff0000), alpha:0.5, ownCanvas:true});
			//cursor.mouseEnabled = false;
			//this.addChild(cursor);
		}
		
		private function coordsTrans(event:MouseEvent3D):void
		{
			if (Math.round(event.sceneX/10) != X)
			{
				//cursor.x = Math.round(e.sceneX/10)*10;
				X = Math.round(event.sceneX/10);
			}
			
			if (Math.round(event.sceneZ/10) != Z)
			{
				//cursor.z = Math.round(e.sceneZ/10)*10;
				Z = Math.round(event.sceneZ/10);
			}
		}
		
		private function basePlaneMouseDown(event:MouseEvent3D):void
		{
			switch(creationState)
			{
				case "Surfaces":
					{
						if (texture!="")
							createCell(event);
						else
							Alert.show("Please, Select a Surface!!!", "Information");
					}
					break;
				
				case "Buildings":
					{
						if (model!="")
							createObject(event);
						else
							Alert.show("Please, Select a Building!!!", "Information");
					}
					break;
					
			}	
		} 
		
		private function createCell(event:MouseEvent3D):void
		{	
			if(current==null)
				addSurface("textures/"+texture, X*10, Z*10, 0);
			else
				addSurface("textures/"+texture, X*10, Z*10, current.rotationY);
			
			//var e:Event = new Event("mapClick");
			//dispatchEvent(e);
		}
		
		private function createObject(event:MouseEvent3D):void
		{
			if(current==null)
				addBuilding("models/"+model, X*10, Z*10, 0);
			else
				addBuilding("models/"+model, X*10, Z*10, current.rotationY);
			
			//var e:Event = new Event("mapClick");
			//dispatchEvent(e);
		}
		
		public function addSurface(textureUrl:String, X:Number, Z:Number, rotation:Number):void
		{
			_surface = new Surface(textureUrl, X, Z, rotation, this);
			this.addChild(_surface);
			
			//Fill Array to export objects --->>> (TESTING MEMORY DINAMIC REFERENCE)
			surfacesArray.addItem(_surface);
		}
		
		public function addBuilding(modelUrl:String, X:Number, Z:Number, rotation:Number):void
		{
			_building = new Building(modelUrl, X, Z, rotation, this);
			this.addChild(_building);
			
			//Fill Array to export objects --->>> (TESTING MEMORY DINAMIC REFERENCE)
			buildingsArray.addItem(_building);
		}
		
		public function removeCurrentObject():void
		{
			this.removeChild(current);
			
			if (current is Surface)
				surfacesArray.removeItemAt(surfacesArray.getItemIndex(current));
			else
				buildingsArray.removeItemAt(buildingsArray.getItemIndex(current));
		}
	}
}