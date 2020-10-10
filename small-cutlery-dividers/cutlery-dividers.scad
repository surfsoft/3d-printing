module wedge(x, y, z0, z1) {
    angleZ = (z1 > y) ? acos(y / z1) : atan(z1 / y);
    translate([-x / 2, -y / 2, -(z0 + z1) / 2])
    difference() {
        cube([x, y, z0 + z1]);
        translate([0, 0, z0]) rotate([angleZ, 0, 0]) cube([x, y * 10, z1]);
    };
};

module divider(length, depth = 40, topWidth = 2, bottomWidth = 4) {
    rotate([-90, 0, 0])
        union() {
            translate([0, 0, (topWidth + bottomWidth) / 4]) wedge(length, depth, topWidth / 2, bottomWidth / 2);
            translate([0, 0, -(topWidth + bottomWidth) / 4]) rotate([0, 180, 0]) wedge(length, depth, topWidth / 2, bottomWidth / 2);
        }
};

module sideProfile(depth=40, maxDepth=70) {
    rotate([90, 180, -90])
        union() {
            wedge(10, maxDepth, 0, 15);
            translate([0, (maxDepth - 24) / 2, 3]) wedge(10, 24, 0, 21);
        };
};

module drawerDivider() {
    divider(220);
    translate([127.5, -80, 0]) divider(474);
    translate([110, 0, 0]) rotate([0, 0, 90]) difference() {
        divider(160);
        translate([79, 0, 14.9]) sideProfile();
    };
    translate([130, -110, 0]) rotate([0, 0, 90]) difference() {
        divider(60);
        translate([-29, 0, 14.9]) rotate([0, 0, 180]) sideProfile();
    };
    translate([165, 0, 0]) rotate([0, 0, 90]) difference() {
        divider(160);
        translate([79, 0, 14.9]) sideProfile();
    };
    translate([265, 0, 0]) divider(200);
};


module partOne() {
    intersection() {
        cube([220, 300, 40], center=true);
        drawerDivider();    
    };
};

module partTwo() {
    intersection() {
        difference() {
            cube([800, 300, 40], center=true);
            cube([330, 300, 40], center=true);
        };
        drawerDivider();    
    };
};

module partThree() {
    intersection() {
        translate([137.5, 0, 0]) cube([55, 400, 40], center=true);
        drawerDivider();    
    };
};

partOne();
partTwo();
partThree();
