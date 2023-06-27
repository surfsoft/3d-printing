$fn = 90;
screwDiameter = 3.5;

module screwTab(width, height, holeDiameter) {
    difference() {
        union() {
            cylinder(d=width, h=height, center=true);
            translate([width / 4, 0, 0]) cube([width / 2, width, height], center = true);
        };
        cylinder(d=holeDiameter, h=height, center=true);
    };
};

module innerCornerRadius(radius, depth) {
    difference() {
        cube([radius, radius, depth], center=true);
        translate([-radius / 2, -radius / 2, 0]) cylinder(r=radius, h=depth, center=true);
    };
};

module mountingPostV2(length, width, height, holeDiameter) {
    difference() {
        cube([length, width, height], center=true);
        rotate([90, 0, 0]) cylinder(d=holeDiameter, h=width, center=true);
    };
};


module mountVersion1() {

    servoMountLength = 5;
    servoMountWidth = 12;
    servoMountDepth = 2.5;
    servoTopHeight = 4;
    baseLength = 22.5;
    baseWidth  = (servoTopHeight * 2) + servoMountDepth;
    baseHeight = 3;

    // Base
    totalLength = baseLength + (2 * servoMountLength);
    cube([totalLength, baseWidth, baseHeight], center=true);
    translate([(totalLength + baseWidth) / 2, 0, 0])
        rotate([0, 0, 180])
            screwTab(baseWidth, baseHeight, screwDiameter);
    translate([-(totalLength + baseWidth) / 2, 0, 0])
        screwTab(baseWidth, baseHeight, screwDiameter);

    // Posts
    translate([(totalLength - servoMountLength) / 2, (baseWidth - servoTopHeight) / 2, (baseHeight + servoMountWidth) / 2])
        mountingPostV2(servoMountLength, servoTopHeight, servoMountWidth);
    translate([(totalLength + (servoTopHeight / 2)) / 2, (baseWidth - servoTopHeight) / 2, (baseHeight + servoTopHeight / 2) /2])
        rotate([-90, 0, 180])
            innerCornerRadius(servoTopHeight / 2, servoTopHeight);

    translate([-(totalLength - servoMountLength) / 2, (baseWidth - servoTopHeight) / 2, (baseHeight + servoMountWidth) / 2])
        mountingPostV2(servoMountLength, servoTopHeight, servoMountWidth);
    translate([-(totalLength + (servoTopHeight / 2)) / 2, (baseWidth - servoTopHeight) / 2, (baseHeight + servoTopHeight / 2) /2])
        rotate([-90, 0, 0])
            innerCornerRadius(servoTopHeight / 2, servoTopHeight);

};



module mountVersion2() {

    servoX = 23;
    servoY = 12.5;
    servoZ = 17.5;

    servoSidePlateX = 5;
    servoSidePlateY = 5;
    servoSidePlateZ = servoX;

    servoMountX = servoY + servoSidePlateX;
    servoMountY = 5;
    servoMountZ = 5;

    baseX = servoY + servoSidePlateX;
    baseY = servoZ + 20;
    baseZ = 5;

    screwDiameter = 3.5;
    screwHeadDiameter = 10;
    screwLength = 10;
    screwThreadDiameter = 2;

    smallRadius = 2;

    difference() {
        cube([baseX, baseY, baseZ], center = true);
        translate([servoSidePlateX, -(baseY - screwHeadDiameter) / 2, 0])
            cylinder(d=screwDiameter, h=baseZ, center=true);
        translate([servoSidePlateX, -((baseY - screwHeadDiameter) / 2) + screwHeadDiameter, 0])
            cylinder(d=screwDiameter, h=baseZ, center=true);
        translate([-servoSidePlateY / 2, (baseY - screwLength) / 2, 0])
            rotate([90, 0, 0])
                cylinder(d=screwThreadDiameter, h=screwLength, center=true);

    };

    translate([(baseX - servoSidePlateX) / 2, (baseY - servoSidePlateY) / 2, (baseZ + servoSidePlateZ) / 2])
        cube([servoSidePlateX, servoSidePlateY, servoSidePlateZ], center = true);

    translate([0, (baseY - servoMountY) / 2, servoSidePlateZ + servoMountZ])
        difference() {
            cube([servoMountX, servoMountY, servoMountZ], center = true);
            translate([-servoSidePlateY / 2, 0, 0])
                rotate([90, 0, 0])
                    cylinder(d=screwThreadDiameter, h=servoMountY, center=true);
        };

    translate([(baseX - servoSidePlateX) / 2, ((baseY - smallRadius) / 2) - servoMountY, (baseZ + smallRadius) / 2])
        rotate([-90, 0, 90])
            innerCornerRadius(smallRadius, servoSidePlateX);

};


module mountVersion3() {

    screwDiameter = 3.5;
    screwHeadDiameter = 10;
    screwThreadDiameter = 2;

    servoX = 23;
    servoY = 17.5;
    servoZ = 12.5;

    mountingPostX = 5;
    mountingPostY = 4;
    mountingPostZ = servoZ;

    baseX = servoX + (2 * mountingPostX);
    baseY = servoY + screwHeadDiameter;
    baseZ = 3;


    difference() {
        union() {
            translate([0, screwHeadDiameter / 4, 0])
                cube([baseX, baseY - (screwHeadDiameter / 2), baseZ], center=true);
            translate([0, -(baseY - screwHeadDiameter) / 2, 0])
                cube([baseX - screwHeadDiameter, screwHeadDiameter, baseZ], center = true);
            translate([(baseX - screwHeadDiameter) / 2, -(baseY - screwHeadDiameter) / 2, 0])
                cylinder(d=screwHeadDiameter, h=baseZ, center=true);
            translate([-(baseX - screwHeadDiameter) / 2, -(baseY - screwHeadDiameter) / 2, 0])
                cylinder(d=screwHeadDiameter, h=baseZ, center=true);
        };
        translate([(baseX - screwHeadDiameter) / 2, -(baseY - screwHeadDiameter) / 2, 0])
            cylinder(d=screwDiameter, h=baseZ, center=true);
        translate([-(baseX - screwHeadDiameter) / 2, -(baseY - screwHeadDiameter) / 2, 0])
            cylinder(d=screwDiameter, h=baseZ, center=true);

    };

    translate([(baseX - mountingPostX) / 2, (baseY - mountingPostY) / 2, (mountingPostZ + baseZ) / 2])
        mountingPostV2(mountingPostX, mountingPostY, mountingPostZ, screwThreadDiameter);
    translate([-(baseX - mountingPostX) / 2, (baseY - mountingPostY) / 2, (mountingPostZ + baseZ) / 2])
        mountingPostV2(mountingPostX, mountingPostY, mountingPostZ, screwThreadDiameter);


};

rotate([0,90,0])
    mountVersion2();