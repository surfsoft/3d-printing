drawerWidth = 530;
drawerDepth = 440;
dividerHeight = 60;
dividerBaseWidth = 4;
dividerTopWidth = 2;
slotSpacing = 80;
slotHeight = 25;
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

module verticalDividerEnd(deHeight = 10, deDepth = 10, deWidth = 30, deThickness = defaultThickness) {
    translate([0, 0, 0]) dividerEndBase();
    translate([0, (deThickness / 2), deHeight / 2]) cube([deWidth, deThickness, deHeight], center = true);
};

module verticalDividerBody(dbLength, dbHeight, dbBaseWidth = dividerBaseWidth, dbTopWidth = dividerTopWidth, dbBaseHeight = 10) {
    
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

module verticalDivider(vdLength = drawerDepth, vdHeight = dividerHeight, vdSlotCount = 0, vdSlotOffset = 0, vdSlotSpacing = slotSpacing, vdSlotWidth = slotWidth, vdSlotHeight = slotHeight) {
    difference() {
        union() {
            translate([0, - vdLength / 2, 0]) verticalDividerEnd();
            verticalDividerBody(vdLength, vdHeight);
            translate([0, vdLength / 2, 0]) rotate([0, 0, 180]) verticalDividerEnd();
        };
        union() {
            for( slotNo = [ 0 : vdSlotCount - 1]) {
                translate([0, (slotNo * vdSlotSpacing) + vdSlotOffset - (vdLength / 2), vdHeight - (vdSlotHeight / 2)]) cube([dividerBaseWidth, vdSlotWidth, vdSlotHeight], center = true);
            };
        };
    };
};

module horizontalDividerEnd(hdeThickness = defaultThickness, hdeWidth = 30, hdeHeight = 10) {
    cube([hdeThickness, hdeWidth, hdeHeight], center = true);
};

module horizontalDividerBody(hdbLength, hdbWidth = dividerTopWidth, hdbHeight = dividerHeight, hdbTabWidth = dividerTopWidth, hdbTabHeight = slotHeight) {
    difference() {
        cube([hdbLength, hdbWidth, hdbHeight], center = true);    
        union() {
            translate([(-hdbLength + hdbTabWidth) / 2, 0, (hdbTabHeight + 1) / 2]) 
              cube([hdbTabWidth, hdbWidth, hdbHeight - hdbTabHeight + 1.5], center = true);
            translate([(hdbLength - hdbTabWidth) / 2, 0, (hdbTabHeight + 1) / 2]) 
              cube([hdbTabWidth, hdbWidth, hdbHeight - hdbTabHeight + 1.5], center = true);
        };
    };
};


module horizontalDivider(hdLength = drawerWidth, hdSlotCount = 0, hdHeight = dividerHeight, hdWidth = dividerTopWidth, hdSlotSpacing = slotSpacing, hdSlotOffset = 0, hdSlotWidth = dividerBaseWidth, hdSlotHeight = dividerHeight - slotHeight + 1, hdEndThickness = defaultThickness, hdEndWidth = 30, hdEndHeight = 10, hdTopWidth = dividerTopWidth) {
    
    length = hdLength + hdWidth;
    
    translate([- (length + hdEndThickness) / 2, 0, hdEndHeight / 2]) horizontalDividerEnd();

    translate([0, 0, hdHeight / 2]) 
    difference() {
        horizontalDividerBody(hdbLength = length);
        union() {
        if (hdSlotCount > 0) {
            for( slotNo = [ 0 : hdSlotCount - 1]) {
                translate([- (length / 2) + hdSlotOffset + (slotNo * hdSlotSpacing), 0, (hdHeight - hdSlotHeight) / 2]) 
                  cube([hdSlotWidth, hdWidth, hdSlotHeight], center = true);
            };
        };
    };
    };
    
    translate([(length + hdEndThickness) / 2, 0, hdEndHeight / 2]) horizontalDividerEnd();
};

module assembledDesign() {
translate([0, 220, 0]) {
    translate ([0, 0, 0]) 
      verticalDivider(vdSlotCount = 2, vdSlotOffset = 110, vdSlotSpacing = 80);
    translate ([80, 95, 0]) 
      verticalDivider(vdLength = 250);
    translate ([160, 95, 0]) 
      verticalDivider(vdLength = 250);
    translate ([240, 55, 0]) 
      verticalDivider(vdLength = 330, vdSlotCount = 2, vdSlotOffset = 80, vdSlotSpacing = 85);
    translate ([410, 0, 0]) 
      verticalDivider(vdSlotCount = 2, vdSlotOffset = 110, vdSlotSpacing = 165);
    translate ([530, 0, 0]) 
      verticalDivider(vdSlotCount = 0);
};

translate([265, 0, 0]) {
    translate([205, 0, dividerHeight]) rotate([180, 0, 0]) 
      horizontalDivider(hdLength = 120);
    translate([-60, 110, dividerHeight]) rotate([180, 0, 0]) 
      horizontalDivider(hdLength = 410, hdSlotCount = 1, hdSlotOffset = 240);
    translate([-145, 190, dividerHeight]) rotate([180, 0, 0]) 
      horizontalDivider(hdLength = 240, hdSlotCount = 2, hdSlotOffset = 80, hdSlotSpacing = 80);
    translate([60, 275, dividerHeight]) rotate([180, 0, 0]) 
      horizontalDivider(hdLength = 170);
    translate([-145, 440, dividerHeight]) rotate([180, 0, 0]) 
      horizontalDivider(hdLength = 240, hdSlotCount = 2, hdSlotOffset = 80, hdSlotSpacing = 80);
    translate([205, 440, dividerHeight]) rotate([180, 0, 0]) 
      horizontalDivider(hdLength = 120);
};
};


/*
// 1
verticalDivider(vdSlotCount = 2, vdSlotOffset = 110, vdSlotSpacing = 80);
// 2
verticalDivider(vdLength = 250);
// 1
verticalDivider(vdLength = 330, vdSlotCount = 2, vdSlotOffset = 80, vdSlotSpacing = 85);
// 1
verticalDivider(vdSlotCount = 2, vdSlotOffset = 110, vdSlotSpacing = 165);
// 1
verticalDivider(vdSlotCount = 0);
// 2
horizontalDivider(hdLength = 120);
// 1
horizontalDivider(hdLength = 410, hdSlotCount = 1, hdSlotOffset = 240);
// 2
horizontalDivider(hdLength = 240, hdSlotCount = 2, hdSlotOffset = 80, hdSlotSpacing = 80);
// 1
horizontalDivider(hdLength = 170);
*/

assembledDesign();