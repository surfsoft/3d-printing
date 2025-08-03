$fn=90;

verticalSeparation = 74;
horizontalSeparation = 64;
standoffHeight = 15;
standoffOuterRadius = 5;
standoffInnerRadius = 2;
screwRadius = 1.7;

frameWidth = horizontalSeparation + 2 * standoffOuterRadius;
frameDepth = 110;
frameThickness = 3;
frameCornerRadius = 5;
frameInnerWidth = 10;

module standoff(height, innerRadius, outerRadius) {
    difference() {
        cylinder(h=height, r=outerRadius, center=true);
        cylinder(h=height, r=innerRadius, center=true);
    }
}

module standoffs() {
    translate([-horizontalSeparation/2, -verticalSeparation/2, -standoffHeight / 2])
    for (x = [0:1]) {
        for (y = [0:1]) {
            translate([x * horizontalSeparation, y * verticalSeparation, 0]) 
              standoff(standoffHeight, standoffInnerRadius, standoffOuterRadius);
        }
    }
}

module roundedRectangle(width, depth, thickness, cornerRadius) {
    cube(size=[width - (cornerRadius* 2), depth, thickness], center = true);    
    cube(size=[width, depth - (cornerRadius* 2), thickness], center = true);    
    for (x = [-1:2:1]) {
        for (y = [-1:2:1]) {
            translate([((width / 2 - cornerRadius) * x), ((depth / 2 - cornerRadius) * y), 0])
              cylinder(h=thickness, r=cornerRadius, center = true);
        }
    }
}

module frame(width, depth, thickness, cornerRadius, screwRadius) {
    translate([0, 0, thickness / 2])
    difference() {
    difference() {
        roundedRectangle(width, depth, thickness, cornerRadius);
        roundedRectangle(width - (frameInnerWidth * 2), depth - (frameInnerWidth * 2), thickness, cornerRadius);
    }
    union() {
        for (y = [-1:2:1]) {
            translate([0, (depth / 2 - (frameInnerWidth / 2)) * y, 0])
              cylinder(thickness, r=screwRadius, center=true);
        }
    }
    }
}
    

standoffs();
frame(frameWidth, frameDepth, frameThickness, frameCornerRadius, screwRadius);