// List of radius and angle combinations to print
// Radius: 505, 556, 607, 658, 709
// Angle: 5, 10, 15, 20, 25, 30, 35 40
//
// List of straight lengths to print:
// 100, 150, 200, 250


$fn=360;
height = 3;
width  = 16.7;
letteringThickness = 1;
textSize = 5;


module curveTemplate(radius, angle) {
    
    outerRadius = radius + (width / 2);
    innerRadius = radius - (width / 2);

    translate([-radius, 0, 0])
    difference() {

        intersection() {
            difference() {
                cylinder(r=outerRadius, h=height);
                cylinder(r=innerRadius, h=height);
            }
            difference() {
                rotate_extrude(angle=angle) square([outerRadius, height]);
                rotate_extrude(angle=angle) square([innerRadius, height]);

            }
        }

        labelPosX = radius * cos(angle / 2) + 2;
        labelPosY = radius * sin(angle / 2);
        labelPosZ = height - letteringThickness;
    
        translate([labelPosX, labelPosY, labelPosZ]) rotate([0, 0, 90 + (angle / 2)])
            linear_extrude(height=letteringThickness) text(str("r=", radius,"mm / a=", angle, "º"), halign="center", size = textSize);
    }
    
}

module straightTemplate(length) {  

    letteringPosY = -(textSize / 2);
    letteringPosZ = (height / 2) - letteringThickness;

    difference() {
        cube([length, width, height], center = true);
        translate([0, letteringPosY, letteringPosZ])
            linear_extrude(height=letteringThickness) text(str("l=", length,"mm"), halign="center", size = textSize);
    }
    
}  



/*
 * To print (on an as-needed basis)
curveTemplate(505, 15);
curveTemplate(505, 20);
curveTemplate(505, 25);
curveTemplate(505, 30);
curveTemplate(505, 35);
curveTemplate(505, 40);
curveTemplate(556, 20);
curveTemplate(556, 35);
curveTemplate(556, 10);

 * Sizes to make
 *
 * Custom:
 * - curveTemplate(500, 35);
 * - curveTemplate(505, 13.2);
 * - curveTemplate(505, 17.2);
 * - curveTemplate(600, 9);
 * - curveTemplate(600, 22.2);
 * - curveTemplate(607, 18.2);
 * - curveTemplate(735, 13.2);
 * - curveTemplate(750, 8);
 * - curveTemplate(775, 15);
 * - curveTemplate(830, 15);
 * - curveTemplate(1000, 6);
 * - curveTemplate(1100, 7.6);
 * - curveTemplate(1100, 11.6);
 * - curveTemplate(1150, 5);
 * - curveTemplate(1150, 6);
 * - curveTemplate(1150, 12);
 * - curveTemplate(1195, 7.6);
 *
 * Combined curva and straight
 * - curveTemplate(1950, 7.6);
 * - translate([800, -45.5, 1.5]) rotate([0, 0, 90]) straightTemplate(91);
 * 
 * R505:
 * - curveTemplate(505, 10);
 *
 * R556:
 * - curveTemplate(556, 15);
 * - curveTemplate(556, 25);
 * - curveTemplate(556, 30);
 * - curveTemplate(556, 40);

//straightTemplate(250);
*/