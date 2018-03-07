use <layout/layout.scad>
use <validation/validate.scad>
use <soften/fillet.scad>
use <soften/square.scad>
include <constants/all.scad>

module soft_cube(size, r=0, center=false, sidesonly=true) {
  x_dim = len(size) ? size.x : size;
  y_dim = len(size) ? size.y : size;
  z_dim = len(size) ? size.z : size;
  if(r == 0) {
    cube(size, center);
  } else if(sidesonly) {
    render()
      translate(center ? [0,0,-z_dim/2] : [x_dim/2, y_dim/2,0])
        linear_extrude(z_dim)
          soft_square([x_dim, y_dim], r, center=true);
  } else {
    hull() difference() {
      soft_cube(size,r=r,center=true);
      mirror_xyz()
        translate([-x_dim/2, -y_dim/2, -z_dim/2]) fillet(x_dim, r, x_axis);
      mirror_xyz()
        translate([-x_dim/2, -y_dim/2, -z_dim/2]) fillet(y_dim, r, y_axis);

      mirror_xyz() difference() {
        translate([-x_dim/2, -y_dim/2, -z_dim/2]) cube(r);
        translate([-x_dim/2+r, -y_dim/2+r, -z_dim/2+r]) sphere(r=r);
      }
    }
  }
}
