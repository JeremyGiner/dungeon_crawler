package game.controller;
import js.Browser;
import js.html.Element;
import js.html.MouseEvent;
/**
 * ...
 * @author 
 */
class DragDrop {

	public function new() {
		Browser.document.addEventListener('mousedown', function( event :MouseEvent ){
			var oElement = cast(event.originalTarget,Element).closest('[draggable]');
			
			// TODO : only left click
			
			if ( oElement == null )
				return;
			
			// TODO : 
			/*
			get draggable group
			change class of the body to show drop placeholder
			
			left click cancel dragdrop
			
			mouseup confirm drag, dispatch custom event
			*/
		});
	}
	
}