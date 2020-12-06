package client.controller;
import game.Game;
import game.entity.Player;
import js.Browser;
import js.html.Element;
import js.html.MouseEvent;
import unveil.Unveil;
import unveil.controller.ClickController;

/**
 * ...
 * @author 
 */
class EndSetupPhaseController extends ClickController {

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
		super('end_setup');
	}
	
	override function _onClick( oElement :Element ) {
		
		_oGame.endTurnSetup();
		
		_oUnveil.getPageController().goto('/');
	}
	
}