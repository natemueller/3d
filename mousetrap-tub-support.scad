large_pin_diameter = 5.2;
large_pin_notch = 3.9;
large_pin_height = 11.5;

small_pin_diameter = 3.5;
small_pin_height = 14;
small_pin_cross_width = 1.5;
small_pin_cross_height = 5;

pole_0_height = 112;
pole_1_height = 142;
pole_2_height = 189;

pole_1_offset = 38;
pole_2_offset = 67;

grip_offset = 84.5;
grip_extension = 11.5;
grip_height = 15;
grip_inner_diameter = 7.75;
grip_outer_diameter = 12.75;

grip_0_notch_diameter = 2.25;
grip_1_plate_thickness = 2;
grip_1_plate_diameter = 18;
grip_1_plate_angle = 10;
grip_1_plate_notch = 2;

grip_0_height = 52;
grip_1_height = 160;

$fs = 0.1;

module large_pin() {
  difference() {
    cylinder(h = large_pin_height, d = large_pin_diameter);
    translate([-large_pin_diameter/2, large_pin_diameter - large_pin_notch, 0]) {
      cube([large_pin_diameter, large_pin_diameter, large_pin_height]);
    }
  }
}

module small_pin() {
  cylinder(h = small_pin_height, d = small_pin_diameter);
  translate([0, 0, small_pin_cross_height/2]) cube([large_pin_diameter, small_pin_cross_width, small_pin_cross_height], true);
}

module grip() {
  difference() {
    cylinder(h = grip_height, d = grip_outer_diameter);
    cylinder(h = grip_height, d = grip_inner_diameter);
    translate([-grip_outer_diameter/2, 0, 0]) cube([grip_outer_diameter, grip_outer_diameter/2, grip_height]);
  }
  translate([-grip_inner_diameter/2, 0, grip_height/2]) rotate([0, 270, 0]) cylinder(h = grip_extension+(grip_outer_diameter-grip_inner_diameter)/2, d = large_pin_diameter);
}

large_pin();
translate([pole_2_offset, 0, 0]) large_pin();
translate([pole_2_offset, 0, large_pin_height + pole_2_height]) small_pin();

translate([0, 0, large_pin_height]) cylinder(h = pole_0_height, d = large_pin_diameter);
translate([pole_1_offset, 0, pole_1_height-5]) cylinder(h = large_pin_height+5, d = large_pin_diameter);
translate([pole_2_offset, 0, large_pin_height]) cylinder(h = pole_2_height, d = large_pin_diameter);

translate([0, 0, pole_0_height-6]) rotate([0, 50, 0]) cylinder(h = 87, d = large_pin_diameter);
translate([0, 0, pole_0_height-6]) rotate([0, 130, 0]) cylinder(h = 87, d = large_pin_diameter);
translate([0, 0, large_pin_height+6]) rotate([0, 50, 0]) cylinder(h = 87, d = large_pin_diameter);

translate([grip_offset, 0, grip_0_height]) {
  difference() {
    grip();
    translate([0, 0, grip_height-grip_0_notch_diameter/2]) rotate([90, 0, 0]) cylinder(h = grip_outer_diameter, d = grip_0_notch_diameter);
    translate([0, 0, grip_height]) rotate([90, 0, 0]) cube([grip_0_notch_diameter, grip_0_notch_diameter, grip_outer_diameter], center=true);
  }
}

translate([grip_offset, 0, grip_1_height]) {
  grip();
  rotate([grip_1_plate_angle, 0, 0]) {
    translate([0, 7, grip_height]) {
      difference() {
        cylinder(h = grip_1_plate_thickness, d = grip_1_plate_diameter);
        cylinder(h = grip_1_plate_thickness, d = grip_inner_diameter);
        translate([0, -grip_inner_diameter/2, grip_1_plate_thickness/2]) cube([grip_inner_diameter, grip_inner_diameter, grip_1_plate_thickness], center=true);
        translate([0, -grip_outer_diameter, grip_1_plate_thickness/2]) cube([grip_outer_diameter, grip_outer_diameter, grip_1_plate_thickness], center=true);
        translate([0, grip_inner_diameter/2+grip_1_plate_notch/2, grip_1_plate_thickness/2]) cube([grip_1_plate_notch, grip_1_plate_notch+0.5, grip_1_plate_thickness], center=true);
      }
    }
  }
}
