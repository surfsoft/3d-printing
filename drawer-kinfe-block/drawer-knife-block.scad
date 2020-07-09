$fn = 10;

module roundedCube(x, y, z, r=5) {
    
    cube([x - (r * 2), y - (r * 2), z], center = true);
    translate([0, (y - r) / 2, 0]) cube([x - (r * 2), r, z], center = true);
    translate([0, -(y - r) / 2, 0]) cube([x - (r * 2), r, z], center = true);
    translate([(x - r) / 2, 0, 0]) cube([r, y - (r * 2), z], center = true);
    translate([-(x - r) / 2, 0, 0]) cube([r, y - (r * 2), z], center = true);
    
    translate([(x - (2 * r))/ 2, (y - (2 * r)) / 2, 0]) cylinder(r = r, h = z, center = true);
    translate([(x - (2 * r))/ 2, -(y - (2 * r)) / 2, 0]) cylinder(r = r, h = z, center = true);
    translate([-(x - (2 * r))/ 2, (y - (2 * r)) / 2, 0]) cylinder(r = r, h = z, center = true);
    translate([-(x - (2 * r))/ 2, -(y - (2 * r)) / 2, 0]) cylinder(r = r, h = z, center = true);
    
};

overallX = 178;
y = 20;
baseZ = 3;
topZ = 25;
topX1 = 19;
topX2 = 40;
topX3 = 17.5;
spaceX = 5;
separation = 150;

translate([0, -(separation - y) / 2, 0])
union() {
    roundedCube(overallX, y, baseZ);
    translate([0, 0, ((baseZ + topZ) / 2)]) {
        translate([-(overallX - topX1) / 2, 0, 0]) roundedCube(topX1, y, topZ);
        translate([-(topX2 + spaceX), 0, 0]) roundedCube(topX2, y, topZ);
        roundedCube(topX2, y, topZ);
        translate([(topX2 + spaceX), 0, 0]) roundedCube(topX2, y, topZ);
        translate([(overallX - topX1) / 2, 0, 0]) roundedCube(topX1, y, topZ);
    };
};

translate([0, (separation - y) / 2, 0])
union() {
    roundedCube(overallX, y, baseZ);
    translate([0, 0, ((baseZ + topZ) / 2)]) {
        translate([-(overallX - topX1) / 2, 0, 0]) roundedCube(topX1, y, topZ);
        translate([-((topX3 + spaceX) / 2 + (spaceX + topX3) * 2), 0, 0]) roundedCube(topX3, y, topZ);
        translate([-((topX3 + spaceX) / 2 + spaceX + topX3), 0, 0]) roundedCube(topX3, y, topZ);
        translate([-(topX3 + spaceX) / 2, 0, 0]) roundedCube(topX3, y, topZ);
        translate([(topX3 + spaceX) / 2, 0, 0]) roundedCube(topX3, y, topZ);
        translate([(topX3 + spaceX) / 2 + spaceX + topX3, 0, 0]) roundedCube(topX3, y, topZ);
        translate([(topX3 + spaceX) / 2 + (spaceX + topX3) * 2, 0, 0]) roundedCube(topX3, y, topZ);
        translate([(overallX - topX1) / 2, 0, 0]) roundedCube(topX1, y, topZ);
    };
};

translate([(topX3 + spaceX) / 2 + (spaceX + topX3) * 2, 0, 0]) cube([5, separation, baseZ], center = true);
translate([-((topX3 + spaceX) / 2 + (spaceX + topX3) * 2), 0, 0]) cube([5, separation, baseZ], center = true);