include <constants/all.scad>
use <layout/layout.scad>
use <soften/hole.scad>
use <soften/cylinder.scad>

x_axis = 0;//[1,0,0];
y_axis = 1;//[0,1,0];
z_axis = 2;//[0,0,1];

function fillet_fn(fn, r) = ceil(min(fn, r*6) / 4) * 4;

module fillet(length, r, axis=x_axis) {
  $fn = fillet_fn($fn, r);
  //echo("$fn in fillet is: ", $fn);
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

module fillet_corner(r=0) {
    render() intersection() {
        fillet(r+epsilon, r, x_axis);
        fillet(r+epsilon,r,y_axis);
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

//fillet_corner(3);
//$fa=1;
//$fs=0.1;
//filleted_cube([25,25,5], fillet_r=1);
*translate([-12.5,-12.5,-1]) difference() {
    cube([25,25,15]);
    translate([2.5,2.5,1]) cube([20,20,15]);
}
*inside_fillets([20,20,14], fillet_r=3);

//fillet(5,1, x_axis);
//fillet_corner(5);

*fillet(35,5,x_axis);



*translate([0,0,2.5]) difference() {
  //$fn=fn(10);
  union () {
      //translate([0,0,-0.5]) cube([20,20,1], center=true);
      soft_cylinder(d=30,h=30,roundover_r=5, fillet_r=10, fillet_arc=180);
  }
  translate([0,0,30]) hole(d=15,h=15, bottom_r=7.5, top_r =1.25);
}
