package client.controller;
import game.Game;
import game.entity.Player;
import js.Browser;
import js.html.DragEvent;
import js.html.Element;
import js.html.MouseEvent;
import unveil.Unveil;

/**
 * ...
 * @author 
 */
class DragEngagementController {
	
	var _bProcessing :Bool;
	
	var _oGame :Game;
	var _oCurrentPlayer :Player;
	var _oUnveil :Unveil;
	
	var _oDragged :Element;
	
	public function new( 
		oGame :Game,
		oPlayer :Player,
		oUnveil :Unveil 
	) {
		_oGame = oGame;
		_oCurrentPlayer = oPlayer;
		_oUnveil = oUnveil;
		
		
		/* events fired on the drop targets */
		Browser.document.addEventListener('dragover', function( event :DragEvent ) {
			// prevent default to allow drop
			event.preventDefault();
		}, false);
		
		Browser.document.addEventListener('dragstart', function( event :DragEvent ) {
			// store a ref. on the dragged elem
			_oDragged = cast event.target;
			// make it half transparent
			// event.target.style.opacity = .5;
		});
		
		/* events fired on the drop targets 
		document.addEventListener("dragover", function( event ) {
		// prevent default to allow drop
		event.preventDefault();
		}, false);
*/

		Browser.document.addEventListener('drop', function( event :DragEvent ) {
			// prevent default action (open as link for some elements)
			event.preventDefault();
			
			var oTarget :Element = cast event.target;
			oTarget  = oTarget.closest('.js-dropzone');
			
			if ( oTarget == null ) return;
			
			var a = _oDragged.dataset.engage_id.split('-');
			
			if ( oTarget.dataset.dropAction == 'set_engagement' ) {
				_oCurrentPlayer.getFight().setEngagement( 
					Std.parseInt( a[0] ), 
					Std.parseInt( a[1] ), 
					Std.parseInt( oTarget.dataset.engage_id )
				);
			}
			if ( oTarget.dataset.dropAction == 'swap_engagement' ) {
				var b = oTarget.dataset.engage_id.split('-');
				_oCurrentPlayer.getFight().swapEngagement( 
					Std.parseInt( a[0] ), 
					Std.parseInt( a[1] ), 
					Std.parseInt( b[0] ),
					Std.parseInt( b[1] )
				);
			}
			
			
			
			/*
			_oDragged.parentNode.removeChild( _oDragged );
			oTarget.appendChild( _oDragged );
			*/
			_oUnveil.getPageController().goto('/');
		});
	}
	// http://jsfiddle.net/radonirinamaminiaina/zfnj5rv4/
}