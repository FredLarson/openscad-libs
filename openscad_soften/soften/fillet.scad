include <constants/all.scad>
use <layout/layout.scad>
use <soften/hole.scad>
use <soften/cylinder.scad>

function fillet_fn(fn, r) = ceil(min(max(fn, 12), r*6) / 4) * 8;

module fillet(length, r, axis=x_axis) {
  $fn = fillet_fn($fn, r);
  rotates = [[0,90,0],[90,0,0],[0,0,0]];
  mirrors = [[0,0,1],[0,1,0],[0,0,0]];
  mirror(mirrors[axis])
    rotate(rotates[axis])
      linear_extrude(length)
        fillet_profile(r, 90);
}


module circular_fillet(d,r=5, angle=360,fillet_angle=90) {
  rotate_extrude(angle=angle)
    translate([d/2,0])
      fillet_profile(r,fillet_angle, $fn = fillet_fn($fn, r));
}

module fillet_corner(r=0) {
    render() intersection() {
        fillet(r+epsilon, r, x_axis);
        fillet(r+epsilon,r,y_axis);
    }
}

module fillet_profile(r, angle) {
  $fn = fillet_fn($fn, r);
  chord = r * sin(angle/2);
  leg = tan(90-angle/2)*r;
  rotate(-angle/2)
    difference() {
      rotate(angle/2)
        polygon([[0,0], [0,leg], [sin(angle)*leg, cos(angle)*leg]]);
      translate([0,r/cos(90-angle/2)])
        circle(r=r);
    }
}

module filleted_cube(size, fillet_r=0) {
  translate([0,0,-epsilon/2])
    cube(size+[0,0,epsilon], center=true);
  mirror_y() {
    translate([-size[0]/2,size[1]/2,-size[2]/2]) fillet(size[0],fillet_r,x_axis);
  }
  mirror_x() {
      translate([size[0]/2,-size[1]/2,-size[2]/2]) fillet(size[1],fillet_r,y_axis);
  }

  mirror_xy() {
      translate([size[0]/2, size[1]/2, -size[2]/2]) fillet_corner(fillet_r);
  }
}

module inside_fillets(size, fillet_r=0) {
  $fn = fillet_fn($fn, fillet_r);
  mirror_y() {
    translate([-size[0]/2,-size[1]/2,0]) fillet(size[0],fillet_r,x_axis);
  }
  mirror_x() {
      translate([-size[0]/2,-size[1]/2,0]) fillet(size[1],fillet_r,y_axis);
  }

  // vericals only if h>0?
  mirror_xy() {
    translate([-size[0]/2,-size[1]/2,0]) fillet(size[2],fillet_r,z_axis);
  }

  // FIXME: extract this into some sort of inside_fillet()-type module
  mirror_xy() {
     difference() {
        translate([-size[0]/2,-size[1]/2,0]) cube([fillet_r,fillet_r,fillet_r]);
        translate([-size[0]/2+fillet_r,-size[1]/2+fillet_r,fillet_r]) sphere(r=fillet_r);
     }
  }
}
