$fn = 90;
innerDiameter = 29;
middleDiameter = 42;
middleHeight = 4;
outerDiameter = 62;
outerHeight = 2;


difference() {
union() {
    cylinder(d=outerDiameter, h=outerHeight, center=true);
    translate([0, 0, middleHeight / 2]) cylinder(d=middleDiameter, h=middleHeight, center=true);
}
cylinder(d=innerDiameter, h=middleHeight + 10, center=true);
}