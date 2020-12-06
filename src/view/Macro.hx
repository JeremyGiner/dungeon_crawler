package view;
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.FileSystem;
import sys.io.File;

class Macro {
	public static function buildTemplate( s :String  ) :Array<Field> {
		
		var aFile = FileSystem.readDirectory( s );
		for ( sFileName in aFile ) {
			
			var sResName = Path.withoutExtension(sFileName);
			Context.addResource( sResName, File.getBytes(Path.join([s,sFileName])) );
		}
		
		// get the current fields of the class
		var fields:Array<Field> = Context.getBuildFields();
		
		
		return fields;
		
		
		
		
		
		
		// get the path of the current current class file, e.g. "src/path/to/MyClassName.hx"
		var posInfos = Context.getPosInfos(Context.currentPos());
		var directory = Path.directory(posInfos.file);
		
		// get the current class information. 
		var ref:ClassType = Context.getLocalClass().get();
		// path to the template. syntax: "MyClassName.template"
		var filePath:String = Path.join([directory, ref.name + ".template"]);
		trace(filePath);
		// detect if template file exists
		if (FileSystem.exists(filePath)) {
			// get the file content of the template 
			var fileContent:String = File.getContent(filePath);

			// add a static field called "TEMPLATE" to the current fields of the class
			fields.push({
				name:  "TEMPLATE",
				access:  [Access.AStatic, Access.APublic],
				kind: FieldType.FVar(macro:String, macro $v{fileContent}), 
				pos: Context.currentPos(),
				doc: "auto-generated from " + filePath,
				});
		}
		
		return fields;
	}
}