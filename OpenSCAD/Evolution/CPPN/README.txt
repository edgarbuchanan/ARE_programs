End
sed 's/$/'],'/' Coordinates.csv > Coordinates2.txt 
Beginning
sed 's/^/'['/' Coordinates.csv > Coordinates2.txt
Beginning and End

cp -r ../Matlab/Coordinates.csv .
sed 's/.*/'['&'],'/' Coordinates.csv > CoordinatesToAppend.txt
cp SecondProgram.scad Render.scad
sed -i -e '/COORDINATES/ r CoordinatesToAppend.txt' -e '/COORDINATES/d' Render.scad

openscad -o Render.stl Render.scad 
