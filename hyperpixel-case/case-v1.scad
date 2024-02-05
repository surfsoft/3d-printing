/*
 * Notes
 *
 * - Screws to attach the display through to the case should be counter sunk (base of case needs an update for this)
 *
 * Parts list:
 * - 2.1" round HyperPixel Touch
 * - Raspbery Pi Zero 2
 * - Adafruit 1200mAh 3.7v LiPo
 * - Adafruit 1430 LiPo charger
 * - 4x 5mm 2.5mm dia button head self tapping screws (fixes USB charger PCB to insert)
 * - 4x 18mm ?mm dia countersunk bolts (holds everything together)
 *
 * Printer settings:
 * - 0.4mm hot end
 * - 0.2mm layer Z thinkness
 * - 0.4mm layer X/Y thickness
 * - Bottom wall 4 layers
 * - Top wall 3 layers
 * - Side walls 3 layers
 */

$fn=360;

outerDiameter = 80;
innerDiameter = 72;
edgeRadius = (outerDiameter - innerDiameter) / 2;

baseZ = 1.6;

batteryX = 64;
batteryY = 35;
batteryZ = 6.5;

separatorD = innerDiameter - 1;
separatorZ = 2;

pcbX = 31;
pcbY = 69;
pcbZ = 14;
pcbPosX = -1;
pcbPosY = 0;
pcbScrewX = 11.5;
pcbScrewY = 29;
pcbScrewDiameter = 3;
pcbScrewHeadDiameter = 6;
pcbScrewHeadZ = 2.5;

displayZ = 4;

usbPcbScrewLength = 5;
usbPcbX = 21;
usbPcbY = 20;
usbPcbZ = separatorZ + pcbZ - usbPcbScrewLength;
usbPcbPosX = (separatorD / 2) - (usbPcbX / 2);
usbPcbPosY = 0;
usbPcbPosZ = ((separatorZ + pcbZ) - usbPcbZ) / 2;
usbPcbScrewX = 7.5;
usbPcbScrewY = 7;
usbPcbScrewDiameter = 2.2;

usbX = edgeRadius * 2;
usbY = 12;
usbZ = 8;
usbXPos = (innerDiameter + edgeRadius) / 2;
usbYPos = 0;
usbZPos = usbPcbPosZ;

piSupportZ = 2;
piSupportD = pcbScrewDiameter + 4;
piSupportPosZ = -((separatorZ + pcbZ) / 2) + separatorZ + (piSupportZ / 2);

cableVoidX = separatorD / 2;
cableVoidY = (separatorD - usbPcbY) / 2;
cableVoidPosX = ((pcbX + cableVoidX) / 2) + pcbPosX;
cableVoidPosY = (pcbY - cableVoidY) / 2;

insertZ = separatorZ + pcbZ + displayZ;
upperVoidZ = usbPcbZ;
upperVoidPosZ = (separatorZ + pcbZ - upperVoidZ) / 2;

overallZ = baseZ + batteryZ + separatorZ + pcbZ + displayZ;

pcbScrewHeadOffsetZ = - (overallZ / 2) + 0.5;


module case() {
    difference() {
        
        // Outline of case
        union() {
            translate([0, 0, -(edgeRadius/2)]) cylinder(h=overallZ - edgeRadius, d=outerDiameter, center=true);
            translate([0, 0, (overallZ / 2) - edgeRadius]) 
                rotate_extrude() translate([innerDiameter / 2,0,0]) circle(edgeRadius, center = true);
        }
        
        // Interior void
        translate([0, 0, baseZ / 2]) union() {
            translate([0, 0, batteryZ / 2]) cylinder(h=insertZ, d=innerDiameter, center = true);
            translate([0, 0, -insertZ / 2]) cube([batteryX, batteryY, batteryZ], center = true);
        }
        
        // Screw holes
        translate([-pcbScrewX, -pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
        translate([-pcbScrewX, -pcbScrewY, pcbScrewHeadOffsetZ]) cylinder(h=pcbScrewHeadZ, d1=pcbScrewHeadDiameter, d2=pcbScrewDiameter, center=true);
        translate([-pcbScrewX, pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
        translate([-pcbScrewX, pcbScrewY, pcbScrewHeadOffsetZ]) cylinder(h=pcbScrewHeadZ, d1=pcbScrewHeadDiameter, d2=pcbScrewDiameter, center=true);
        translate([pcbScrewX, -pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
        translate([pcbScrewX, -pcbScrewY, pcbScrewHeadOffsetZ]) cylinder(h=pcbScrewHeadZ, d1=pcbScrewHeadDiameter, d2=pcbScrewDiameter, center=true);
        translate([pcbScrewX, pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
        translate([pcbScrewX, pcbScrewY, pcbScrewHeadOffsetZ]) cylinder(h=pcbScrewHeadZ, d1=pcbScrewHeadDiameter, d2=pcbScrewDiameter, center=true);
        
        // USB socket
        // TODO needs dropping down
        translate([usbXPos , usbYPos, usbZPos]) cube([usbX, usbY, usbZ], center=true);
        
    }
}

module insert() {
    difference() {
        union() {
            difference() {
        
                // Base form of insert
                cylinder(h=separatorZ + pcbZ, d=separatorD, center=true);
        
                // Void for PCB and Pi
                translate([pcbPosX, pcbPosY, separatorZ / 2]) cube([pcbX, pcbY + 10, pcbZ], center=true);
        
                // Void for USB charger PCB
                translate([usbPcbPosX, usbPcbPosY, usbPcbPosZ]) cube([usbPcbX, usbPcbY, usbPcbZ], center = true);
        
                // Fixing holes for USB charger PCB
                translate([usbPcbPosX - usbPcbScrewX, usbPcbPosY - usbPcbScrewY, usbPcbPosZ]) cylinder(h=overallZ, d=usbPcbScrewDiameter, center=true);
                translate([usbPcbPosX - usbPcbScrewX, usbPcbPosY + usbPcbScrewY, usbPcbPosZ]) cylinder(h=overallZ, d=usbPcbScrewDiameter, center=true);
                translate([usbPcbPosX + usbPcbScrewX, usbPcbPosY - usbPcbScrewY, usbPcbPosZ]) cylinder(h=overallZ, d=usbPcbScrewDiameter, center=true);
                translate([usbPcbPosX + usbPcbScrewX, usbPcbPosY + usbPcbScrewY, usbPcbPosZ]) cylinder(h=overallZ, d=usbPcbScrewDiameter, center=true);
        
            }
    
            // Add raised areas around each Pi screw hole to raise the Pi PCB off the insert by 2mm
            translate([-pcbScrewX, -pcbScrewY, piSupportPosZ]) cylinder(h=piSupportZ, d= piSupportD, center=true);
            translate([-pcbScrewX, pcbScrewY, piSupportPosZ]) cylinder(h=piSupportZ, d= piSupportD, center=true);
            translate([pcbScrewX, -pcbScrewY, piSupportPosZ]) cylinder(h=piSupportZ, d= piSupportD, center=true);
            translate([pcbScrewX, pcbScrewY, piSupportPosZ]) cylinder(h=piSupportZ, d= piSupportD, center=true);

        }
        
        // Screw holes
        translate([-pcbScrewX, -pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
        translate([-pcbScrewX, pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
        translate([pcbScrewX, -pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
        translate([pcbScrewX, pcbScrewY, 0]) cylinder(h=overallZ, d=pcbScrewDiameter, center=true);
    
        // Voids either side of the USB PCB
        translate([cableVoidPosX, cableVoidPosY, 0]) cube([cableVoidX, cableVoidY, overallZ], center = true);
        translate([cableVoidPosX, -cableVoidPosY, 0]) cube([cableVoidX, cableVoidY, overallZ], center = true);
        
        // Remove the void altogether on the side opposide the USB PCB
        translate([-cableVoidPosX, 0, 0]) cube([cableVoidX, separatorD, overallZ], center = true);
    }
}

case();

//insert();

