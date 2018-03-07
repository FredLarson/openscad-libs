include <constants/all.scad>

module chamfer(length, r, axis=x_axis) {
  rotates = [[0,90,0],[90,0,0],[0,0,0]];
  mirrors = [[0,0,1],[0,1,0],[0,0,0]];
  mirror(mirrors[axis])
    rotate(rotates[axis]) linear_extrude(length) {
      chamfer_profile(r);
  }
}

module chamfer_profile(r) {
  polygon([[-r,0], [-r,epsilon], [epsilon, epsilon], [epsilon, -r],[0,-r]]);
}

