module arm(length, depth, screwHoleDiameter, screwHoleBorder, spindleThicknessAllowance) {
    width = screwHoleDiameter + (2 * screwHoleBorder);
    endRadius = (screwHoleDiameter / 2) + screwHoleBorder ;
        difference() {
            union() {
                translate([(length - endRadius) / 2, 0, 0]) cube([length - endRadius, width, depth], center=true);
                translate([length - endRadius, 0, 0]) rotate([0, 0, -90])  cylinder( h=depth, r=endRadius, center = true);
            };
            translate([length - endRadius, 0, 0]) rotate([0, 0, -90])  cylinder(h=depth, d=screwHoleDiameter, center = true);
            translate([length - endRadius, 0, endRadius / 2]) cube([width, width, depth - endRadius], center=true);
            translate([length - width, 0, depth / 2]) rotate([90, 0, 0]) resize([(length - endRadius - spindleThicknessAllowance) * 2, (depth - endRadius) * 2, width + 1]) cylinder(r=depth - width, h=width + 1, center=true);
        };
};

module arms(innerDiameter, armLength, armDepth, screwHoleDiameter, screwHoleBorder, count = 4) {
    armAngle = 360 / count;
    for( i = [ 0 : count - 1 ]) {
        rotate([0, 0, armAngle * i]) translate([innerDiameter / 2, 0, 0]) arm(armLength - (innerDiameter / 2), armDepth, screwHoleDiameter, screwHoleBorder, (innerDiameter / 2) - 1);
    };
};

module spindle(innerDiameter, thickness, length, screwHoleDiameter, screwHoleOffset) {
    outerDiameter = innerDiameter  + (thickness * 2);
    difference() {
        cylinder(d=outerDiameter, h=length, center=true);
        cylinder(d=innerDiameter, h=length, center=true);
        translate([0, 0, (length / 2) - screwHoleOffset]) rotate([0, 90, 45]) cylinder(d=screwHoleDiameter, h=outerDiameter, center=true );
    }
};

module vesaAdapter(vesaMountSize, spindleLength, spindleInnerDiameter, spindleScrewHoleDiameter, spindleScreHoleOffset, armScrewHoleDiameter, spindleThickness = 5) {
    armScrewHoleBorder = armScrewHoleDiameter / 2;
    armLength = sqrt(vesaMountSize * vesaMountSize / 2) + (armScrewHoleDiameter / 2) + armScrewHoleBorder;
    spindle(spindleInnerDiameter, spindleThickness, spindleLength, spindleScrewHoleDiameter, spindleScreHoleOffset);
    arms(spindleInnerDiameter, armLength, spindleLength, armScrewHoleDiameter, armScrewHoleBorder);
};