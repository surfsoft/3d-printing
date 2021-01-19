boxX = 62.5;
boxY = 65.5;
boxZ = 280;

slotCount = 4;
slotSeparator = 2.5;
slotSeparatorX = slotSeparator - 0.5;
slotSeparatorY = 5;

innerX = (boxX * slotCount) + (slotSeparator * (slotCount - 1));
innerY = boxY + 10;

z = 15;

outerX = innerX + 10;
outerY = innerY + 10;

module rearFrame() {

    difference() {
        cube([outerX, outerY, z], center = true);
        cube([innerX, innerY, z], center = true);
        translate([(boxX / 2) - (innerX / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
        translate([- (boxX / 2) - (slotSeparator / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
        translate([(boxX / 2) + (slotSeparator / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
        translate([(innerX / 2) - (boxX / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
    };

};

module frontFrame() {

    difference() {
        cube([outerX, outerY, z], center = true);
        cube([innerX, innerY, z], center = true);
        translate([(boxX / 2) - (innerX / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
        translate([- (boxX / 2) - (slotSeparator / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
        translate([(boxX / 2) + (slotSeparator / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
        translate([(innerX / 2) - (boxX / 2), -innerY / 2, 0]) cube([10, 4, z], center = true);
    };

    translate([0, -(innerY - slotSeparatorY) / 2, 0]) cube([slotSeparatorX, slotSeparatorY, z], center = true);
    translate([boxX + slotSeparator, -(innerY - slotSeparatorY) / 2, 0]) cube([slotSeparatorX, slotSeparatorY, z], center = true);
    translate([-(boxX + slotSeparator), -(innerY - slotSeparatorY) / 2, 0]) cube([slotSeparatorX, slotSeparatorY, z], center = true);

};

module bottomFrame() {

    cube([9.5, 200, 2], center = true);
    translate([boxX + slotSeparator, 0, 0]) cube([9.5, 210, 2], center = true);
    translate([(boxX + slotSeparator) * 2, 0, 0]) cube([9.5, 210, 2], center = true);
    translate([(boxX + slotSeparator) * 3, 0, 0]) cube([9.5, 210, 2], center = true);

    translate([((boxX + slotSeparator) * 3) / 2, -87.5, 0.5]) cube([ 10 + (boxX + slotSeparator) * 3, 5, 3], center = true);
    translate([((boxX + slotSeparator) * 3) / 2, 87.5, 0.5]) cube([ 10 + (boxX + slotSeparator) * 3, 5, 3], center = true);

};

translate([0, 98, 0]) rotate([90, 0, 0]) frontFrame();
translate([0, -98, 0]) rotate([90, 0, 0]) rearFrame();
translate([97.5, 0, -38.75]) rotate([0, 180, 0]) bottomFrame();