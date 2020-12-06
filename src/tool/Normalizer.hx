package tool;
import haxe.ds.StringMap;
import sweet.functor.IFunction;

/**
 * ...
 * @author 
 */
class Normalizer implements IFunction<Dynamic,Dynamic> {

	var _mMappingField :StringMap<Array<String>>;
	
	public function new( mMappingField :StringMap<Array<String>> ) {
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
					getView(
						Reflect.field(o, sField ), 
						_mMappingField
					) 
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
		for ( s in aFieldName ) {
			
			var sMethod = 'get' + StringTool.ucfirst( s );
			
			var oMethod = Reflect.field(o, sMethod);
			
			if ( oMethod == null )
				throw 'method "'+sMethod+'" is missing for class "'+sClassName+'" ';
			
			var oValue = Reflect.callMethod(
				o,
				oMethod,
				[]
			);
		
			// 
			if ( !isIterable( oValue ) ) {
				Reflect.setField(
					oView,
					s,
					getView(oValue, _mMappingField)
				);
				continue;
			}
			
			var oIterator :Iterator<Dynamic> = oValue.iterator();
			var a = [];
			for ( oChild in oIterator ) {
				a.push( getView( oChild, _mMappingField ) ); 
			}
			
			Reflect.setField(oView,s,a);
		}

		return oView;
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