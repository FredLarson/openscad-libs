module mirror_x() {
  children();
  mirror([1, 0, 0]) children();
}

module mirror_y() {
  children();
  mirror([0, 1, 0]) children();
}

module mirror_z() {
  children();
  mirror([0, 0, 1]) children();
}

module mirror_xy() {
  mirror_x() mirror_y() children();
}

module mirror_xz() {
  mirror_x() mirror_z() children();
}

module mirror_yz() {
  mirror_y() mirror_z() children();
}

module mirror_xyz() {
  mirror_x() mirror_y() mirror_z() children();
}

module repeat_with_offset(offset, iterations=1) {
  for(i = [0:iterations-1]) {
    translate(offset * i)
      children();
  }
}

//repeat_with_offset([10,0,0], 3) {
//  $fn=100;
//  cylinder(d=5,h=10);
//}[ 0.00, 0.00, 0.00 ]
