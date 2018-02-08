include <constants/all.scad>
include <soften/fillets.scad>

module circular_fillet(d,r=5, angle=360) {
  rotate_extrude(angle=angle)
    translate([d/2,0])
      difference() {
        $fn = fillet_fn($fn, r);
        translate([-epsilon, -epsilon]) square(r+epsilon);
        translate([r,r]) circle(r=r);
      }
}

module soft_cylinder(d, r, h,
                     d1, d2, chamfer=0,
                     roundover_r=0, fillet_r=0,
                     fillet_angle=360) {
  my_d = d ? d : d1;
  d1 = d1 ? d1 : my_d;
  d2 = d2 ? d2 : my_d;
  $fn = fn(my_d/2+fillet_r);
  hull() difference() {
    union() {
      height = fillet_r ? h + epsilon : h;
      translate([0,0,fillet_r? -epsilon : 0]) cylinder(d1=d1,d2=d2,h=height);
    }
    if(chamfer > 0) {
      rotate_extrude()
        translate([d/2,h-chamfer])
          polygon([ [epsilon,epsilon],
                    [-chamfer-epsilon, chamfer+epsilon],
                    [epsilon, chamfer]]);
    }
    else if(roundover_r > 0) {
      rotate_extrude()
        translate([d/2-roundover_r,h-roundover_r])
          difference() {
            square(roundover_r+2*epsilon);
            circle(r=roundover_r);
          }
    }
  }
  if(fillet_r > 0) {
    circular_fillet(d=d, r=fillet_r, angle=fillet_angle);
  }
}

//soft_cylinder(d1=10, d2=5, h=15,roundover_r=0, fillet_r=0, fillet_angle=360);
//soft_cylinder(d=12, h=15,roundover_r=5, fillet_r=3);
