package game.entity;
import space.Vector2i;
import tool.IntTool;

/**
 * ...
 * @author ...
 */
class Door {
	
	var _oPosition :Vector2i;
	var _oRoomA :Room;
	var _oRoomB :Room;
	
	public function new( oRoomA :Room, oRoomB :Room ) {
		_oRoomA = oRoomA;
		_oRoomB = oRoomB;
		_oPosition = new Vector2i( 
			IntTool.min( _oRoomA.getPosition().getX(), _oRoomB.getPosition().getX() ), 
			IntTool.min( _oRoomA.getPosition().getY(), _oRoomB.getPosition().getY() ) 
		);
	}
	
	public function getRoomA() { return _oRoomA; }
	public function getRoomB() { return _oRoomB; }
	public function getPosition() { return _oPosition; }
	public function getVertical() { return _oRoomA.getPosition().getY() != _oRoomB.getPosition().getY(); }

}