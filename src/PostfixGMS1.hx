import sys.io.File;

class PostfixGMS1 {
	static function main() {
		var path = "sprite_add_gif_gms1.gmx/scripts/gif_preinit.gml";
		var gml = File.getContent(path);
		var rxArrayCreate = ~/\barray_create\b/g;
		gml = rxArrayCreate.replace(gml, "gmv_array_create");
		File.saveContent(path, gml);
		//trace(path);
	}
}