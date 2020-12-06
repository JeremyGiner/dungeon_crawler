package game.entity;

typedef Fight = {
	var attacker :Array<Fighter>;
	var defender :Array<Fighter>;
}

/**
 * ...
 * @author 
 */
class Player {

	var _iGold :Int;
	var _aAttackGroup :Array<Fighter>;
	var _aAttackerShopOption :Array<MonsterType>;
	var _oCombat :Combat;
	var _oRoom :Room;
	
	public function new( 
		aMonsterOption :Array<MonsterType>,
		aAttackerShopOption :Array<MonsterType>
	) {
		_aAttackGroup = [];
		_iGold = 10;
		_oCombat = null;
		_aAttackerShopOption = aAttackerShopOption;
		_oRoom = null;
	}
	
//___________________________________________________________________
// Accessor


	public function getLabel() { return 'Player'; }
	public function getGold() { return _iGold; }
	public function getRoom() { return _oRoom; }
	public function getAttackGroup() { return _aAttackGroup; }
	public function getAttackerShopOption() { return _aAttackerShopOption; }
	
	public function getFight() { return _oCombat; }

//___________________________________________________________________
// Modifier
	
	public function setFight( oCombat :Combat ) { _oCombat = oCombat; }
	public function setRoom( o :Room ) { _oRoom = o; }
}