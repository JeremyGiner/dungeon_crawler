package game.entity;
import haxe.ds.IntMap;
import tool.IntTool;

typedef Engagement = {
	var defender_action :FighterAction;
	var attacker_engagement_ar :Array<AttEngagement>;
}

typedef FighterAction = {
	var fighter :Fighter;
	var dice_face :DiceFace;
}

typedef AttEngagement = {
	var attacker_action :FighterAction;
	var damage :Int;
}

/**
 * ...
 * @author 
 */
class Combat {

	var _aEngagement :Array<Engagement>;
	var _iMaxAttCount :Int;
	
	public function new( 
		aDefender :Array<Fighter>, 
		aAttacker :Array<Fighter> 
	) {
		
		_reset( aDefender, aAttacker );
		
	}
	
	private function _reset( 
		aDefender :Array<Fighter>, 
		aAttacker :Array<Fighter> 
	) {
		_iMaxAttCount = Math.ceil( aAttacker.length / aDefender.length );
		
		_aEngagement = [];
		if ( aAttacker.length == 0 ) return;
		if ( aDefender.length == 0 ) return;
		for ( i in 0...aDefender.length )
			_aEngagement.push({
				defender_action: _createFighterAction(aDefender[i]),
				attacker_engagement_ar: 
					aAttacker.length <= i ? [] : [
						_createAttEngagement( aAttacker[i] )
					],
			});
		// engage remaining attacker
		if ( aDefender.length < aAttacker.length ) {
			var oLastEgagement = _aEngagement[ _aEngagement.length - 1 ];
			for ( i in aDefender.length...aAttacker.length )
				oLastEgagement.attacker_engagement_ar.push(
					_createAttEngagement( aAttacker[i] )
				);
		}
		
		_update();
	}
	
//_____________________________________________________________________________
// Accessor
	
	private function _createFighterAction( oFighter :Fighter ) {
		return {
			fighter: oFighter,
			dice_face: draw( oFighter.getType().getDice() ),
		};
	}


	private function _createAttEngagement( oFighter :Fighter ) :AttEngagement {
		return {
			attacker_action: _createFighterAction( oFighter ),
			damage: 0,
		};
	}

	public function drawForGroup( a :Array<Fighter>) {
		var aDraw :Array<FighterAction> = [];
		for ( o in a ) 
			aDraw.push( {
				dice_face: draw( o.getType().getDice() ),
				fighter: o,
			} );
		return aDraw;
	}
	
	public function draw<C>( a :Array<C> ) :C {
		var i = Math.floor( Math.random() * a.length );
		return a[ i ];
	}
	
	public function getEngageAr() {
		return _aEngagement;
	}
	public function getMaxOverflow() {
		return _iMaxAttCount;
	}
	
//_____________________________________________________________________________
// Modifier
	
	public function setEngagement( iEngageIndex :Int, iEngageAttIndex :Int, iTargetEngageIndex :Int ) {
		
		// Fail safe
		//if ( iEngageIndex < 0 || _aEngagement.length >= iEngageIndex ) throw '!';
		// TOO : fail safe iEngageAttIndex
		
		// Remove previous position
		var oCurrentAttEngagement = _aEngagement[ iEngageIndex ].attacker_engagement_ar[iEngageAttIndex];
		_aEngagement[ iEngageIndex ].attacker_engagement_ar.remove( oCurrentAttEngagement );
		
		// Add to new position
		_aEngagement[ iTargetEngageIndex ].attacker_engagement_ar.push( oCurrentAttEngagement );
		
		_update();
	}
	
	public function swapEngagement( 
		iEngageAIndex :Int, iEngageAttAIndex :Int, 
		iEngageBIndex :Int, iEngageAttBIndex :Int
	) {
		// Get subject previous defender
		
		// Fail safe
		//if ( oDefenderPrev == oDefender ) throw '!!!';
		
		setEngagement( iEngageBIndex, iEngageAttBIndex, iEngageAIndex );
		
		// 
		setEngagement( iEngageAIndex, iEngageAttAIndex, iEngageBIndex );
	}
	
//_____________________________________________________________________________
// Process
	
	function _update() {
		// Upadte damage
		for ( oEngagement in _aEngagement ) 
		for ( oAttackerEngagement in oEngagement.attacker_engagement_ar ) {
			oAttackerEngagement.damage = getDamage( 
				oAttackerEngagement.attacker_action.dice_face, 
				oEngagement.defender_action.dice_face 
			);
		}
	}

	public function resolve() :Bool {
		
		var aDef = [];
		var aAtt = [];
		for ( oEngagement  in _aEngagement ) {
			var oDef = oEngagement.defender_action.fighter;
			for ( oAttackerEngagement in oEngagement.attacker_engagement_ar ) {
				var iDamage = oAttackerEngagement.damage;
				
				var oAtt = oAttackerEngagement.attacker_action.fighter;
				
				//if ( iDamage == 0 ) continue;  
				if ( iDamage > 0 ) {
					oDef.damage( iDamage );
				} else if( iDamage < 0 ) {
					oAtt.damage( -iDamage );
				}
				if ( oAtt.getHealth() > 0 )
					aAtt.push( oAtt );
			}
			if ( oDef.getHealth() > 0 )
				aDef.push( oDef );
		}
		
		_reset( aDef, aAtt );
		
		return _aEngagement.length == 0;
	}/*
	
	public function resolveDiceFace( a :DiceFace, b :DiceFace ) {
		switch( [a.getType(), b.getType()] ) {
			case [Int, Int], [Str, Str], [Agi, Agi]: 
				return a.getValue() - b.getValue();
			case [Str, Int],[Int, Agi],[Agi, Str]: 
				return a.getValue() - b.getValue() * 2;
			case [Int, Str],[Agi, Int],[Str, Agi]:
				return a.getValue() * 2 - b.getValue();
		}
	}*/

	
	public function getRandomItem<C>( a :Array<C> ) :C {
		// Random number
		var i = Math.floor(Math.random() * a.length);
		return a[i];
	}
	
	public function getDamage( a :DiceFace, b :DiceFace ) {
		var iAMultiplier = 1;
		var iBMultiplier = 1;
		switch( {a: a.getType(), b: b.getType() } ) {
			case 
				{a: EDiceFaceType.Str, b: EDiceFaceType.Int}, 
				{a: EDiceFaceType.Int, b: EDiceFaceType.Agi}, 
				{a: EDiceFaceType.Agi, b: EDiceFaceType.Str}
			:
				iAMultiplier = 2;
			case 
				{a: EDiceFaceType.Int, b: EDiceFaceType.Str}, 
				{a: EDiceFaceType.Agi, b: EDiceFaceType.Int}, 
				{a: EDiceFaceType.Str, b: EDiceFaceType.Agi} 
			:
				iBMultiplier = 2;
			default:
				// Do nothing
		}
		var iValueA = a.getValue() * iAMultiplier; 
		var iValueB = b.getValue() * iBMultiplier;
		if ( iValueA == iValueB ) return 0;
		return iValueA > iValueB ? iValueA : -iValueB;
	}
	
}