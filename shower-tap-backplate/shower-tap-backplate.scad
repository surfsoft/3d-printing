$fn=90;

difference() {
  cube([30, 30, 2.5], center=true);
  cylinder(d=14.5, h=2.5, center=true);
  translate([9.5, -9.5, 0]) cylinder(d=4, h=2.5, center=true);
  translate([0, 7.5, 0]) cube([3.2, 15, 2.5], center=true);
  translate([0, 7.5, 5 - 1.25]) rotate([90, 0, 0]) cylinder(d=10, h=15, center=true); 
}
