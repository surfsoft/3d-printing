// Radius values as follows:
// - 3rd radius setrack: 505mm
// - 4th radius setrack: 572mm
//
// - 3rd radius streamline: 505mm
// - 4th radius streamline: 556mm
// - 5th radius streamline: 607mm
// - 6th radius streamline: 658mm
// - 7th radius streamline: 709mm
// - 8th radius streamline: 760mm
// - 9th radius streamline: 811mm
// - 10th radius streamline: 862mm
//
// For some reason the rendered model is half the expected thickness. Needs investigating.

$fn=360;
radius = 556;
width  = 16.7;
height = 4.8;
angle  = 22.5;

outerRadius = radius + (width / 2);
innerRadius = radius - (width / 2);

translate([-radius, 0, 0])
intersection() {
    difference() {
        cylinder(r=outerRadius, h=height, center=true);
        cylinder(r=innerRadius, h=height, center=true);
    }
    difference() {
        rotate_extrude(angle=angle) square([outerRadius, height]);
        rotate_extrude(angle=angle) square([innerRadius, height]);

    }
}

