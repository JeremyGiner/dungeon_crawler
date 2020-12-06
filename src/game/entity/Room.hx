package game.entity;
import space.Vector2i;

/**
 * ...
 * @author ...
 */
class Room {

	var _aFighter :Array<Fighter>;
	var _iId :Int;
	var _iSizeX :Int;
	var _iSizeY :Int;
	
	var _bVisited :Bool;
	
	var _oPosition :Vector2i;
	
	public function new( oPosition :Vector2i, iSizeX :Int, iSizeY :Int) {
		_iId = null;
		_iSizeX = iSizeX;
		_iSizeY = iSizeY;
		_oPosition = oPosition;
		_aFighter = new Array<Fighter>();
		_bVisited = false;
	}
	
	public function setId( i :Int ) {
		if (_iId != null) throw '!!!';
		_iId = i;
	}
	
	public function getId() {
		return _iId;
	}
	
	
	
	public function setFighterAr( aFighter :Array<Fighter> ) { _aFighter = aFighter; }
	public function getFighterAr() { return _aFighter; }
	
	public function getPosition() { return _oPosition; }
	public function getSizeX() { return _iSizeX; }
	public function getSizeY() { return _iSizeY; }
	
	public function getVisited() { return _bVisited; }
	public function setVisited( b :Bool = true ) { _bVisited = b; }
	
	public function addFighter( o :Fighter ) {
		return _aFighter.push( o );
	}
	
	public function getSpaceAvailable() {
		var i = 9;
		for ( oFighter in _aFighter ) 
			i -= oFighter.getType().getSpace();
		return i;
	}
}