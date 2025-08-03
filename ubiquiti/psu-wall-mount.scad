$fn=90;


module roundedRectangle(length, width, height, cornerRadius=0) {
    if (cornerRadius > 0) {
        cube([length, width - (cornerRadius * 2), height], center=true);
        cube([length - (cornerRadius * 2), width, height], center=true);
        for (xCorner = [-((length / 2) - cornerRadius), (length / 2) - cornerRadius])
            for (yCorner = [-((width / 2) - cornerRadius), (width / 2) - cornerRadius])
        translate([xCorner, yCorner, 0]) cylinder(r=cornerRadius, h=height, center=true);
            
    }
}

module screwHeadRecess(headDiameter, headHeight, shaftDiameter, shaftHeight) {
    headX = shaftHeight / 2;
    shaftX = headHeight / 2;
    translate([0, 0, headX]) cylinder(d=headDiameter, h=headHeight, center = true);
        translate([0, 0, -shaftX]) cylinder(d=shaftDiameter, h=shaftHeight, center = true);
}

length=66.5;
width=66.5;
height=30;
radius=12;
wallThickness = 3;
screwHeadDiameter = 9.4;
screwHeadHeight = 4;
screwShaftDiameter = 4.5;
screwShaftHeight = 2;
powerCableWidth = 25;
mountThickness = screwHeadHeight + screwShaftHeight;
overallLength = length + (wallThickness * 2);
overallWidth = width + wallThickness;
overallHeight = height + mountThickness;
overallRadius = radius + wallThickness;
retainerWidth = wallThickness * 0.7;
retainerLength = 10;

difference() {
    roundedRectangle(overallLength, overallWidth, overallHeight, overallRadius);
    for (xScrew = [-width * 0.25, width * 0.25])
        translate([xScrew, 0, -height / 2]) 
          screwHeadRecess(screwHeadDiameter, screwHeadHeight, screwShaftDiameter, screwShaftHeight);
    translate([0, wallThickness / 2, mountThickness/ 2]) 
        roundedRectangle(length, width, height, radius);
    translate([0, -((overallWidth - wallThickness) / 2), mountThickness/ 2])
        cube([powerCableWidth, wallThickness, height], center=true);
    translate([0, (overallWidth - radius - wallThickness) / 2, 0])    
        cube([overallLength, radius + wallThickness, overallHeight], center = true);
}


translate([-(width + retainerWidth) / 2, 0, overallHeight / 2]) rotate([90, -30, 0]) cylinder(r=retainerWidth, h=retainerLength, $fn=3, center=true); 
translate([-(length + wallThickness) / 2, 0, overallHeight / 2]) cube([wallThickness, retainerLength, retainerWidth], center=true);


translate([(width + retainerWidth) / 2, 0, overallHeight / 2]) rotate([90, -30, 0]) cylinder(r=retainerWidth, h=retainerLength, $fn=3, center=true); 
translate([(length + wallThickness) / 2, 0, overallHeight / 2]) cube([wallThickness, retainerLength, retainerWidth], center=true);
