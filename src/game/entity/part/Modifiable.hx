package game.entity.part;
import sweet.functor.IFunction;

/**
 * ...
 * @author 
 */
class Modifiable<C> {

	_oBase :C;
	_aModifier :Array<IFunction<C,C>>;
	
	public function new( oBase :C ) {
		_oBase = oBase;
	}
	
	
	public function getBase() :C {
		return _oBase;
		
	}
	public function get() :C {
		var o = _oBase;
		for ( oModifer in _aModifier )
			o = oModifer.apply( o );
		return o;
	}
	
	
	public function setBase( oBase ) {
		_oBase = oBase;
	}
	
	public function addModifer( o :IFunction<C,C> ) {
		_aModifer.push( o );
	}
	public function removeModifer( o :IFunction<C,C> ) {
		_aModifer.remove( o );
	}
	
}