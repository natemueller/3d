ball_radius = 8.5;

finger_separation = 12;
finger_depth = 10;
finger_width = 3;
finger_height = 20;
taper_height = finger_height+5;

bed_thickness = 3.25;
bed_to_ball = 28;

vertical_offset = 30;

gripper_height = 15;
gripper_width = 25;
gripper_depth = 16;
bed_inset = 13;
bed_offset = 8;

swoop_height = bed_to_ball + bed_thickness + bed_offset + ball_radius;
base_width = finger_separation + finger_width*2;
taper_width = (gripper_width-base_width)/2;

$fn = 100;

module body_2d() {
  difference() {
    square([gripper_depth, gripper_height]);
    translate([0, bed_offset]) square([bed_inset, bed_thickness]);
    translate([0, gripper_height]) rotate([0, 0, 45]) square([10, 10], true);
  }

  translate([gripper_depth, swoop_height]) {
    intersection() {
      difference() {
        resize([vertical_offset*2, swoop_height*2]) circle(r=1);
        resize([(vertical_offset-finger_depth)*2, (swoop_height-gripper_height)*2]) circle(r=1);
      }
      translate([0, -swoop_height]) square([vertical_offset, swoop_height]);
    }
  }
}

difference() {
  linear_extrude(gripper_width) body_2d();

  translate([vertical_offset+gripper_depth-finger_depth*0.5, swoop_height-ball_radius+2, gripper_width/2]) sphere(ball_radius);
  translate([vertical_offset+gripper_depth-finger_depth*2, swoop_height-finger_height, finger_width + (gripper_width-base_width)/2]) cube([finger_depth*2, finger_height, finger_separation]);

  translate([vertical_offset+gripper_depth-finger_depth*2, swoop_height-taper_height, 0]) cube([finger_depth*4, taper_height, taper_width]);
  translate([vertical_offset+gripper_depth-finger_depth*2, swoop_height-taper_height, gripper_width-taper_width]) cube([finger_depth*4, taper_height, taper_width]);
}
