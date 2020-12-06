package client.view;
import game.entity.MonsterType;
import sweet.functor.IFunction;

/**
 * ...
 * @author 
 */
class MonsterTypeIcon implements IFunction<MonsterType,String> {

	static var _oInstance = null;
	
	public function new() {}
	
	public function apply( o :MonsterType ) {
		return '/image/'+o.getLabel()+'.svg';
	}
	
	static public function getInstance() {
		if ( _oInstance == null ) 
			_oInstance = new MonsterTypeIcon();
		return _oInstance;
	}
}