$fn = 45;
pegHeight = 17;
pegShortSide = 9;
pegLongSide = sqrt(pegShortSide * pegShortSide * 2);
pinDiameter = 3.5;
mountThickness = 2.5;
mountWidth = 15;
mountHeight = 50;

// Part 1
module mountingPeg() {
    rotate([0, 0, 45]) difference() {
        cube([pegShortSide, pegShortSide, pegHeight], center=true);
        rotate([0, 0, 45]) translate([-(pegLongSide / 4), 0, 0])
          cube([pegLongSide / 2, 20, pegHeight], center = true);
    }
    translate([0, pinDiameter / 2, (pegHeight / 2) + (mountThickness / 2)]) 
      cylinder(d=pinDiameter, h=mountThickness, center = true);
};

// Part 2
module piMount() {
    difference() {
        cube([mountWidth, mountWidth, mountThickness], center = true);
        cylinder(d=pinDiameter + 0.5, h=mountThickness, center = true);
    }
    translate([0, (mountWidth / 2) - (mountThickness / 2), (mountThickness / 2) + (mountHeight / 2)]) 
        cube([mountWidth, mountThickness, mountHeight], center = true);
};

// The whole thing, exploded
module piMount() {
    translate([0, 0, -pegHeight / 2]) mountingPeg();
    translate([0, 3.2, 1 + (mountThickness / 2)]) piMount();
};

mountingPeg();