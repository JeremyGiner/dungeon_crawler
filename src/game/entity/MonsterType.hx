package game.entity;
import haxe.ds.StringMap;

/**
 * ...
 * @author 
 */
class MonsterType {

	var _sLabel :String;
	
	var _iCostGold :Int; 
	var _iCostSpace :Int;
	
	var _iHealthMax :Int;
	var _aDiceFace :Array<DiceFace>;
	
	public function new( 
		sLabel :String,
		iCostGold :Int, 
		iCostSpace :Int,
		iHealthMax :Int,
		oDice :Array<DiceFace>
	) {
		_sLabel = sLabel;
		
		_iCostGold = iCostGold;
		_iCostSpace = iCostSpace;
		
		_iHealthMax = iHealthMax;
		
		_aDiceFace = oDice;
	}
	
	static public function create( oParam :{
			label :String, 
			? cost :Int, 
			? space :Int, 
			max_health :Int, 
			dice :Array<DiceFace>,
	} ) {
		if ( oParam.cost == null ) oParam.cost = 0;
		if ( oParam.space == null ) oParam.space = 0;
		
		return new MonsterType(
			oParam.label,
			oParam.cost,
			oParam.space,
			oParam.max_health,
			oParam.dice
		);
	}
	
	public function getLabel() {
		return _sLabel;
	}
	
	public function getGold() {
		return _iCostGold;
	}
	
	public function getSpace() {
		return _iCostSpace;
	}
	
	public function getHealthMax() {
		return _iHealthMax;
	}

	public function getDice() {
		return _aDiceFace;
	}
}