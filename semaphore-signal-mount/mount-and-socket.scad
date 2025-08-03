module driverPcb(servoCount) {

    depth = servoCount * 21;
    componentsWidth = 11;
    componentsDepth = depth;
    componentsHeight = 4;
    pcbWidth = 15;
    pcbDepth = depth;
    pcbHeight = 1.8;
    backWidth = 11;
    backDepth = depth;
    backHeight = 2;
    
    translate([0, 0, (componentsHeight + pcbHeight) / 2]) cube([componentsWidth, componentsDepth, componentsHeight], center = true);
    cube([pcbWidth, pcbDepth, pcbHeight], center = true);
    translate([0, 0, -(backHeight + pcbHeight) / 2]) cube([backWidth, backDepth, backHeight], center = true);

}

module servo(servoCount) {

    moduleHeight = 21;
    depth = servoCount * moduleHeight;
    backWidth = 11;
    backDepth = depth;
    backHeight = 2.5;
    pcbWidth = 15.5;
    pcbDepth = depth;
    pcbHeight = 0.75;
    servoWidth = 12;
    servoDepth = depth;
    servoHeight = 8.5;
    
    translate([0, 0, (backHeight + pcbHeight) / 2]) cube([backWidth, backDepth, backHeight], center = true);
    cube([pcbWidth, pcbDepth, pcbHeight], center = true);
    translate([0, 0, -(servoHeight + pcbHeight) / 2]) cube([servoWidth, servoDepth, servoHeight], center = true);

}




module rodHole(baseThickness = 3) {
    cube([7, baseThickness, 3], center=true);
}


module mount(mountWidth, mountHeight, servoCount) {

    moduleHeight = 21;
    mountTop = 3;
    mountDepth = (moduleHeight * servoCount) + mountTop;

    difference() {
        cube([mountWidth, mountDepth, mountHeight], center = true);
        translate([0, (mountDepth - mountTop) / 2, -(mountHeight - 3) / 2]) rodHole(mountTop);
        union() {
            translate([0, -mountTop / 2, -0.4]) servo(servoCount);
            translate([0, -mountTop / 2, 4.36]) driverPcb(servoCount);
        }
    }
    
}

module mountSocket(mountWidth, mountHeight) {
    difference() {
        union() {
            cube([mountWidth + 5, mountHeight+ 5, 1], center=true);
            translate([0, 0, 5]) cube([mountWidth + 3, mountHeight + 3, 10], center=true);
        }
        translate([0, 0, 5]) cube([mountWidth + 0.4, mountHeight + 0.4, 15], center=true);
    }
}

mountWidth = 17;
mountHeight = 18.5;


//mountSocket(mountWidth, mountHeight);
translate([0, 0, -5]) rotate([-90, 0, 0]) mount(mountWidth, mountHeight, 2);