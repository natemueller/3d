/* Measurements from the TiVo */
hole_separation = 125;
max_diameter = 9;
min_diameter = 4.5;
hole_depth = 8;
pad_height = 3.5;

/* Measurements for the mount */
plate_thickness = 2;
cap_diameter = max_diameter - 1.5;
shaft_diameter = min_diameter - 1;
pin_height = hole_depth * 2/3;
cap_height = pin_height - hole_depth*0.5;

screw_head_diameter = 12;
screw_shaft_diameter = 5;

$fs = 0.1;

module pin() {
  cylinder(h = pin_height, d = shaft_diameter);
  translate([0, 0, pin_height - cap_height]) {
    cylinder(h = cap_height, d1 = cap_diameter, d2 = cap_diameter*0.9);
  }
}

module screw_hole() {
  translate([0, 0, 1]) cylinder(h = 2, d = screw_head_diameter);
  translate([0, 0, -1]) cylinder(h = plate_thickness + 2, d = screw_shaft_diameter);
}

rotate([90, 0, 0]) {
  difference() {
    linear_extrude(plate_thickness) {
      hull() {
        circle(10);
        translate([hole_separation, 0, 0]) circle(10);
      }
    }

    translate([20, 0, 0]) screw_hole();
    translate([hole_separation - 20, 0, 0]) screw_hole();
  }

  translate([0, 0, plate_thickness]) {
    pin();
    translate([hole_separation, 0, 0]) pin();
  }
}
