$fn = 90;

difference() {
  union() {
    translate([30, 0, 0]) cube([70, 10, 2], center = true);
    translate([0, 0, 2]) cube([10, 10, 2], center = true);
  }
  translate([20, 0, 0]) cylinder(2, d=2, center = true);  
  translate([40, 0, 0]) cylinder(2, d=2, center = true);  
  translate([60, 0, 0]) cylinder(2, d=2, center = true);  
}