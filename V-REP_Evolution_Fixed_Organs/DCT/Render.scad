
// Create matrix
mr = 	[
[2,9,19],
[2,10,17],
[2,10,18],
[2,10,19],
[2,11,17],
[2,11,18],
[2,11,19],
[8,10,10],
[9,9,10],
[9,10,9],
[9,10,10],
[9,11,9],
[9,11,10],
[10,9,9],
[10,9,10],
[10,10,9],
[10,10,10],
[10,11,9],
[10,11,10],
[11,10,9],
[11,10,10],
		];
// Draw cubes
// Z-axis
for (a =[0:len(mr)-1]){
	color([1,0,0]) translate([mr[a][0], mr[a][1], mr[a][2]])cube([1,1,1]);
			
}