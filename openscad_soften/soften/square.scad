use <validation/validate.scad>
use <layout/layout.scad>

module soft_square(size, r=0, center=false) {
  x_dim = len(size) ? size.x : size;
  y_dim = len(size) ? size.y : size;

  validate(x_dim >= 2*r, "radius must be less than  half x-dimension");

  translate(center ? [0,0] : [x_dim/2, y_dim/2]) {
    if(r > 0) {
      hull() {
        square([x_dim, y_dim-2*r], center=true);
        square([x_dim-2*r, y_dim], center=true);
         mirror_xy() {
          translate([x_dim/2-r, y_dim/2-r]) circle(r=r);
        }
      }
    } else {
      square([x_dim, y_dim], center=true);
    }
  }
}