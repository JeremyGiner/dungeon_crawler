package game.entity;

/**
 * ...
 * @author ...
 */
class DiceFace {

	var _oType :EDiceFaceType;
	var _iValue :Int;
	
	public function new( oType :EDiceFaceType, iValue :Int ) {
		_oType = oType;
		_iValue = iValue;
	}
	
	public function getType() {
		return _oType;
	}
	
	public function getValue() {
		return _iValue;
	}
}