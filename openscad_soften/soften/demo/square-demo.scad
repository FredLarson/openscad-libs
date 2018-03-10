use <soften/square.scad>

soft_square(25);
translate([30,0,0]) soft_square(25, r=3);
translate([75,0,0]) soft_square(25, r=5, center=true);

//translate([105,0,0]) soft_square(25, r=15, center=true);
