$fn=90;

module bikeMount() {
    difference() {
        union() {
            cube([40, 30, 5], center=true);
            translate([-20, 0, 0]) cylinder(r=15, h=5, center = true);
            translate([20, 0, 0]) cylinder(r=15, h=5, center = true);
        };
        translate([-27.5, 0, 0]) cylinder(r=2.5, h=5, center = true);
        translate([27.5, 0, 0]) cylinder(r=2.5, h=5, center = true);
    };
};

module innerRadius(radius, depth) {
    intersection() {
        difference() {
            cube([radius, radius, depth], center=true);
            translate([-radius / 2, -radius / 2, 0]) cylinder(r=radius, h=depth, center=true);
        };
        translate([radius / 3, 0, 0]) cube([radius / 3, radius, depth], center=true);
    };
};

module lightClip() {
    width=26;
    depth=26;
    difference() {
        cube([width, depth, 6], center = true);
        translate([0, 2.5, 0]) cube([20.5, depth, 6], center = true);
    };
    translate([7.5, 1.25, 0]) rotate([90, 0, 0]) innerRadius(6, 23.5);
    translate([-7.5, 1.25, 0]) rotate([90, 0, 180]) innerRadius(6, 23.5);
};

translate([0, 0, -2.5]) bikeMount();
translate([0, 0, 3]) lightClip();