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
class BuyController extends ClickController {

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
		super('buy');
	}
	
	override function _onClick( oElement :Element ) {
		
		_oGame.buy( 
			_oCurrentPlayer, 
			_oGame.getMonsterTypeByLabel( oElement.dataset.buy ),
			Std.parseInt( oElement.dataset.room )
		);
		
		_oUnveil.getPageController().goto('/');
	}
	
}