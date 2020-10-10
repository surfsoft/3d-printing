drawerWidth = 100;
drawerDepth = 300;
dividerHeight = 80;
dividerBaseWidth = 4;
dividerTopWidth = 2;
slotSpacing = 80;
slotHeight = 30;
slotWidth = 2.5;

defaultThickness = 1;


module dividerEndBase(debOuterWidth = 30, 
                      debInnerWidth = 10, 
                      debThickness = defaultThickness) {

    translate([0, (debInnerWidth / 2), debThickness / 2]) 
      cube([debOuterWidth, debInnerWidth, debThickness], center = true);

    translate([0, debOuterWidth / 2, debThickness / 2]) 
      cube([debInnerWidth, debOuterWidth, debThickness], center = true);
    
    zAngle = atan((debOuterWidth - debInnerWidth) / (debOuterWidth - debInnerWidth) / 2);
    base = (debOuterWidth - debInnerWidth) / 2;
    hypotenuse = sqrt(pow(debOuterWidth - debInnerWidth, 2) + pow(base, 2));
    
    translate([-(debInnerWidth + ((debOuterWidth - debInnerWidth) / 2)) / 2, debInnerWidth + ((debOuterWidth - debInnerWidth) / 2), debThickness / 2]) rotate([0, 0, -zAngle]) translate([base / 2, 0, 0]) cube([base, hypotenuse, debThickness], center = true);

    translate([(debInnerWidth + ((debOuterWidth - debInnerWidth) / 2)) / 2, debInnerWidth + ((debOuterWidth - debInnerWidth) / 2), debThickness / 2]) rotate([0, 0, zAngle]) translate([-base / 2, 0, 0]) cube([base, hypotenuse, debThickness], center = true);                          
};

module dividerEnd(deHeight = 10, deDepth = 10, deWidth = 30, deThickness = defaultThickness) {
    translate([0, 0, 0]) dividerEndBase();
    translate([0, (deThickness / 2), deHeight / 2]) cube([deWidth, deThickness, deHeight], center = true);
};

module dividerBody(dbLength, dbHeight, dbBaseWidth = dividerBaseWidth, dbTopWidth = dividerTopWidth, dbBaseHeight = 10) {
    
    translate([0, 0, dbBaseHeight / 2]) cube([dbBaseWidth, dbLength, dbBaseHeight], center = true);
    translate([0, 0, dbBaseHeight + ((dbHeight - dbBaseHeight) / 2)]) cube([dbTopWidth, dbLength, dbHeight - dbBaseHeight], center = true);
    
    zAngle = atan((dbBaseWidth - dbTopWidth) / 2 / (dbHeight - dbBaseHeight));
    base = (dbBaseWidth - dbTopWidth) / 2;
    hypotenuse = sqrt(pow(dbHeight - dbBaseHeight, 2) + pow(base, 2));
    
    translate([dbBaseWidth - dbTopWidth, 0, dbBaseHeight + ((dbHeight - dbBaseHeight) / 2)]) 
    rotate([0, 90 - zAngle, 0]) 
    translate([0, 0, -base])
    cube([hypotenuse, dbLength, base], center = true);

    translate([-(dbBaseWidth - dbTopWidth), 0, dbBaseHeight + ((dbHeight - dbBaseHeight) / 2)]) 
    rotate([0, 90 + zAngle, 0]) 
    translate([0, 0, base])
    cube([hypotenuse, dbLength, base], center = true);

};

module verticalDivider(vdLength = drawerDepth, vdHeight = dividerHeight, vdSlotSpacing = slotSpacing, vdSlotWidth = slotWidth, vdSlotHeight = slotHeight) {
    difference() {
        union() {
            translate([0, - vdLength / 2, 0]) dividerEnd();
            dividerBody(vdLength, vdHeight);
            translate([0, vdLength / 2, 0]) rotate([0, 0, 180]) dividerEnd();
        };
        union() {
            slotCount = floor(vdLength / vdSlotSpacing) + 1;
            initialOffset = - (vdLength / 2) + (vdLength - ((slotCount - 1) * vdSlotSpacing)) / 2;
            for( slotNo = [ 0 : slotCount - 1]) {
                translate([0, initialOffset + (slotNo * vdSlotSpacing), vdHeight - (vdSlotHeight / 2)]) cube([dividerBaseWidth, vdSlotWidth, vdSlotHeight], center = true);
            };
        };
    };
};


module horizontalDivider(hdSlotCount, hdHeight = dividerHeight, hdWidth = dividerTopWidth, hdSlotSpacing = slotSpacing, hdSlotWidth = dividerBaseWidth, hdSlotHeight = dividerHeight - slotHeight + 1, hdEndThickness = defaultThickness, hdEndWidth = 30, hdEndHeight = 10) {
    
    length = (hdSlotSpacing * (hdSlotCount + 1)) + (hdSlotWidth * (hdSlotCount + 2)) + hdEndThickness;
    
    translate([- (length + hdEndThickness) / 2, 0, hdEndHeight / 2]) 
      cube([hdEndThickness, hdEndWidth, hdEndHeight], center = true);
    
    translate([0, 0, hdHeight / 2]) difference() {
        cube([length, hdWidth, hdHeight], center = true);
        translate([0, 0, (hdHeight - hdSlotHeight) / 2]) union() {
            translate([((hdSlotWidth + (hdEndThickness / 2)) / 2) - (length / 2), 0, 0]) cube([hdSlotWidth + (hdEndThickness / 2), hdSlotWidth, hdSlotHeight], center = true);
            for( slotNo = [ 1 : hdSlotCount]) {
                translate([(slotNo * (hdSlotSpacing + hdSlotWidth)) + (hdSlotWidth / 2) - (length / 2), 0, 0]) cube([hdSlotWidth, hdSlotWidth, hdSlotHeight], center = true);
            };
            translate([- ((hdSlotWidth + (hdEndThickness / 2)) / 2) + (length / 2), 0, 0]) cube([hdSlotWidth + (hdEndThickness / 2), hdSlotWidth, hdSlotHeight], center = true);
        };
    };
    
    translate([(length + hdEndThickness) / 2, 0, hdEndHeight / 2]) 
      cube([hdEndThickness, hdEndWidth, hdEndHeight], center = true);
};


horizontalDivider(3);
//verticalDivider();
