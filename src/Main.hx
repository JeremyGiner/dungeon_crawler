package;
import client.controller.CombatNextController;
import client.controller.DragEngagementController;
import client.controller.EndSetupPhaseController;
import client.controller.RoomMoveController;
import game.Game;
import haxe.Resource;
import js.Browser;
import js.lib.RegExp;
import unveil.Unveil;
import client.controller.DragStyleController;
import view.View;
import view.loader.GameStateLoader;

/**
 * ...
 * @author 
 */
@:build(view.Macro.buildTemplate('template'))
class Main {

	static public function main() {
		var oGame = new Game();
		//var oOpponent = new CrazyRatLady( oGame.getPlayerAr()[1] );
		//var user = {name: "Mark", distance: 3500};
		//var sample = "The results: $$display(::user::,::time::)";
		//var template = new haxe.Template(sample);
		//var output = template.execute({user: user, time: 15}, this);
		//trace(output);
		/*
		var oView = new View();
		Browser.document.body.innerHTML = oView.render(function(s :String ){return s; }, 'main', {
			dungeon: {
				roomAr: {
					
				}
			}
		});
		*/
		
		trace(Resource.listNames());
		var aTemplate = [];
		for ( sRes in Resource.listNames() ) {
			aTemplate.push( { key: sRes, template: Resource.getString(sRes) } );
		}
		
		var oUnveil = new Unveil([
				'game' => new GameStateLoader( oGame ),
			], [
				{
					id: 'main',
					path_pattern: new RegExp('^\\/.*$'),
					page_data: null,
					model_load: ['game'],
				},
			], aTemplate
		);
		/*
		new BuyController( 
			oGame, 
			oGame.getPlayerAr()[0], 
			oUnveil 
		);
		
		new BuyAttackerController( 
			oGame, 
			oGame.getPlayerAr()[0], 
			oUnveil 
		);
		*/
		new CombatNextController( oGame, oGame.getPlayerAr()[0], oUnveil );
		new EndSetupPhaseController( oGame, oGame.getPlayerAr()[0], oUnveil );
		
		new DragStyleController();
		new DragEngagementController( oGame, oGame.getPlayerAr()[0], oUnveil );
		new RoomMoveController( oGame, oGame.getPlayerAr()[0], oUnveil );
		/*
		oGame.onTurnBegin(function() {
			oOpponent.process( oGame );
		});
		*/
	}
	
}