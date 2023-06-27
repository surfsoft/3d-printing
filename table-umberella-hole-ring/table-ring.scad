$fn = 90;

lipDiameter=47;
innerDiameter=lipDiameter - 6;
outerDiameter = innerDiameter + 20;
topDepth = 3;
lipDepth = 10;

translate([0, 0, -topDepth / 2])
difference() {
cylinder(d=outerDiameter, h=topDepth, center=true);
cylinder(d=innerDiameter, h=topDepth, center=true);
}

translate([0, 0, lipDepth / 2])
difference() {
cylinder(d=lipDiameter, h=lipDepth, center=true);
cylinder(d=innerDiameter, h=lipDepth, center=true);
}    
