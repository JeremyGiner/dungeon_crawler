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
class BuyAttackerController extends ClickController {

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
		super('buy_attacker');
	}
	
	override function _onClick( oElement :Element ) {
		
		_oGame.buyAttacker( 
			_oCurrentPlayer, 
			_oGame.getMonsterTypeByLabel( oElement.dataset.buy )
		);
		
		_oUnveil.getPageController().goto('/');
	}
	
}