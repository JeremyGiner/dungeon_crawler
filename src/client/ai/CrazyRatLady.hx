package client.ai;
import game.Game;
import game.entity.Player;

/**
 * ...
 * @author 
 */
class CrazyRatLady {
	
	var _oPlayer :Player;

	public function new( oPlayer :Player ) {
		_oPlayer = oPlayer;
	}
	
	public function process( oGame :Game ) {
		oGame.buy( _oPlayer, oGame.getMonsterTypeByLabel('rat'), 0 );
		oGame.buy( _oPlayer, oGame.getMonsterTypeByLabel('rat'), 1 );
		oGame.buy( _oPlayer, oGame.getMonsterTypeByLabel('rat'), 2 );
		oGame.buy( _oPlayer, oGame.getMonsterTypeByLabel('rat'), 3 );
		oGame.buyAttacker( _oPlayer, oGame.getMonsterTypeByLabel('rat') );
		oGame.buyAttacker( _oPlayer, oGame.getMonsterTypeByLabel('bat') );
		oGame.buyAttacker( _oPlayer, oGame.getMonsterTypeByLabel('bat') );
		oGame.buyAttacker( _oPlayer, oGame.getMonsterTypeByLabel('rat') );
	}
	
}