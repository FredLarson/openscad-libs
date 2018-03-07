use <soften/fillet.scad>
include <constants/all.scad>

fillet_profile(10,120);

translate([25,0,0]) inside_fillets([25,25,15], fillet_r=3);

translate([50,0,0]) fillet(25,5,x_axis);

translate([90,0,0]) fillet_corner(5);