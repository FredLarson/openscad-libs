include <constants/all.scad>

// FIXME: migrate this all into one vector and update functions to match
heatset_hole_top_diameters = [
    [2, 3.6],
    [2.5, 4.2],
    [3, 5.3],
    [5, 8],
    [0.25*inch, 0.363*inch]
  ];

heatset_hole_bottom_diameters = [
    [2, 3.1],
    [2.5, 3.9],
    [3, 5.1],
    [5, 7.7],
    [0.25*inch, 0.349*inch]
  ];

heatset_hole_depths = [
    [2, 2.9],
    [2.5, 3.4],
    [3, 3.8],
    [5, 6.7],
    [0.25*inch, 0.3*inch]
  ];

// returns the diameter

function heatset_hole_diameter(size) = [
    lookup(size, heatset_hole_top_diameters),
    lookup(size, heatset_hole_bottom_diameters)
  ];

function heatset_hole_depth(size) = lookup(size, heatset_hole_depths);
function heatset_hole_clearance_diameter(size) = size + 0.5;
