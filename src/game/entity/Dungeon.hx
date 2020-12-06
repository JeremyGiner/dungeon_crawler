package game.entity;
import game.entity.part.EDirection;

/**
 * ...
 * @author 
 */
class Dungeon {
	
	/** 
	 * 2 -- 3
	 * 0 -- 1
	 */
	public var _aRoom :Array<Room>;
	public var _oSign0 :EDirection;
	public var _oSign1 :EDirection;
	
	public var _aShopOption :Array<MonsterType>;

	public function new( aShopOption :Array<MonsterType> ) {
		_oSign0 = EDirection.Left;
		_oSign1 = EDirection.Right;
		_aShopOption = aShopOption;
	}
	
	public function getShopOptionAr() {
		return _aShopOption;
	}
}