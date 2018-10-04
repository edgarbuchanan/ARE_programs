
// Create matrix
mr = 	[
[3,4,5],
[5,7,9],
		];
// Draw cubes
// Z-axis
for (a =[0:len(mr)-1]){
	color([1,0,0]) translate([mr[a][0], mr[a][1], mr[a][2]])cube([1,1,1]);
			
}
