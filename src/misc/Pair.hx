package misc;

/**
 * @author 
 */
typedef Pair<C> ={
	var a :C;	
	var b :C;	
}

class PairTool {
	static public function create<C>( aGroupA :Iterable<C>, aGroupB :Iterable<C> ) {
		
		var a = new Array<Pair<C>>();
		var i = 0;
		var j = 0;
		for ( oA in aGroupA ) {
			
			for ( oB in aGroupB ) {
				if ( i > j )
					continue;
				a.push({a : oA, b: oB});
				j++;
			}
			i++;
		}
		return a;
	}
	
}