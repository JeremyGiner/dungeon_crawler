package game.mutation;
import misc.VPathAccessor;

/**
 * ...
 * @author 
 */
class Mutation implements IMutation {

	var _oPath :VPathAccessor;
	var _oPrevData :Dynamic;
	var _oData :Dynamic;
	
	public function new( 
		oPath :VPathAccessor, 
		oPrevData :Dynamic,
		oData :Dynamic
	) {
		_oType = oType;
		_oData = oData;
	}
	
	public function getAccessor() {
		return _oAccessor;
	}
	
	public function getPrevData() {
		return _oPreviousData;
	}
	
	public function getData() {
		return _oData;
	}
	
}