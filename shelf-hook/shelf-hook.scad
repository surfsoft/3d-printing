$fn=90;

shelfHeight = 38;
mountDepth = 25;
mountWidth = 15;
mountThickness = 5;

mountInnerHeight = shelfHeight + 0.5;
mountOuterHeight = mountInnerHeight + (2 * mountThickness);
mountInnerDepth = mountDepth;
mountOuterDepth = mountInnerDepth + mountThickness;

hookThickness = mountThickness;
hookHeight = 30;
hookInnerDiameter = 20;
hookOuterDiameter = hookInnerDiameter + (mountThickness * 2);



difference() {
    cube([mountOuterDepth, mountOuterHeight, mountWidth], center = true);
    translate([mountThickness / 2, 0, 0]) cube([mountInnerDepth, mountInnerHeight, mountWidth], center = true);
    translate([- (mountOuterDepth - (mountThickness / 2)) / 2, (mountOuterHeight - (mountThickness / 2)) / 2, 0]) cube([mountThickness / 2, mountThickness / 2, mountWidth], center = true);
};

translate([- (mountOuterDepth - mountThickness) / 2, (mountOuterHeight - mountThickness) / 2, 0]) cylinder(d = mountThickness, h = mountWidth, center = true);

translate([- (mountInnerDepth - (mountThickness * 2)) / 2, (mountInnerHeight - mountThickness) / 2, 0])
difference() {
    translate([-mountThickness / 4, mountThickness / 4, 0]) cube([mountThickness / 2, mountThickness / 2, mountWidth], center = true);
    cylinder(d = mountThickness, h = mountWidth, center = true);
};


translate([- (mountInnerDepth - (mountThickness * 2)) / 2, -(mountInnerHeight - mountThickness) / 2, 0])
difference() {
    translate([-mountThickness / 4, -mountThickness / 4, 0]) cube([mountThickness / 2, mountThickness / 2, mountWidth], center = true);
    cylinder(d = mountThickness, h = mountWidth, center = true);
};


translate([-(hookOuterDiameter / 2) - (mountOuterDepth / 2) + mountThickness, - (mountOuterHeight - hookOuterDiameter) / 2, 0])
difference() {
    cylinder(d = hookOuterDiameter, h = mountWidth, center = true);
    cylinder(d = hookInnerDiameter, h = mountWidth, center = true);
    translate([0, hookOuterDiameter / 4, 0]) cube([hookOuterDiameter, hookOuterDiameter / 2, mountWidth], center = true);
};

translate([-((mountOuterDepth + (hookOuterDiameter / 2)) / 2) + mountThickness, -(mountOuterHeight / 2) + (hookOuterDiameter / 4), 0])
difference() {
    cube([hookOuterDiameter / 2, hookOuterDiameter / 2, mountWidth], center = true);
    translate([-hookOuterDiameter / 4, hookOuterDiameter / 4, 0]) cylinder(d = hookInnerDiameter, h = mountWidth, center = true);
};


translate([(mountInnerDepth + mountThickness) / 2, (mountInnerHeight  + mountThickness) / 2, 0])
cylinder(d=mountThickness, h=mountWidth, center = true);

translate([(mountInnerDepth + mountThickness) / 2, - (mountInnerHeight  + mountThickness) / 2, 0])
cylinder(d=mountThickness, h=mountWidth, center = true);

translate([- (mountInnerDepth / 2) - hookInnerDiameter - mountThickness, - (mountOuterHeight - hookOuterDiameter) / 2, 0])
cylinder(d=mountThickness, h=mountWidth, center = true);

