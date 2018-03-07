use <soften/hole.scad>

hole(h=20,d1=10, d2=5);
translate([25,0,0]) hole(d=10, h=25, top_r=3);
