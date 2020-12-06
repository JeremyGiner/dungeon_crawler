package game.entity;

/**
 * ...
 * @author 
 */
class Fighter {
	
	var _iId :Int;
	var _iHealth :Int;
	var _oType :MonsterType;
	
	public function new( 
		iId :Int,
		oType :MonsterType
	) {
		_iId = iId;
		_iHealth = oType.getHealthMax();
		_oType = oType;
	}
	
	public function getId() {
		return _iId;
	}
	
	public function getType() {
		return _oType;
	}
	
	public function getHealth() {
		return _iHealth;
	}
	
	public function damage( i :Int ) {
		_iHealth -= i;
	}
	
	
	// TODO put into the view
	public function getHealthPercent() {
		return _iHealth / _oType.getHealthMax() * 100;
	}
}