package client.controller;
import js.Browser;
import js.html.DragEvent;
import js.html.Element;
import js.html.MouseEvent;

/**
 * ...
 * @author 
 */
class DragStyleController {
	
	public function new() {
		
		// TODO : handle drag-group
		
		Browser.document.addEventListener('dragenter', function( event :DragEvent ) {
			
			// Get target
			if ( !Std.is(event.target, Element) ) return;
			var oTarget :Element = cast event.target;
			
			oTarget = oTarget.closest('.js-dropzone');
			if ( oTarget == null ) 
				return;
			
			// Update class
			if ( oTarget.classList.contains('drag-hover') ) return;
			oTarget.classList.add('drag-hover');

		});

		Browser.document.addEventListener('dragleave', function( event :DragEvent ) {
			
			if ( !Std.is(event.target, Element) ) return;
			var oTarget :Element = cast event.target;
			
			if ( !oTarget.classList.contains('js-dropzone') ) return;
			
			
			
			
			oTarget.classList.remove('drag-hover');

		});

	}
}