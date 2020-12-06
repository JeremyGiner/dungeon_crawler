package game.entity;
import client.controller.RoomMoveController;
import haxe.ds.IntMap;
import haxe.io.Bytes;
import space.Vector2i;
import tool.UniqueIdGenerator;

/**
 * ...
 * @author ...
 */
class Worldmap {

	var _mRoom :IntMap<Room>;
	// var _mRoom :IntMap<Room>;
	var _aDoor :Array<Door>;
	var _mDoorByRoom :IntMap<Array<Door>>;
	
	var _oIdGenerator :UniqueIdGenerator;
	
	public function new() {
		// _mRoom = new IntMap<Room>();
		_aDoor = [];
		_mRoom = new IntMap<Room>();
		
		_oIdGenerator = new UniqueIdGenerator();
		
		// Indexer
		_mDoorByRoom = new IntMap<Array<Door>>();
	}
	
//_____________________________________________________________________________
// Accessor
	
	public function getRoom( iKey :Int ) { return _mRoom.get( iKey ); }
	
	public function getConnectedRoom( oRoom :Room ) {
		var aDoor = _mDoorByRoom.get( oRoom.getId() );
		var aRoom = [];
		for ( oDoor in aDoor ) {
			if( oDoor.getRoomA() != oRoom ) aRoom.push( oDoor.getRoomA() );
			if( oDoor.getRoomB() != oRoom ) aRoom.push( oDoor.getRoomB() );
		}
		return aRoom;
	}

	public function getRoomByPos( oPos :Vector2i ) {
		return _mRoom.get( getKey( oPos ) );
	}

	public function getRoomAr() {
		return Lambda.array( _mRoom );
	}
	
	public function getDoorAr() {
		return _aDoor;
	}
	
	public function getDoorArByRoom( oRoom :Room ) {
		return _mDoorByRoom.get( getKey( oRoom.getPosition() ) );
	}
	
	public function getKey( oPos :Vector2i ) {
		var i = Bytes.alloc(4);
		i.setUInt16( 0, oPos.x );
		i.setUInt16( 2, oPos.y );
		return i.getInt32(0);
	}
	
	
//_____________________________________________________________________________
// Modifier

	public function addRoom( oRoom :Room ) {
		var i = getKey( oRoom.getPosition() );
		oRoom.setId( i );
		
		_mRoom.set( i, oRoom );
	}
	
	public function addDoor( oRoomA :Room, oRoomB :Room ) {
		var oDoor = new Door( oRoomA, oRoomB );
		_aDoor.push(oDoor);
		
		// indexer
		if ( ! _mDoorByRoom.exists( oRoomA.getId() ) )
			_mDoorByRoom.set( oRoomA.getId(), [] );
		var a = _mDoorByRoom.get( oRoomA.getId() );
		a.push( oDoor );
		
		if ( ! _mDoorByRoom.exists( oRoomB.getId() ) )
			_mDoorByRoom.set( oRoomB.getId(), [] );
		var a = _mDoorByRoom.get( oRoomB.getId() );
		a.push( oDoor );
		
	}
	
//_____________________________________________________________________________
// Shorthand

	public function createDoorByPos( oVectorA :Vector2i, oVectorB :Vector2i ) {
		addDoor( getRoomByPos( oVectorA ),getRoomByPos( oVectorB ) );
	}

}