package view.loader;
import client.view.MonsterTypeIcon;
import client.view.RoomActive;
import game.Game;
import game.entity.MonsterType;
import game.entity.Player;
import haxe.ds.StringMap;
import haxe.ds.IntMap;
import sweet.functor.IFunction;
import tool.NormalizerRemap;
import unveil.loader.ALoader;
import unveil.tool.StringTool;


/**
 * ...
 * @author 
 */
class GameStateLoader extends ALoader<Dynamic> {

	var _oGame :Game;
	var _oNormalizer :IFunction<Dynamic,Dynamic>;
	
	public function new( oGame :Game ) {
		_oGame = oGame;
		_oNormalizer = new NormalizerRemap([
			'game.entity.Combat' => ['engageAr' => null, 'maxOverflow'=>null],
			'game.entity.Player' => [
				'fight' => null,
				'gold' => null,
				'attackGroup' => null,
				'attackerShopOption' => null,
				'room' => null
			],
			//'game.entity.Dungeon' => ['roomAr' => null,'shopOptionAr' => null],
			'game.entity.Fighter' => [
				'id' => null,
				'type' => null,
				'health' => null,
				'healthPercent' => null,
			],
			'game.entity.Worldmap' => [
				'roomAr' => null,
				'doorAr' => null,
			],
			'game.entity.MonsterType' => [
				'label' => null, 
				'healthMax' => null, 
				'dice' => null,
				'gold' => null,
				'space' => null,
				'icon' => MonsterTypeIcon.getInstance(),
			],
			'game.entity.DiceFace' => ['type' => null, 'value' => null],
			'game.entity.Door' => ['position' => null, 'vertical' => null],
			'game.entity.Room' => [
				'id' => null, 
				'position' => null, 
				'fighterAr' => null, 
				'visited' => null, 
				'active' => new RoomActive( oGame )
			],
			'space.Vector2i' => ['x' => null, 'y' => null,],
			'game.Game' => ['playerAr' => null, 'worldmap' => null,],
		]);
		super();
	}
	
	override public function callback(resolve:Dynamic->Void, reject:Dynamic->Void) {
		
		var o = _oNormalizer.apply(_oGame);
		trace( o );
		resolve( o );
	}
	
}