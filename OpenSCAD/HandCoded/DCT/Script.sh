cp -r ../../../Matlab/HandCoding/DCT/Coordinates.csv .
sed 's/.*/'['&'],'/' Coordinates.csv > CoordinatesToAppend.txt
cp SecondProgram.scad Render.scad
sed -i -e '/COORDINATES/ r CoordinatesToAppend.txt' -e '/COORDINATES/d' Render.scad

openscad -o Render.stl Render.scad 
