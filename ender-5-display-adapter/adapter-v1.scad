$fn=90;

module post(postInnerDiameter = 6, postHeight = 7, frameHeight = 2) {

    postTopHeight = 2;
    screwDiameter = 4;
    postOuterDiameter = postInnerDiameter + 4;

    difference() {
        union() {
            cylinder(d=postOuterDiameter, h=postHeight, center=true);
            translate([postOuterDiameter / 4, postOuterDiameter / 4, -(postHeight - frameHeight) / 2])
              cube([postOuterDiameter / 2, postOuterDiameter / 2, frameHeight], center=true);
        }
        cylinder(d=postInnerDiameter, h=postHeight, center=true); 
    }
    translate([0, 0, (postHeight + postTopHeight) / 2])
    difference() {
        cylinder(d=postOuterDiameter, h=postTopHeight, center=true);
        cylinder(d1=postInnerDiameter, d2=screwDiameter, h=postTopHeight, center=true);
    }
    
        
};

/*
 * Dimensions and location of the void match the cut-out for the screen.
 */
module enclosureMount() {
    
    windowX = 96;
    windowY = 54;
    postXSpacing = 115;
    postYSpacing = 66;
    postOuterDiameter = 10;
    postHeight = 7;
    frameHeight = 2;
    fraweWidth = postOuterDiameter / 2;

    
    difference() {
        union() {
            translate([-postXSpacing / 2, -postYSpacing/ 2, 0]) post();
            translate([postXSpacing / 2, -postYSpacing/ 2, 0]) rotate([0, 0, 90]) post();
            translate([-postXSpacing / 2, postYSpacing/ 2, 0]) rotate([0, 0, 270]) post();
            translate([postXSpacing / 2, postYSpacing/ 2, 0]) rotate([0, 0, 180]) post();
    
            translate([0, -(postYSpacing - fraweWidth)/ 2,  -(postHeight - frameHeight) / 2])
              cube([postXSpacing - postOuterDiameter, fraweWidth, frameHeight], center=true);
            translate([0, (postYSpacing - fraweWidth)/ 2,  -(postHeight - frameHeight) / 2])
              cube([postXSpacing - postOuterDiameter, fraweWidth, frameHeight], center=true);

            translate([-(postXSpacing - fraweWidth)/ 2, 0,  -(postHeight - frameHeight) / 2])
              cube([fraweWidth, postYSpacing - postOuterDiameter, frameHeight], center=true);
            translate([(postXSpacing - fraweWidth)/ 2, 0,  -(postHeight - frameHeight) / 2])
              cube([fraweWidth, postYSpacing - postOuterDiameter, frameHeight], center=true);
            
            //translate([0, 0, -(postHeight - frameHeight) / 2])
             // cube([postXSpacing - postOuterDiameter, postYSpacing - postOuterDiameter, frameHeight], center=true);
        }
        translate([0, 1, -(postHeight - frameHeight) / 2])
          cube([windowX, windowY, frameHeight], center=true);
    }
        
}





module moduleMount() {

    moduleBorderWidth = 1;
    moduleBorderHeight = 9;
    pcbHeight = 1.7;
    moduleXSize = 110;
    moduleYSize = 56;
    screenXSize = 85;
    screenYSize = 56;
    screenHeight = 5;
    screenBorderLeft = 6.5;
    screenBorderRight = 18.5;
    viewableXSize = 75;
    viewableYSize = 51.5;
    viewableHeight = moduleBorderHeight - pcbHeight - screenHeight;
    viewableBorderLeft = screenBorderLeft + 1.5;
    viewableBorderRight = screenBorderRight + 8;
    controlRightMargin = 10;
    resetButtonBottomMargin = 7;
    resetBodyHeight = 4.5;
    resetBodyDiameter = 10;
    resetButtonHeight = moduleBorderHeight - pcbHeight - resetBodyHeight;
    resetButtonDiameter = 4.5;
    controlDialBottomMargin = 25;
    controlDialDiameter = 8;
    controlDialBaseDiameter = 18;
    controlDialBaseHeight = 6.2;
    speakerBottomMargin = 43;
    speakerDiameter = 12;
    speakerHeight = 5.5;
    screwHoleXCentre = 104;
    screwHoleYCentre = 50;    
    screwHoleDiameter = 3;
    screwHoleHeight = moduleBorderHeight - pcbHeight - 2;

    translate([((moduleXSize + (moduleBorderWidth * 2)) / 2) + 1, 0, 0])
      cube([2, moduleYSize + (moduleBorderWidth * 2), moduleBorderHeight], center=true);
      
    difference() {
        cube([moduleXSize + (moduleBorderWidth * 2), moduleYSize + (moduleBorderWidth * 2), moduleBorderHeight], center=true);
        
        // PCB
        translate([0, 0, (moduleBorderHeight - pcbHeight) / 2])
          cube([moduleXSize, moduleYSize, pcbHeight], center=true);
        
        // Display
        translate([-(screenBorderRight - screenBorderLeft) / 2, 0, ((moduleBorderHeight - screenHeight) / 2 ) - pcbHeight])
          cube([screenXSize, screenYSize, screenHeight], center = true);
        
        // Display viewable area
        translate([-(viewableBorderRight - viewableBorderLeft) / 2, 0, -(moduleBorderHeight - viewableHeight) / 2])
        translate([0, 0, 0]) 
          cube([viewableXSize, viewableYSize, viewableHeight], center=true);
            

        // Reset button
        translate([(moduleXSize / 2) -  controlRightMargin, (moduleYSize / 2) - resetButtonBottomMargin, 0])
          cylinder(d=resetButtonDiameter, h=moduleBorderHeight, center=true);

        // Reset button base
        translate([(moduleXSize / 2) -  controlRightMargin, (moduleYSize / 2) - resetButtonBottomMargin, ((moduleBorderHeight - resetBodyHeight) / 2) - pcbHeight])
          cylinder(d=resetBodyDiameter, h=resetBodyHeight, center=true);

        // Control dial
        translate([(moduleXSize / 2) -  controlRightMargin, (moduleYSize / 2) - controlDialBottomMargin, 0])
          cylinder(d=controlDialDiameter, h=moduleBorderHeight, center=true);

        // Control dial base
        translate([(moduleXSize / 2) -  controlRightMargin, (moduleYSize / 2) - controlDialBottomMargin, ((moduleBorderHeight - controlDialBaseHeight) / 2) - pcbHeight])
          cylinder(d=controlDialBaseDiameter, h=controlDialBaseHeight, center=true);
        
        // Speaker void
        translate([(moduleXSize / 2) -  controlRightMargin, (moduleYSize / 2) - speakerBottomMargin, ((moduleBorderHeight - speakerHeight) / 2) - pcbHeight])
          cylinder(d=speakerDiameter, h=speakerHeight, center=true);

        // Screw holes
        for (x = [ -screwHoleXCentre / 2, screwHoleXCentre, screwHoleXCentre / 2]) {
            for (y = [ -screwHoleYCentre / 2, screwHoleYCentre, screwHoleYCentre / 2]) {
                translate([x, y, (moduleBorderHeight - screwHoleHeight) / 2])
                cylinder(d=screwHoleDiameter, h=screwHoleHeight, center=true);
            }
        }
        
        
    }
    
}

enclosureMount();
translate([-1.25, 0, 1]) moduleMount();











