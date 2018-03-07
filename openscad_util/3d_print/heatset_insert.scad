use <soften/hole.scad>
use <3d_print/heatset_insert_geometry.scad>

module heatset_insert_hole(size) {
  h = heatset_hole_depth(size);
  d = heatset_hole_diameter(size);

  stretch_length=0.15; // how much free space in bottom of hole to make
  hole(h=h*(1+stretch_length),
       d1=d[0],
       d2=d[1]+(d[0]-d[1])*stretch_length,
       top_chamfer=d[0]*0.1);
}
