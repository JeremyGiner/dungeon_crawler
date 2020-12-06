package game;
import game.entity.Combat;
import game.entity.DiceFace;
import game.entity.Fighter;
import game.entity.MonsterType;
import game.entity.Player;
import game.entity.Room;
import game.entity.Worldmap;
import game.process.CombatResolver;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import space.Vector2i;
import tool.UniqueIdGenerator;
//using tool.StructureCombiner;
import game.entity.EDiceFaceType;

/**
 * ...
 * @author 
 */
class Game {

	var _iTurn :Int;
	
	var _mFighter :IntMap<Fighter>;
	var _aPlayer :Array<Player>;
	var _oCombatResolver :CombatResolver;
	
	var _oIdGenerator :UniqueIdGenerator;
	
	var _aMonsterType :StringMap<MonsterType>;
	
	var _DF_STR_1 = new DiceFace(EDiceFaceType.Str, 1);
	var _DF_STR_2 = new DiceFace(EDiceFaceType.Str, 2);
	var _DF_STR_3 = new DiceFace(EDiceFaceType.Str, 3);
	var _DF_STR_4 = new DiceFace(EDiceFaceType.Str, 4);
	
	var _DF_AGI_1 = new DiceFace(EDiceFaceType.Agi, 1);
	var _DF_AGI_2 = new DiceFace(EDiceFaceType.Agi, 2);
	var _DF_AGI_3 = new DiceFace(EDiceFaceType.Agi, 3);
	var _DF_AGI_4 = new DiceFace(EDiceFaceType.Agi, 4);
	
	var _DF_INT_1 = new DiceFace(EDiceFaceType.Int, 1);
	var _DF_INT_2 = new DiceFace(EDiceFaceType.Int, 2);
	var _DF_INT_3 = new DiceFace(EDiceFaceType.Int, 3);
	var _DF_INT_4 = new DiceFace(EDiceFaceType.Int, 4);
		
	var _oWorldmap :Worldmap;
	
	public function new() {
		_oCombatResolver = new CombatResolver();
		_oIdGenerator = new UniqueIdGenerator();
		_mFighter = new IntMap();
		
		_oWorldmap = new Worldmap();
		_oWorldmap.addRoom( new Room(new Vector2i(0,0),1,1) );
		_oWorldmap.addRoom( new Room(new Vector2i(0,1),1,1) );
		_oWorldmap.addRoom( new Room(new Vector2i(1,0),1,1) );
		_oWorldmap.addRoom( new Room(new Vector2i(1,1),1,1) );
		_oWorldmap.createDoorByPos( new Vector2i(0,0), new Vector2i(0,1) );
		_oWorldmap.createDoorByPos( new Vector2i(0,1), new Vector2i(1,1) );
		_oWorldmap.createDoorByPos( new Vector2i(1, 1), new Vector2i(1, 0) );
		
		
		
		var oBase = {
			label: '',
			max_health: 1,
		}
		
		_aMonsterType = new StringMap<MonsterType>();
		
		var aHero = [
			'inquisitor' => MonsterType.create( {
				label: 'Inquisitor', 
				max_health: 10,
				dice: [_DF_AGI_1,_DF_AGI_2,_DF_INT_2,_DF_INT_3],
			} ),
			'hunter' => MonsterType.create({
				label: 'Hunter', 
				max_health: 10,
				dice: [_DF_STR_1,_DF_STR_2,_DF_AGI_2,_DF_AGI_3],
			} ),
			'paladin' => MonsterType.create({
				label: 'Paladin', 
				max_health: 10,
				dice: [_DF_INT_1,_DF_INT_2,_DF_STR_2,_DF_STR_3],
			} ),
		];
		
		var aMonster = [
			'rat' => MonsterType.create( {
				label: 'rat', cost: 1, space: 1,
				max_health: 4,
				dice: [_DF_AGI_1,_DF_STR_2,_DF_STR_2],
			} ),
			'bat' => MonsterType.create( {
				label: 'bat', cost: 1, space: 1,
				max_health: 4,
				dice: [_DF_INT_1,_DF_AGI_2,_DF_AGI_2],
			} ),
			'cat' => MonsterType.create( {
				label: 'cat', cost: 1, space: 1, 
				max_health: 4,
				dice: [_DF_STR_1,_DF_INT_2,_DF_INT_2],
			} ),
		];
		for( s => o in aHero )
			_aMonsterType.set(s,o);
		for( s => o in aMonster )
			_aMonsterType.set(s,o);
		
		_aPlayer = [
			new Player(Lambda.array(aMonster), Lambda.array(aHero)),
			//new Player(Lambda.array(aMonster), Lambda.array(aHero)),
		];
		
		_aPlayer[0].setRoom( _oWorldmap.getRoomByPos(new Vector2i(0, 0)) );
		for( oType in aHero )
			_addGroup( _aPlayer[0], oType );
		
			
		var oRoom = _oWorldmap.getRoomByPos( new Vector2i(1, 1) );
		_Room_addGroup( oRoom, aMonster.get('rat') );
		_Room_addGroup( oRoom, aMonster.get('rat') );
		_Room_addGroup( oRoom, aMonster.get('bat') );
		
	}
	
	public function getPlayerAr() { return _aPlayer; }
	public function getWorldmap() { return _oWorldmap; }
	
	public function getOpponent( oPlayer :Player ) {
		return _aPlayer[0] == oPlayer ? _aPlayer[1] : _aPlayer[0];
	}
	
	public function getMonsterTypeByLabel( s :String ) {
		for ( o in _aMonsterType ) {
			if ( o.getLabel() == s )
				return o;
		}
		return null;
	}
	
	public function getFighter( iId :Int ) {
		return _mFighter.get( iId );
	}
	
	public function isActive( oPlayer :Player, oRoom :Room ) {
		var oRoomCurrent = oPlayer.getRoom();
		if ( oRoomCurrent == oRoom ) return false;
		var aNextRoom = getWorldmap().getConnectedRoom( oRoomCurrent );
		return aNextRoom.contains( oRoom );
		//return Vector2i.distanceOcto( oRoom.getPosition(), oRoomCurrent.getPosition() ) == 1;
	}
	
	
	public function move( oPlayer :Player, oRoom :Room ) {
		oPlayer.setRoom( oRoom );
		var aFighter = oRoom.getFighterAr();
		if ( aFighter.length == 0 )
			return;
		oPlayer.setFight( new Combat(
			oPlayer.getAttackGroup(),
			aFighter
		) );
	}
	
//_____________________________________________________________________________
// 
	
	function _addGroup( oPlayer :Player, oType :MonsterType ) {
		var oFighter = new Fighter( 
			_oIdGenerator.generate(),
			oType 
		);
		oPlayer.getAttackGroup().push( oFighter );
		_mFighter.set( oFighter.getId(), oFighter );
	}
	
	function _Room_addGroup( oRoom :Room, oType :MonsterType ) {
		var oFighter = new Fighter( 
			_oIdGenerator.generate(),
			oType 
		);
		oRoom.addFighter( oFighter );
		_mFighter.set( oFighter.getId(), oFighter );
	}

	public function endTurnSetup() {
		_iTurn++;
		/*
		if( _aPlayer[0].getFight() == null ) {
			// Create fight
			for ( oPlayer in _aPlayer ) {
				
				oPlayer.setFight( new Combat(
					oPlayer.getDungeon().getNextRoom()
						.getFighterAr(),
					getOpponent( oPlayer ).getAttackGroup()
				) );
			}
			return;
		}
		*/
	}
	
	public function combatTurnEnd( oPlayer :Player ) {
		if ( !oPlayer.getFight().resolve() )
			return;
		oPlayer.setFight( null );
		
		if ( _isCombatOver() )
			combatEnd( oPlayer );
	}
	
	private function _isCombatOver() {
		for ( oPlayer in _aPlayer ) {
			
			if( oPlayer.getFight() != null ) return false;
			
		}
		return true;
	}
	
	public function combatEnd( oPlayer :Player ) {
		// Clear room
		oPlayer.getRoom().setFighterAr([]);
		
		
	}
	/*
	public function buy( 
		oPlayer :Player, 
		oMonterType :MonsterType,
		iRoomIndex :Int
	) {
		trace( oPlayer.getLabel() +' buy ' + oMonterType.getLabel() + ' in room #'+iRoomIndex);
		if ( 0 > oPlayer.getGold() - oMonterType.getGold() )
			throw 'Insuficient funds';
		
		var oRoom = oPlayer.getDungeon().getRoomAr()[ iRoomIndex ];
		
		if ( 0 > oRoom.getSpaceAvailable() - oMonterType.getSpace() )
			throw 'Not enought space';
		
		var oFighter = new Fighter( 
			_oIdGenerator.generate(),
			oMonterType 
		);
		oRoom.addFighter( oFighter );
		_mFighter.set( oFighter.getId(), oFighter );
	}
	
	public function buyAttacker( 
		oPlayer :Player, 
		oMonterType :MonsterType
	) {
		trace( oPlayer.getLabel() +' buy ' + oMonterType.getLabel() + ' attaccker');
		if ( 0 > oPlayer.getGold() - oMonterType.getGold() )
			throw 'Insuficient funds';
		
		var oFighter = new Fighter( 
			_oIdGenerator.generate(),
			oMonterType 
		);
		oPlayer.getAttackGroup().push( oFighter );
		_mFighter.set( oFighter.getId(), oFighter );
	}
	*/
//_____________________________________________________________________________
// Event dispacher : TODO use event listener
	
	public function onTurnBegin( fn :Void->Void ) {
		fn();
	}
}