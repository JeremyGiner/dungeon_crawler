package game.mutation;

/**
 * ...
 * @author 
 */
interface IMutation {

	public function getType() :EMutationType;	
	public function getData() :Dynamic;
}