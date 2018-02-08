use <layout/layout.scad>
use <validation/validate.scad>
use <soften/fillets.scad>
x_axis=0;
y_axis=1;
z_axis=2;
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
//translate([20,0,0]) soft_cube(10, center=true, r=3);

//soft_cube(10, center=true, r=3, sidesonly=false);

// 4436 facets in 20s for cube(10,3, $fn=64);
// 5334 faces in 7 s by subtracing fillets
