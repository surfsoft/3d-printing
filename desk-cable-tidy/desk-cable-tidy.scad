backplaneLength = 300;
backplaneInnerWidth = 10;
backplaneOuterWidth = 20;
backplaneBaseHeight = 6;
backplaneTopHeight = 6;

accessoryMountDepth = 6;
accessoryMountHeight = backplaneBaseHeight + backplaneTopHeight + accessoryMountDepth;


screwSpacing = 60;
screwDiameter = 4.5;
headDiameter = 9;
headDepth = 4.5;
screwDepth = backplaneBaseHeight + backplaneTopHeight;



module screwHole() {
    
    cylinder(h=screwDepth, d=screwDiameter, center = true, $fn=90);
    translate([0, 0, (screwDepth - headDepth) / 2]) cylinder(h=headDepth, r1=screwDiameter / 2, r2=headDiameter / 2, center = true, $fn=90);
    
};

module backplane() {
    difference() {
        union() {
           translate([0, 0, -backplaneTopHeight / 2])  cube([backplaneLength, backplaneOuterWidth, backplaneTopHeight], center = true);
            translate([0, 0, backplaneBaseHeight / 2]) cube([backplaneLength, backplaneInnerWidth,  backplaneBaseHeight], center = true);
        };
        union() {
            screwCount = floor(backplaneLength / screwSpacing);
            initialOffset = - (backplaneLength / 2) + (backplaneLength - ((screwCount - 1) * screwSpacing)) / 2;
            for( screwNo = [ 0 : screwCount - 1]) {
                translate([initialOffset + (screwNo * screwSpacing), 0, 0]) rotate([180, 0, 0]) screwHole();
            };
        };
    };
};

module accessoryMount(accessoryMountWidth = 10) {
    
    difference() {
        translate([0, 0, - accessoryMountDepth / 2]) cube([accessoryMountWidth, backplaneOuterWidth + (2 * accessoryMountDepth), accessoryMountHeight], center = true);
        union() {
           translate([0, 0, -backplaneTopHeight / 2])  cube([backplaneLength, backplaneOuterWidth + 1, backplaneTopHeight], center = true);
            translate([0, 0, backplaneBaseHeight / 2]) cube([backplaneLength, backplaneInnerWidth + 1,  backplaneBaseHeight + 1], center = true);
        };
    };
};

module cableTidy(additionalSpace) {
    accessoryMountWidth = 10;    
    outerDiameter = (backplaneOuterWidth + (2 * accessoryMountDepth));
    innerDiameter = outerDiameter - accessoryMountDepth;
    translate([0, 0, (accessoryMountHeight + backplaneBaseHeight) / 2]) accessoryMount();    
    if (additionalSpace > 0) {
        translate([0, (outerDiameter - (accessoryMountDepth / 2)) / 2, -additionalSpace / 2]) 
          cube([accessoryMountWidth, accessoryMountDepth / 2, additionalSpace], center = true);
        translate([0, -(outerDiameter - (accessoryMountDepth / 2)) / 2, -additionalSpace / 2]) 
          cube([accessoryMountWidth, accessoryMountDepth / 2, additionalSpace], center = true);
    }
    translate([0, 0, -additionalSpace]) rotate([-90, 0, 0]) intersection() {
        translate([0, outerDiameter / 4, 0]) cube([accessoryMountWidth, outerDiameter / 2, outerDiameter], center = true);
        rotate([0, 90, 0]) difference() {
            cylinder(h=accessoryMountWidth, d=outerDiameter, center = true, $fn=90);
            cylinder(h=accessoryMountWidth, d=innerDiameter, center = true, $fn=90);
        };
    };

};

module cableTidySmall() {
    cableTidy(0);
};

module cableTidyMedium() {
    cableTidy(12.5);
};

module cableTidyLarge() {
    cableTidy(25);
};

module strapHolder(strapWidth) {
    slotHeight = 5;
    slotLength = backplaneOuterWidth + (2 * accessoryMountDepth);
    mountWidth = strapWidth + 2 + accessoryMountDepth;
    translate([0, 0, (accessoryMountHeight + backplaneBaseHeight) / 2]) accessoryMount(mountWidth);
    translate([(mountWidth - (accessoryMountDepth / 2)) / 2, 0, -slotHeight / 2]) cube([accessoryMountDepth / 2, slotLength, slotHeight], center = true);
    translate([-(mountWidth - (accessoryMountDepth / 2)) / 2, 0, -(slotHeight / 2)]) cube([accessoryMountDepth / 2, slotLength, slotHeight], center = true);
    translate([0, 0, - slotHeight - (accessoryMountDepth / 4)]) cube([mountWidth, slotLength, accessoryMountDepth / 2], center = true);    
};


backplane();
translate([-125,0,-12]) cableTidyLarge();
translate([-100,0,-12]) cableTidyMedium();
translate([-75,0,-12]) cableTidySmall();
translate([-47,0,-12]) strapHolder(13);
translate([0,0,-12]) strapHolder(32);