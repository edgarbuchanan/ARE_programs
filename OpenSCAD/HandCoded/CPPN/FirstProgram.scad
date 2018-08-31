
// Create matrix
mr = 	[
		[3,3,3,0,0,3,3,3,0,0,3,3,3,0,0,3,3,3,1,0,3,3,1,0,0],
		[3,3,0,0,0,3,3,0,0,0,3,3,0,0,0,3,3,3,0,0,3,1,1,0,0],
		[3,3,0,0,0,3,3,0,0,0,3,1,0,0,0,3,3,2,0,0,1,1,1,0,0],
		[3,3,0,0,0,3,2,0,0,0,2,2,2,0,0,2,2,2,0,0,1,2,2,0,0],
		[3,3,0,0,0,3,0,0,0,0,2,2,0,0,0,2,2,0,0,0,1,2,0,0,0]
		];
// Draw cubes
// Z-axis
for (a =[0:4]){
	// Y=axis
	for (b =[0:4]){
		// X-axis
		for (c =[0:4]){
			// Draw cube
			if(	mr[a][(b*5)+c] == 1){				
				color([1,0,0]) translate([c, b, a ])cube([1,1,1]);
			} 
			if(	mr[a][(b*5)+c] == 2){
				color([0,0,1]) translate([c, b, a ])cube([1,1,1]);
			} 
			if(	mr[a][(b*5)+c]== 3){
				color([0,1,0]) translate([c, b, a ])cube([1,1,1]);
			}  
		}
	}
}
/*
// Create matrix
mr = 	[
		[1, 1, 0],
		[0, 1, 0],
		[0, 1, 1]
		];
echo(mr);
// Draw cubes
for (a =[0:2]){
	for (b =[0:2]){
		echo(mr[a][b]);
		if(	mr[a][b]==1){
			// Move and draw cube
			translate([a, b, 0 ])cube([1,1,1]);
			echo("bang");
		}  
	}
}
*/