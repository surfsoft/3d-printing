$fn=360;

largerDiameter = 62.5;
smallerDiameter = 34;
endLength = 10;
adapterLength = 50;
wallThickness = 3;

difference() {
    cylinder(d=largerDiameter + (wallThickness * 2), h=endLength, center=true);
    cylinder(d=largerDiameter, h=endLength, center=true);
}

translate([0, 0, (endLength + adapterLength) / 2])
difference() {
    cylinder(d1=largerDiameter + (wallThickness * 2), d2=smallerDiameter + (wallThickness * 2), h=adapterLength, center=true);
    cylinder(d1=largerDiameter, d2=smallerDiameter, h=adapterLength, center=true);
}

translate([0, 0, adapterLength + endLength])
difference() {
    cylinder(d=smallerDiameter + (wallThickness * 2), h=endLength, center=true);
    cylinder(d=smallerDiameter, h=endLength, center=true);
}
