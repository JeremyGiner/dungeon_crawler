package game.process;
import game.entity.DiceFace;
import game.entity.EDiceFaceType;
import game.entity.Fighter;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import misc.Pair;

/**
 * ...
 * @author 
 */
class CombatResolver {
	
	var _mDamageModifer = [
		EDefType.Armor => [
			EAttackType.Physic => 0.5,
		],
	];
	

	public function new() {
		
	}
	
}