cp -r ../../../Matlab/Evolution/CPNN/Coordinates.csv .
if [[ $?  -ne 0 ]] ; then
  exit 1
fi
sed 's/.*/'['&'],'/' Coordinates.csv > CoordinatesToAppend.txt
cp SecondProgram.scad Render.scad
sed -i -e '/COORDINATES/ r CoordinatesToAppend.txt' -e '/COORDINATES/d' Render.scad

openscad -o Render.stl Render.scad 
