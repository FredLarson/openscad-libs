use <soften/cylinder.scad>

soft_cylinder(d1=10, d2=5, h=15);
translate([25,0,0]) soft_cylinder(d=12, h=15,roundover_r=5, fillet_r=3, fillet_angle=180);
