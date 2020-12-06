package view;
import game.entity.Fighter;
import haxe.Resource;
import haxe.Template;
import haxe.ds.StringMap;
/**
 * ...
 * @author 
 */
@:build(view.Macro.buildTemplate('template'))
class View {
	
	var _mTemplate :StringMap<Template>;
	
	public function new() {
		_mTemplate = new StringMap();
		for ( sRes in Resource.listNames() ) {
			_mTemplate.set( sRes, new Template( Resource.getString(sRes) ) );
		}
	}
	
	public function render( resolve:String->Dynamic, s :String, oData :Dynamic ) {
		return _mTemplate.get( s ).execute( oData, this );
	}

	public function getTemplate( s :String ) {
		return _mTemplate.get( s );
	}
	
	
	public function getData() {
		
		return {
			
			current_player: {
				dungeon: {
					roomAr: {
						monsterAr: [],
					},
				},
			},
		}
	}
	
	public function getMonsterView( oFighter :Fighter ) {
		return {
			icon: getIcon( oFighter.getType().getLabel() ),
		}
	}
	
	public function getIcon( s ) {
		return {
			path: 'image/Characters/Rodent0.png',
			x: 0,
			y: 0
		};
	}
}