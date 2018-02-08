use <validation/validate.scad>
include <constants/all.scad>

module hole(h, d, d1, d2, bottom_r=0, top_chamfer=0, top_r=0) {

  function apothem(r, n) = r / cos (180 / n);

  input_top_d = d1 ? d1 : d;
  input_bot_d = d2 ? d2 : d;

  n = max(round(2 * input_top_d), 12, $fn);

  // FIXME: this is silly to deal in d here but apothem in r
  bot_d = apothem(input_bot_d/2.0, n)*2;
  top_d = apothem(input_top_d/2.0, n)*2;

  $fn = n;
  height = h + epsilon;
  d = d ? d : d1;
  translate([0,0,-h]) hull() difference() {

    cylinder(h = height, d1=bot_d, d2=top_d, $fn = n);
    if(bottom_r > 0) {
      validate(bot_d >= 2*bottom_r, "bottom_r must be less than  half x-dimension");
      rotate_extrude($fn=n) translate([d/2-bottom_r, 0]) {
        difference() {
          translate([0, -2*epsilon]) square(bottom_r+2*epsilon);
          translate([0, bottom_r]) circle(r=bottom_r);
        }
      }
    }
  }

  validate(top_chamfer == 0 || top_r == 0, "cannot both chamfer and round top of a hole");
  if(top_chamfer > 0){
    translate([0,0,-top_chamfer]) {
      // FIXME: this hull() is a hack to get around $fn mismatch
      hull()
        rotate_extrude()
          translate([d/2-epsilon,0])
            polygon([[0,0], [0,top_chamfer+epsilon], [top_chamfer+epsilon, top_chamfer+epsilon]]);
    }
  } else if(top_r > 0) {
    translate([0,0,-top_r])
      rotate_extrude()
        translate([d/2-epsilon,0])
          difference() {
            square(top_r+epsilon);
            translate([top_r+epsilon,0]) circle(r=top_r);
          }
  }
}

//hole(h=20,d1=10, d2=5, top_r = 0, bottom_r=0);
