// Reduce this value for faster rendering (and lower quality curves)
$fn = 90; 

// Basic parameters
outerDiameter = 25;
innerDiameter = 8;
discThickness = 2;
letteringThickness = 0.5;
textSize = 5;


// Positions of the various items
letteringPosZ = (discThickness / 2) - letteringThickness;
trianglePosZ = (discThickness - letteringThickness) / 2;
zeroPosX = -12;
zeroPosY = -2.5;
fourPosX = 4.5;
fourPosY = -2.5;
icePosX = -1.3;
icePosY = -12;
iceTextX = -6;
iceTextY = 5;


module disc(outerDiameter = 25, innerDiameter = 8) {
    difference() {
        cylinder(d=outerDiameter, h=discThickness, center=true);
        cylinder(d=innerDiameter, h=discThickness, center=true);
    };
};

module warningTriangle(triangleSize = 8.5, lineThickness = 2, textSize = 6) {
    rotate([0, 0, 90]) difference() {
        cylinder(d=triangleSize, h=letteringThickness, $fn=3, center=true);
        cylinder(d=triangleSize - lineThickness, h=letteringThickness, $fn=3, center=true);
    };
    translate([0, -textSize / 4.2, -letteringThickness / 2]) linear_extrude(height = letteringThickness) {
    text("*", size = textSize, halign = "center", valign = "center", $fn = 16);
  }
};


// Difference renders the first item and then subtracts all the others from it...
difference() {
    
    // The disc
    disc();
    
    // "<0"
    translate([zeroPosX, zeroPosY, letteringPosZ]) linear_extrude(height=letteringThickness) text("<0", size = textSize);
    
    // "<4"
    translate([fourPosX, fourPosY, letteringPosZ]) 
      linear_extrude(height=letteringThickness) text("<4", size = textSize);
    
    // "ICE"
    translate([iceTextX, iceTextY, letteringPosZ]) linear_extrude(height=letteringThickness) text("ICE", size = textSize);
    
    // Warning triangle
    translate([0, -(innerDiameter / 2) - ((outerDiameter - innerDiameter) / 4) - 0.5, trianglePosZ]) warningTriangle();      
};
