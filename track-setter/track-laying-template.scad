railWidth = 1.1;
railCentres = 17.5;
railToPlatformHeight = 12;
trackCentreToPlatformEdge = 19.75;
trackCentreToSleeper = 14.75;
trackToTrackCentre = 50;

topWidth = trackCentreToPlatformEdge + trackToTrackCentre + trackCentreToPlatformEdge + 10;
topHeight = 25;

middleWidth = trackCentreToPlatformEdge + trackToTrackCentre + trackCentreToPlatformEdge;
middleHeight = railToPlatformHeight;

bottomWidth = trackCentreToSleeper + trackToTrackCentre + trackCentreToSleeper;
bottomHeight = 1.2;


templateThickness = 3;

// top part of template
module templateTop() {
cube([topWidth, topHeight, templateThickness], center = true);
    
}

// middle part of template
module templateMiddle() {
cube([middleWidth, middleHeight, templateThickness], center = true);
}

// Track part of template
module templateBottom() {
difference() {
    cube([bottomWidth, bottomHeight, templateThickness], center = true);
    translate([-trackToTrackCentre / 2, 0, 0])
    union() {
        translate([-railCentres / 2, 0, 0]) cube([railWidth, bottomHeight, templateThickness], center = true);
        translate([railCentres / 2, 0, 0]) cube([railWidth, bottomHeight, templateThickness], center = true);
    }
    translate([trackToTrackCentre / 2, 0, 0])
    union() {
        translate([-railCentres / 2, 0, 0]) cube([railWidth, bottomHeight, templateThickness], center = true);
        translate([railCentres / 2, 0, 0]) cube([railWidth, bottomHeight, templateThickness], center = true);
    }
}
}


translate([0, (middleHeight / 2) + (topHeight / 2), 0]) templateTop();
translate([0, 0, 0]) templateMiddle();
translate([0, -(middleHeight / 2) - (bottomHeight / 2), 0]) templateBottom();