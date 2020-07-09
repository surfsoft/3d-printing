$fn = 90;

insideCorrection = 0.2;
outsideCorrection = 0.05;

pegDiameter = 10;
pegHeight = 30;

screwDiameter = 4;
screwHeadDiameter = 9;
screwHeadDepth = 4;

backplateDiameter = 50;
backplateDepth = 6;
screwSpacing = 30;

headMountPegX = pegDiameter + 8;
headMountPegY = 25;

headMountSocketX = headMountPegX + 0.1;
headMountSocketY = headMountPegY + 0.1;

headMountBackplateHeight = headMountSocketY + 5;
headMountLength = 25;
headMountBackplateOffset = 5;
headMountWidth = headMountPegX;
headMountEndHeight = 10;



module screwHole(screwDiameter, screwDepth, headDiameter, headDepth) {
    
    cylinder(h=screwDepth, d=screwDiameter, center=true);
    translate([0, 0, (screwDepth - headDepth) / 2]) cylinder(h=headDepth, r1=screwDiameter / 2, r2=headDiameter / 2, center=true);
    
};

module backplate() {
    difference() {
        cylinder(h=backplateDepth, d=backplateDiameter, center=true);
        union() {
            cube([headMountSocketX + (insideCorrection * 1.5), headMountSocketY + (insideCorrection * 1.5), backplateDepth], center=true);
            translate([-screwSpacing / 2, 0, 0]) screwHole(screwDiameter, backplateDepth, screwHeadDiameter, screwHeadDepth);
            translate([screwSpacing / 2, 0, 0]) screwHole(screwDiameter, backplateDepth, screwHeadDiameter, screwHeadDepth);
        }
    }
};


module bracket() {
    cube([headMountPegX, headMountPegY, backplateDepth], center=true);
    translate([0, (headMountPegY / 2) + 1, backplateDepth / 2])
    rotate([0, 90, 0])
    resize([0, headMountPegY + ((backplateDiameter - headMountPegY)) / 2, 0])
    difference() {
        intersection() {
            translate([-25, -25, 0]) cube([50, 50, headMountPegX], center=true);
            cylinder(h=headMountPegX, d=100, center=true);
        };
        translate([-(50 - 4 - (pegDiameter / 2)), 0, 0]) rotate([90, 0, 0]) cylinder(h=100, d=pegDiameter + 0.15, center=true);
    }
};

module peg() {
    difference() {
        cylinder(h=pegHeight, d=pegDiameter - (outsideCorrection * 2), center=true);
        cylinder(h=pegHeight, d=3 + (insideCorrection * 2), center=true);
    }
};


//translate([0, 0, backplateDepth / 2]) backplate();
//translate([0, 0, backplateDepth / 2]) mount();
//translate([0, 15, (50 + backplateDepth - 4 - (pegDiameter / 2))]) rotate([90, 0, 0]) pegv2();


//backplate();
//rotate([0, -90, 0]) bracket();
//peg();