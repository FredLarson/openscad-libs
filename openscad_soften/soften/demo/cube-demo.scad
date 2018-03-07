use <soften/cube.scad>

soft_cube(25, center=true, r=3, sidesonly=false);
translate([35,0,0]) soft_cube(25, center=true, r=3);
translate([55,0,0]) soft_cube(25);