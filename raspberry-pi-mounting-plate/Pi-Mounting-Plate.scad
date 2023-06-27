$fn=90;

module riser(riserHeight, outerRadius, innerRadius) {
    difference() {
        cylinder(r=outerRadius, h=riserHeight, center=true);
        cylinder(r=innerRadius, h=riserHeight, center=true);
    };
}

module riserSet(xCenter, yCenter, xOffset, yOffset, zOffset, riserHeight, outerRadius, innerRadius) {
    
    for (x=[-xOffset, xOffset]) {
        for (y=[-yOffset, yOffset]) {
            translate([xCenter + x, yCenter + y, zOffset]) riser(riserHeight, outerRadius, innerRadius);
        }
    }
}

module screwHole(depth, radius) {
    cylinder(h=depth, r=radius, center=true);
}

module screwHoleSet(xCenter, yCenter, zCenter, xOffset, yOffset, depth, radius) {
    for (x=[-xOffset, xOffset]) {
        for (y=[-yOffset, yOffset]) {
            translate([xCenter + x, yCenter + y, zCenter]) screwHole(depth, radius);
        }
    }
}


module roundedRectangle(xSize, ySize, zSize, radius) {
    cube([xSize - (radius * 2), ySize - (radius * 2), zSize], center=true);
    translate([0, (ySize - radius) / 2, 0]) cube([xSize - (radius * 2), radius, zSize], center=true);
    translate([0, -(ySize - radius) / 2 , 0]) cube([xSize - (radius * 2), radius, zSize], center=true);
    translate([(xSize - radius) / 2, 0, 0]) cube([radius, ySize - (radius * 2), zSize], center=true);
    translate([-(xSize - radius) / 2, 0, 0]) cube([radius, ySize - (radius * 2), zSize], center=true);
    translate([(xSize / 2) - radius, (ySize / 2) - radius, 0]) cylinder(r=radius, h=zSize, center=true);
    translate([(xSize / 2) - radius, -((ySize / 2) - radius), 0]) cylinder(r=radius, h=zSize, center=true);
    translate([-((xSize / 2) - radius), (ySize / 2) - radius, 0]) cylinder(r=radius, h=zSize, center=true);
    translate([-((xSize / 2) - radius), -((ySize / 2) - radius), 0]) cylinder(r=radius, h=zSize, center=true);
};


piX = 85;
piY = 56.5;

breakoutX = 40;
breakoutY = 56.5;

extensionX = 10;

baseX=piX + breakoutX + extensionX + 30;
baseY=piY + 20;

baseThickness=2.5;
screwRadius=1.7;
threadRadius=1.6;
cornerRadius=5;

riserHeight=5;
riserZ=(baseThickness + riserHeight) / 2;
riserRadius=4.5;


difference() {
    roundedRectangle(baseX, baseY, baseThickness, cornerRadius);
    screwHoleSet(0, 0, 0, (baseX - 10) / 2, (baseY - 10) / 2, baseThickness, screwRadius);
    
    translate([-(breakoutX / 2), 0, 0]) roundedRectangle(piX, piY - 20, baseThickness, cornerRadius);
    translate([(piX / 2)  + extensionX, 0, 0]) roundedRectangle(breakoutX, breakoutY - (riserRadius * 4), baseThickness, cornerRadius);

    screwHoleSet(-(piX + extensionX + 10) / 2, (baseY - 20) / 2, 0, 5, 5, baseThickness, 2.5);
    
    screwHoleSet(-(breakoutX / 2) + extensionX, 0, 58 / 2, 49 / 2, baseThickness, threadRadius);
    
}

riserSet(-(breakoutX / 2) + extensionX, 0, 58 / 2, 49 / 2, riserZ, riserHeight, riserRadius, threadRadius);
riserSet(((piX + extensionX) / 2) + 5, 0, (breakoutX - 10) / 2, (breakoutY - 10) / 2, riserZ, riserHeight, riserRadius, threadRadius);