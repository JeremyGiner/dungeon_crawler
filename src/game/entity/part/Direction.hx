package game.entity.part;
import space.Vector2i;

/**
 * @author 
 */
enum abstract Direction(Int) {
	var UP;
	var DOWN;
	var LEFT; 
	var RIGHT;
}

class DirectionTool {
	
	static var all = [Direction.RIGHT, Direction.UP, Direction.LEFT, Direction.DOWN];
	
	static public function getAll() {
		return all;
	}
	static public function getByVector( oVector :Vector2i ) {
		var a = new Array<Direction>();
		if ( oVector.x > 0 )
			a.push( Direction.RIGHT );
		if ( oVector.x < 0 )
			a.push( Direction.LEFT );
		if ( oVector.y > 0 )
			a.push( Direction.UP );
		if ( oVector.y < 0 )
			a.push( Direction.DOWN );
		return a;
	}
	static public function getReverse( oDirection :Direction ) {
		
		switch( oDirection ) {
			case UP: return Direction.DOWN;
			case DOWN: return Direction.UP;
			case RIGHT: return Direction.LEFT;
			case LEFT: return Direction.RIGHT;
			
		}
	}
}
