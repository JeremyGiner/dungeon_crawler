package client.view;
import game.Game;
import game.entity.MonsterType;
import game.entity.Room;
import sweet.functor.IFunction;

/**
 * ...
 * @author 
 */
class RoomActive implements IFunction<Room,Bool> {

	var _oGame :Game;
	
	public function new( oGame :Game ) { _oGame = oGame; }
	
	public function apply( o :Room ) {
		return _oGame.isActive( _oGame.getPlayerAr()[0], o );
	}
	
}