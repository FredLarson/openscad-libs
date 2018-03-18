include <constants/all.scad>

// FIXME: migrate this all into one vector and update functions to match
heatset_hole_top_diameters = [
    [2, 3.6],
    [2.5, 4.2],
    [3, 5.31],
    [4, 5.99],
    [5, 8],
    [6, 9.22],
    [8, 11.38],
    [0.25*inch, 0.363*inch]
  ];

heatset_hole_bottom_diameters = [
    [2, 3.1],
    [2.5, 3.9],
    [3, 5.1],
    [4, 5.7],
    [5, 7.7],
    [6, 8.9],
    [8, 10.2],
    [0.25*inch, 0.349*inch]
  ];

heatset_hole_depths = [
    [2, 2.9],
    [2.5, 3.4],
    [3, 3.8],
    [4, 4.7],
    [5, 6.7],
    [6, 7.6],
    [8, 14.3],
    [0.25*inch, 0.3*inch]
  ];

// returns the diameter

function heatset_hole_diameter(size) = [
    lookup(size, heatset_hole_top_diameters),
    lookup(size, heatset_hole_bottom_diameters)
  ];

function heatset_hole_depth(size) = lookup(size, heatset_hole_depths);
function heatset_hole_clearance_diameter(size) = size + 0.5;
