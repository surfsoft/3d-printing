$fn=90;

module outerCornerRadius(radius, depth) {
    intersection() {
        cylinder(r=radius, h=depth, center=true);
        translate([radius / 2, radius / 2, 0]) cube([radius, radius, depth], center=true);
    };    
};

module innerCornerRadius(radius, depth) {
    difference() {
        cube([radius, radius, depth], center=true);
        translate([-radius / 2, -radius / 2, 0]) cylinder(r=radius, h=depth, center=true);
    };
};

module box(boxHeight, boxDepth, width, thickness) {
    hangerInnerRadius = thickness / 2;
    hangerOuterRadius = thickness;
    boxOuterDepth = boxDepth + thickness - hangerOuterRadius;
    boxOuterHeight = boxHeight + thickness - hangerOuterRadius;
    if (thickness > hangerOuterRadius) {
        difference() {
            cube([boxOuterDepth, boxOuterHeight, width], center=true);
            cube([boxDepth, boxHeight, width], center=true);
        };
    };
    
    translate([0, (boxOuterHeight + hangerOuterRadius) / 2, 0])
      cube([boxOuterDepth, hangerOuterRadius, width], center = true);
    translate([0, -(boxOuterHeight + hangerOuterRadius) / 2, 0])
      cube([boxOuterDepth, hangerOuterRadius, width], center = true);
    translate([(boxOuterDepth + hangerOuterRadius) / 2, 0, 0])
      cube([hangerOuterRadius, boxOuterHeight, width], center = true);
    translate([- (boxOuterDepth + hangerOuterRadius) / 2, 0, 0])
      cube([hangerOuterRadius, boxOuterHeight, width], center = true);
    
    translate([boxOuterDepth / 2, boxOuterHeight / 2, 0])
      outerCornerRadius(hangerOuterRadius, width);
    translate([-boxOuterDepth / 2, boxOuterHeight / 2, 0])
      rotate([0, 0, 90])
      outerCornerRadius(hangerOuterRadius, width);
    translate([boxOuterDepth / 2, -boxOuterHeight / 2, 0])
      rotate([0, 0, -90])
      outerCornerRadius(hangerOuterRadius, width);
    translate([-boxOuterDepth / 2, -boxOuterHeight / 2, 0])
      rotate([0, 0, 180])
      outerCornerRadius(hangerOuterRadius, width);

    translate([(boxDepth - hangerInnerRadius) / 2, (boxHeight - hangerInnerRadius) / 2, 0])
      innerCornerRadius(hangerInnerRadius, width);
    translate([-(boxDepth - hangerInnerRadius) / 2, (boxHeight - hangerInnerRadius) / 2, 0])
      rotate([0, 0, 90])
      innerCornerRadius(hangerInnerRadius, width);
    translate([(boxDepth - hangerInnerRadius) / 2, -(boxHeight - hangerInnerRadius) / 2, 0])
      rotate([0, 0, -90])
      innerCornerRadius(hangerInnerRadius, width);
    translate([-(boxDepth - hangerInnerRadius) / 2, -(boxHeight - hangerInnerRadius) / 2, 0])
      rotate([0, 0, 180])
      innerCornerRadius(hangerInnerRadius, width);
    
};

module hanger(height, depth, width, thickness) {
    
    endRaduis = thickness / 2;
    translate([-endRaduis, (height + thickness) / 2, 0]) 
      cube([depth, thickness, width], center=true);
    translate([(depth / 2) - endRaduis, (height + thickness) / 2, 0]) 
      cylinder(r=endRaduis, h=width, center = true);
    
    translate([-(depth + thickness) / 2, 0, 0])
      cube([thickness, height + thickness, width], center = true);
    
    translate([-(depth + thickness) / 2, (height + thickness) / 2, 0])
      rotate([0, 0, 90])
      outerCornerRadius(endRaduis, width);
    translate([-(depth - endRaduis) / 2, (height - endRaduis) / 2, 0])
      rotate([0, 0, 90])
      innerCornerRadius(endRaduis, width);

    translate([-endRaduis * 1.5, -(height + thickness) / 2, 0]) 
      cube([depth + endRaduis, thickness, width], center=true);
    translate([(depth / 2) - endRaduis, -(height + thickness) / 2, 0]) 
      cylinder(r=endRaduis, h=width, center = true);

    translate([-(depth - endRaduis) / 2, -(height - endRaduis) / 2, 0])
      rotate([0, 0, 180])
      innerCornerRadius(endRaduis, width);

};


module boxHanger(shelfHeight, shelfDepth, boxHeight, boxWidth, hangerWidth, hangerThickness) {

    translate([0, -(boxHeight + hangerThickness) / 2, 0])
      box(boxHeight, boxWidth, hangerWidth, hangerThickness);

    translate([((boxWidth + (2 * hangerThickness)) / 2) + (hangerThickness / 4), -hangerThickness * 0.75 , 0])
      rotate([0, 0, 90])
      innerCornerRadius(hangerThickness / 2, hangerWidth);

    translate([(shelfDepth - boxWidth) / 2, (shelfHeight + hangerThickness) / 2, 0])
      hanger(shelfHeight, shelfDepth, hangerWidth, hangerThickness);
};

shelfHeight = 26.5;
shelfDepth = 40;
psuHeight = 80;
psuWidth = 30;
hangerWidth = 15;
hangerThickness = 5;

boxHanger(shelfHeight, shelfDepth, psuHeight, psuWidth, hangerWidth, hangerThickness);
