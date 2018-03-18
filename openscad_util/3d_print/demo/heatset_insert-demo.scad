include <constants/all.scad>
use <3d_print/heatset_insert.scad>

heatset_insert_hole(0.25*inch);

translate([15,0,0]) heatset_insert_hole(3);
translate([30,0,0]) heatset_insert_hole(4);
translate([45,0,0]) heatset_insert_hole(5);
