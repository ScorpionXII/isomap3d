package cu.isomap3d.core
{
	import away3d.loaders.Obj;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ArrayUtil;

	//Xml parsing functions for XMF Standar (*.xmf -> Xml Map Format)
	public class XMMParser
	{
		public function XMMParser()
		{
		}
		
		public static function XMLGenerator(surfacesArray:ArrayCollection, buildingsArray:ArrayCollection):XML
		{	
			var xmlRoot:XML = <mapdata></mapdata>;
			var xmlSurfaces:XML = <mapsurfaces></mapsurfaces>;
			var xmlBuildings:XML = <mapbuildings></mapbuildings>;
			
			for (var s:uint = 0; s < surfacesArray.length; s++)
			{
				var objSurface:Surface = surfacesArray[s] as Surface; 
				var xmlSList:XMLList = new XMLList('<surface><src>'+objSurface.textureUrl+'</src><posX>'+objSurface.x+'</posX><posZ>'+objSurface.z+'</posZ><rotation>'+objSurface.rotationY+'</rotation></surface>');
				xmlSurfaces.appendChild(xmlSList);
			}
			xmlRoot.appendChild(xmlSurfaces);
			
			for (var b:uint = 0; b < buildingsArray.length; b++)
			{
				var objBuilding:Building = buildingsArray[b] as Building; 
				var xmlBList:XMLList = new XMLList('<building><src>'+objBuilding.modelUrl+'</src><posX>'+objBuilding.x+'</posX><posZ>'+objBuilding.z+'</posZ><rotation>'+objBuilding.rotationY+'</rotation></building>');
				xmlBuildings.appendChild(xmlBList);
			}
			xmlRoot.appendChild(xmlBuildings);
			
			return xmlRoot;
		}
		
		public static function XMLInverse(xmmData:Object, map:GridMap):void
		{	
			var surfacesArray:ArrayCollection;
			var buildingsArray:ArrayCollection;
			
			if(xmmData.mapdata.mapsurfaces != null)
			{
				if(xmmData.mapdata.mapsurfaces.surface.length > 1)
					surfacesArray = xmmData.mapdata.mapsurfaces.surface;
				else
					surfacesArray = new ArrayCollection(ArrayUtil.toArray(xmmData.mapdata.mapsurfaces.surface));
				
				for(var s:uint = 0; s < surfacesArray.length; s++)
				{
					var objSurface:Object = surfacesArray[s];
					map.addSurface(objSurface.src, objSurface.posX, objSurface.posZ, objSurface.rotation);
				}
			}
			
			if(xmmData.mapdata.mapbuildings != null)
			{
				if(xmmData.mapdata.mapbuildings.building.length > 1)
					buildingsArray = xmmData.mapdata.mapbuildings.building;
				else
					buildingsArray = new ArrayCollection(ArrayUtil.toArray(xmmData.mapdata.mapbuildings.building));
				
				for(var b:uint = 0; b < buildingsArray.length; b++)
				{
					var objBuilding:Object = buildingsArray[b];
					map.addBuilding(objBuilding.src, objBuilding.posX, objBuilding.posZ, objBuilding.rotation);
				}
			}
		}
	}
}