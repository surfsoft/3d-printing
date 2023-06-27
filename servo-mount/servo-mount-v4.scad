$fn=30;

module screwHole() {  
    union() {
        translate([-0.9, 0, 0]) cylinder(d=3.5, h=3, center = true);
        cube([1.8, 3.5, 3], center = true);
        translate([0.9, 0, 0]) cylinder(d=3.5, h=3, center = true);
    };
};

module mainBase() {
    difference() {
        union() {
            cube([33.4, 14.7, 3], center = true);
            translate([-16.7, 3.5, 0,]) cylinder(d=7.7, h=3, center = true);
            translate([16.7, 2.6, 0]) cube([7.7, 1.8, 3], center = true);
            translate([16.7, 3.5, 0]) cylinder(d=7.7, h=3, center = true);
            translate([16.7, 1.7, 0]) cylinder(d=7.7, h=3, center = true);
        };
        translate([16.7, 2.6, 0]) rotate([0, 0, 90]) screwHole();
        translate([-16, 3.5, 0]) screwHole();
    };
};


module pushrodSupport() {
    difference() {
        union() {
            translate([0, 0, -1.5]) cube([10, 9, 3], center = true);
            translate([0, 1.5, 1]) cube([10, 6, 2], center = true);
        }
        translate([0, 1.5, -1.5]) cube([10, 2, 3], center = true);
    };
};

module servoMount() {
    difference() {
        cube([5, 4, 10], center = true);
        translate([0, 0, 1]) rotate([90, 0, 0]) cylinder(d=2, h=4, center = true);
    };
};

mainBase();
translate([5 - 16.2 , 4.5 + 7.35, 1.5]) pushrodSupport();
translate([2.5 - 16.7, 2 - 7.35, 5 + 1.5]) servoMount();
translate([- 2.5 + 16.7, 2 - 7.35, 5 + 1.5]) servoMount();