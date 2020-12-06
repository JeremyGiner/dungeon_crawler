package tool;
import haxe.ds.StringMap;
import sweet.functor.IFunction;
import haxe.ds.IntMap;
import unveil.tool.StringTool;


/**
 * ...
 * @author 
 */
class NormalizerRemap implements IFunction<Dynamic,Dynamic> {

	var _mMappingField :StringMap<StringMap<IFunction<Dynamic,Dynamic>>>;
	
	public function new( mMappingField :StringMap<StringMap<IFunction<Dynamic,Dynamic>>> ) {
		_mMappingField = mMappingField;
	}
	
	
	// TODO: limit depth
	/**
	 * Normalizer
	 * @param	o
	 * @param	mMappingField
	 */
	public function apply( o :Dynamic ) :Dynamic {
		
		// Case : null
		if ( o == null ) return null;
		
		// Case : Iterable
		if ( isIterable( o ) ) {
			var oIterator :Iterator<Dynamic> = o.iterator();
			var a = [];
			for ( oChild in oIterator ) {
				a.push( apply( oChild ) ); 
			}
			return a;
		}
		if ( Std.is( o, StringMap ) || Std.is( o, IntMap ) ) {
			throw 'TODO';
		}
		
		// Case : scalar
		if ( 
			Std.is(o, Int) || Std.is(o, String) 
			|| Std.is(o, Float) || Std.is(o, Bool)
		) {
			return o;
		}
		
		var oClass = Type.getClass( o );
		
		// Case : annonymous structure
		if ( oClass == null ) {
			var oRes = {};
			for ( sField in Reflect.fields(o) ) {
				Reflect.setField( 
					oRes, 
					sField, 
					apply( Reflect.field(o, sField ) ) 
				); 
			}
			
			return oRes;
		}
		
		// 
		var oView = {};
		var sClassName = Type.getClassName( oClass );
		if ( !_mMappingField.exists( sClassName ) ) {
			throw 'Mapping for class "'+sClassName + '" is required';
		}
		var aFieldName = _mMappingField.get( sClassName );
		for ( s => fn in aFieldName ) {
			
			var oValue = null;
			if(  fn == null ) { // TODO: put into its own class
				var oMethod = getAccessor( o, s );
				
				oValue = Reflect.callMethod(
					o,
					oMethod,
					[]
				);
			} else {
				oValue = fn.apply( o );
			}
		
			// 
			if ( !isIterable( oValue ) ) {
				Reflect.setField(
					oView,
					s,
					apply( oValue )
				);
				continue;
			}
			
			var oIterator :Iterator<Dynamic> = oValue.iterator();
			var a = [];
			for ( oChild in oIterator ) {
				a.push( apply( oChild ) ); 
			}
			
			Reflect.setField(oView,s,a);
		}

		return oView;
	}
	
	public function getAccessor( o :Dynamic, sField :String ) {
		var sMethod = 'get' + StringTool.ucfirst( sField );
		var oMethod = Reflect.field(o, sMethod);
		if ( oMethod == null )
			throw 'method "'+sMethod+'" is missing for class "'+Type.getClassName( Type.getClass( o ) )+'" ';
			
		return oMethod;
	}
	
	function isIterable( o :Dynamic ) {
		try {
			o.iterator();
		} catch ( e :Dynamic ) {
			return false;
		}
		return true;
	}
	
}