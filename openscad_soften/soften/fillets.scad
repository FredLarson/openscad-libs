include <constants/all.scad>
use <layout/layout.scad>
use <soften/hole.scad>
use <soften/cylinder.scad>

function fillet_fn(fn, r) = ceil(min(fn, r*6) / 4) * 4;

module fillet(length, r, axis=x_axis) {
  // FIXME: this limits $fn in ways that down propagate down and may actually be undesireable
  //$fn = fillet_fn($fn, r);
  //echo("$fn in fillet is: ", $fn);
  // FIXME: this should use fillet_profile instead of doing it's own geometry
  rotates = [[0,90,0],[90,0,0],[0,0,0]];
  mirrors = [[0,0,1],[0,1,0],[0,0,0]];
  mirror(mirrors[axis])
    rotate(rotates[axis]) linear_extrude(length) {
      difference() {
        translate([-epsilon, -epsilon]) square(r+epsilon);
        translate([r,r]) circle(r=r);
      }
  }
}

module chamfer(length, r, axis=x_axis) {
  rotates = [[0,90,0],[90,0,0],[0,0,0]];
  mirrors = [[0,0,1],[0,1,0],[0,0,0]];
  mirror(mirrors[axis])
    rotate(rotates[axis]) linear_extrude(length) {
      chamfer_profile(r);
  }
}

//chamfer(100, 10);

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
        circle(r=r, $fn=500);
    }
}

//fillet_profile(10,120);


module chamfer_profile(r) {
  polygon([[-r,0], [-r,epsilon], [epsilon, epsilon], [epsilon, -r],[0,-r]]);
}


chamfer_profile(10);


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
  $fn = fillet_fn($fn, r);
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

  // this is close but the mesh it renders is a little off, maybe misses epsilon or something?
  // FIXME - should do the ball on the inside corner no matter what
  mirror_xy() {
     difference() {
        translate([-size[0]/2,-size[1]/2,0]) cube([fillet_r,fillet_r,fillet_r]);
        translate([-size[0]/2+fillet_r,-size[1]/2+fillet_r,fillet_r]) sphere(r=fillet_r);
     }
  }
}

*translate([-12.5,-12.5,-1]) difference() {
    cube([25,25,15]);
    translate([2.5,2.5,1]) cube([20,20,15]);
}
*inside_fillets([20,20,14], fillet_r=3);

*fillet(35,5,x_axis);
