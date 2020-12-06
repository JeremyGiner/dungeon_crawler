package client.controller;
import game.Game;
import game.entity.Player;
import js.html.Element;
import unveil.Unveil;
import unveil.controller.ClickController;

/**
 * ...
 * @author 
 */
class RoomMoveController extends ClickController {

	var _oGame :Game;
	var _oCurrentPlayer :Player;
	var _oUnveil :Unveil;
	
	public function new( 
		oGame :Game,
		oPlayer :Player,
		oUnveil :Unveil
	) {
		_oGame = oGame;
		_oCurrentPlayer = oPlayer;
		_oUnveil = oUnveil;
		super('room_move');
	}
	
	override function _onClick( oElement :Element ) {
		var oRoom = _oGame.getWorldmap().getRoom( Std.parseInt( oElement.dataset.room ) );
		if ( oRoom == null ) throw '!!!';
		_oGame.move( _oCurrentPlayer, oRoom );
		
		_oUnveil.getPageController().goto('/');
	}
	
}