$fn=90;

piX = 88;
piY = 57;
piHorizontalSpacing = 58;
piVerticalSpacing = 49;
piHorizontalOffset = 23 / 2;
vesaHorizontalSpacing = 75;
vesaVerticalSpacing = vesaHorizontalSpacing;

piHoleDiameter = 3.2;
piStandoffDiameter = 7;
piStandoffHeight = 5;
vesaHoleDiameter = 4.5;

mountZ = 3;

module leg() {
  width = 13;
  length = 15;
  difference() {
    union() {
      cylinder(d = width, h = mountZ, center = true);
      translate([length/2, 0, 0]) cube([length, width, mountZ], center = true);
    }
    cylinder(d=vesaHoleDiameter, h = mountZ, center = true);
  }
}

module standoff() {
  difference() {
    cylinder(d = piStandoffDiameter, h = piStandoffHeight, center = true);
    cylinder(d = piHoleDiameter, h = piStandoffHeight, center = true);
  }
}

module vesaMount() {
    
  difference() {
    union() {
      translate([-vesaHorizontalSpacing/2, -vesaVerticalSpacing/2, 0]) rotate([0, 0, 90]) leg();
      translate([vesaHorizontalSpacing/2, -vesaVerticalSpacing/2, 0]) rotate([0, 0, 90]) leg();
      translate([vesaHorizontalSpacing/2, vesaVerticalSpacing/2, 0]) rotate([0, 0, -90]) leg();
      translate([-vesaHorizontalSpacing/2, vesaVerticalSpacing/2, 0]) rotate([0, 0, -90]) leg();
      difference() {
        cube([piX, piY, mountZ], center = true);
        cube([piX - 16, piY - 16, mountZ], center = true);
      }
    }
    translate([-piHorizontalSpacing / 2 + piHorizontalOffset, -piVerticalSpacing / 2, 0]) cylinder(d=piHoleDiameter, h = mountZ, center = true);
    translate([piHorizontalSpacing / 2 + piHorizontalOffset, -piVerticalSpacing / 2, 0]) cylinder(d=piHoleDiameter, h = mountZ, center = true);
    translate([piHorizontalSpacing / 2 + piHorizontalOffset, piVerticalSpacing / 2, 0]) cylinder(d=piHoleDiameter, h = mountZ, center = true);
    translate([-piHorizontalSpacing / 2 + piHorizontalOffset, piVerticalSpacing / 2, 0]) cylinder(d=piHoleDiameter, h = mountZ, center = true);
  }
  
  translate([-piHorizontalSpacing / 2 + piHorizontalOffset, -piVerticalSpacing / 2, (mountZ + piStandoffHeight) / 2]) standoff();
  translate([piHorizontalSpacing / 2 + piHorizontalOffset, -piVerticalSpacing / 2, (mountZ + piStandoffHeight) / 2]) standoff();
  translate([piHorizontalSpacing / 2 + piHorizontalOffset, piVerticalSpacing / 2, (mountZ + piStandoffHeight) / 2]) standoff();
  translate([-piHorizontalSpacing / 2 + piHorizontalOffset, piVerticalSpacing / 2, (mountZ + piStandoffHeight) / 2]) standoff();

}

vesaMount();

